using EasyNetQ;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using SigmaMarketing.Core.Data;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Exceptions;
using SigmaMarketing.Core.Helper.enums;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Configuration;
using SigmaMarketing.Model.Models.Email;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Request.SigmaToken;
using SigmaMarketing.Model.Models.Request.Validators;
using SigmaMarketing.Model.Models.Response;
using SigmaMarketing.Paypal.Client;
using SigmaMarketing.Paypal.Model.Response;

namespace SigmaMarketing.Infrastructure.Services
{
    public class SigmaTokenService : ISigmaTokenService
    {
        private readonly PaypalClientApi _paypalClientApi;
        private readonly ApplicationDbContext _context;
        private readonly IUserContextService _userContextService;
        private readonly ICampaignCompanyService _campaignCompanyService;
        private readonly INotificationService _notificationService;

        public SigmaTokenService(
            ApplicationDbContext context, 
            IUserContextService userContextService, 
            IOptions<AppSettings> appSettings, 
            ICampaignCompanyService campaignCompanyService, 
            INotificationService notificationService
            )
        {
            string baseUrl = appSettings.Value.PaypalBaseUrl;
            string clientId = appSettings.Value.PaypalClientId;
            string clientSecret = appSettings.Value.PaypalClientSecret;

            _paypalClientApi = new PaypalClientApi(baseUrl, clientId, clientSecret);
            _context = context;
            _userContextService = userContextService;
            _campaignCompanyService = campaignCompanyService;
            _notificationService = notificationService;
        }

        public async Task<List<SigmaTokenResponse>> GetSigmaTokensPackagesAsync()
        {
            try
            {
                var sigmaTokens = await _context.SigmaTokens.ToListAsync();

                if (sigmaTokens == null)
                {
                    return null;
                }

                var sigmaTokensVM = new List<SigmaTokenResponse>();
                foreach (var sigmaToken in sigmaTokens)
                {
                    sigmaTokensVM.Add(new SigmaTokenResponse
                    {
                        Id = sigmaToken.Id,
                        PackageName = sigmaToken.PackageName,
                        Amount = sigmaToken.Amount,
                        Price = sigmaToken.Price
                    });
                }

                return sigmaTokensVM;
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while getting sigma token packages!");
            }
        }

        //public async Task<OrderResponse> GetOrderDetails(string orderId)
        //{
        //    try
        //    {
        //        var isAuthorized = await _paypalClientApi.AuthorizeClient();
        //        if (!isAuthorized)
        //        {
        //            return null;
        //        }

        //        var orderDetails = await _paypalClientApi.GetOrderDetails(orderId);

        //        return orderDetails;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        public async Task<bool?> PurchaseTokensAsync(PurchaseRequest purchaseRequest)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();

                var isAuthorized = await _paypalClientApi.AuthorizeClient();
                if (!isAuthorized)
                {
                    return null;
                }

                var orderDetails = await _paypalClientApi.GetOrderDetails(purchaseRequest.OrderId);

                if (orderDetails == null)
                {
                    return null;
                }

                // Check for payer id
                if (purchaseRequest.PayerId != orderDetails.Payer.PayerId)
                {
                    return null;
                }

                // Check database for order id
                var order = await _context.Orders.FirstOrDefaultAsync(x => x.PaypalOrderId == purchaseRequest.OrderId);
                if (order != null)
                {
                    return null;
                }

                // Get user
                var user = await _context.Users.FirstOrDefaultAsync(x => x.Id == userId);
                if (user == null)
                {
                    return null;
                }

                // Get price
                if (orderDetails.PurchaseUnits.Count == 0)
                {
                    return null;
                }
                var priceString = orderDetails.PurchaseUnits[0].Amount.Breakdown.ItemTotal.Value;
                var price = double.Parse(priceString);

                // Find sigma token package and get ammount
                var sigmaToken = await _context.SigmaTokens.FirstOrDefaultAsync(x => x.Price == price);
                if (sigmaToken == null)
                {
                    return null;
                }

                // Update user balance
                user.Balance += sigmaToken.Amount;

                // Purchase successful, save order
                var orderEntity = new Order
                {
                    Created = DateTime.UtcNow,
                    CreatedBy = userId.ToString(),
                    LastModified = DateTime.UtcNow,
                    LastModifiedBy = userId.ToString(),
                    PaypalOrderId = orderDetails.Id,
                    OrderStatus = 1,
                    Type = "Purchase",
                    Price = price,
                    Quantity = sigmaToken.Amount,
                    BrandId = userId,
                    PaypalGivenName = orderDetails.Payer.Name.GivenName,
                    PaypalSurname = orderDetails.Payer.Name.Surname,
                    PaypalEmailAddress = orderDetails.Payer.EmailAddress,
                    PaypalPayerId = orderDetails.Payer.PayerId,
                    PaypalIntent = orderDetails.Intent,
                    PaypalStatus = orderDetails.Status,
                    PaypalCurrencyCode = orderDetails.PurchaseUnits[0].Amount.CurrencyCode,
                    PaypalValue = orderDetails.PurchaseUnits[0].Amount.Breakdown.ItemTotal.Value
                };

                _context.Orders.Add(orderEntity);
                await _context.SaveChangesAsync();

                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<bool> WithdrawAsync(WithdrawRequest withdrawRequest)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();

                // Get user balance
                var user = await _context.Users.FirstOrDefaultAsync(x => x.Id == userId);
                if (user == null)
                {
                    return false;
                }

                var paypalEmailAddress = user.PaypalEmail;
                if(string.IsNullOrEmpty(paypalEmailAddress))
                {
                    return false;
                }

                // check if paypal email is valid

                // check if paypal email is verified

                // Check if user has enough balance
                if (user.Balance < withdrawRequest.Amount)
                {
                    return false;
                }

                // convert user balance to USD
                decimal balanceInUSD = withdrawRequest.Amount * 0.9M;

                // Initiate paypal payout
                var isAuthorized = await _paypalClientApi.AuthorizeClient();
                if (!isAuthorized)
                {
                    return false;
                }

                var payout = await _paypalClientApi.InitiatePayout(paypalEmailAddress, balanceInUSD);

                // check if payout is successful
                if (payout == null)
                {
                    return false;
                }

                var payoutStatusResponse = await CheckWithdrawPayoutRecursively(payout.batch_header.payout_batch_id);
                if (payoutStatusResponse == null)
                {
                    return false;
                }

                if(payoutStatusResponse.Items.Count == 0)
                {
                    return false;
                }

                var payoutStatus = payoutStatusResponse.Items[0].TransactionStatus;

                // Save withdrawal
                var withdraw = new Withdraw
                {
                    WithdrawName = user.FirstName + " " + user.LastName,
                    Created = DateTime.UtcNow,
                    CreatedBy = userId.ToString(),
                    LastModified = DateTime.UtcNow,
                    LastModifiedBy = userId.ToString(),
                    AmountSigmaTokens = withdrawRequest.Amount,
                    AmountUSD = (double)balanceInUSD,
                    Status = payoutStatus,
                    PaypalEmail = paypalEmailAddress,
                };

                _context.Withdraws.Add(withdraw);
                await _context.SaveChangesAsync();

                // Update user balance
                user.Balance -= withdrawRequest.Amount;
                await _context.SaveChangesAsync();

                var emailRequest = new EmailData
                {
                    Email = "mujo.behric@outlook.com",
                    Subject = "Withdrawal",
                    Amount = withdrawRequest.Amount,
                    SigmaAmount = withdrawRequest.Amount,
                };

                SendEmail(emailRequest);

                return true;
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while making withdraw!");
            }
        }

        public async Task<PaymentBrandResponse> GetPaymentsBrandAsync()
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();

                var paymentBrand = new PaymentBrandResponse();

                // Get balance
                var user = await _context.Users.FirstOrDefaultAsync(x => x.Id == userId);
                if (user == null)
                {
                    return null;
                }

                paymentBrand.Balance = user.Balance;
                paymentBrand.Payments = new List<BrandPayments>();

                // Get orders for brand
                var paymentBrandEntity = await _context.Orders
                    .Include(c => c.Brand)
                    .Where(x => x.BrandId == userId)
                    .Select(o => o)
                    .ToListAsync();

                if (paymentBrandEntity != null)
                {
                    paymentBrandEntity.ForEach(x =>
                    {
                        paymentBrand.Payments.Add(new BrandPayments
                        {
                            Id = x.Id,
                            UserFullName = x.Brand.FirstName + " " + x.Brand.LastName,
                            Type = x.Type,
                            Price = x.Price,
                            Amount = x.Quantity,
                            Status = x.PaypalStatus,
                            Campaign = "",
                            Date = x.Created.ToShortDateString(),
                            Time = x.Created.ToShortTimeString()
                        });
                    });
                }

                var transfers = await _context.Transfers
                    .Include(cu => cu.CampaignUser)
                    .ThenInclude(i => i.Influencer)
                    .Include(cu => cu.CampaignUser)
                    .ThenInclude(i => i.Campaign)
                    .Where(x => x.CreatedBy == userId.ToString())
                    .Select(o => o)
                    .ToListAsync();

                if (transfers != null)
                {
                    transfers.ForEach(x =>
                    {
                        paymentBrand.Payments.Add(new BrandPayments
                        {
                            Id = x.Id,
                            UserFullName = x.CampaignUser.Influencer.FirstName + " " + x.CampaignUser.Influencer.LastName,
                            Type = "Transfer",
                            Price = 0,
                            Amount = x.AmountSigmaToken,
                            Status = x.Status,
                            Campaign = x.CampaignUser.Campaign.Name,
                            Date = x.Created.ToShortDateString(),
                            Time = x.Created.ToShortTimeString()
                        });
                    });
                }

                return paymentBrand;
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while getting transactions!");
            }
        }

        public async Task<PaymentUserResponse> GetPaymentsUserAsync()
        {
            return await GetPaymentUser();
        }

        private async Task<PaymentUserResponse> GetPaymentUser()
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();

                var paymentUser = new PaymentUserResponse();

                // Get balance
                var user = await _context.Users.FirstOrDefaultAsync(x => x.Id == userId);
                if (user == null)
                {
                    return null;
                }

                paymentUser.Balance = user.Balance;
                paymentUser.PaypalEmail = user.PaypalEmail;

                // Get payment user
                var paymentUserEntity = await _context.Withdraws
                    .Where(x => x.CreatedBy == userId.ToString())
                    .Select(o => o)
                    .ToListAsync();

                if (paymentUserEntity == null)
                {
                    return null;
                }

                paymentUser.Payments = new List<PaymentUserItem>();

                paymentUserEntity.ForEach(x =>
                {
                    paymentUser.Payments.Add(new PaymentUserItem
                    {
                        Type = "Withdraw",
                        Price = (decimal)x.AmountUSD,
                        Amount = x.AmountSigmaTokens,
                        Status = x.Status,
                        Date = x.Created,
                        Campaign = "",
                    });
                });

                return paymentUser;

            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while getting transactions!");
            }
        }

        public async Task<DetailsCVM> TransferSigmaTokens(TransferRequest transferRequest)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();

                // Get brand/company user
                var user = await _context.Users.FirstOrDefaultAsync(x => x.Id == userId);
                if (user == null)
                {
                    throw new BadRequestException("Cannot find user!");
                }

                // Calculate transfer value
                var transferValue = 0;
                var campaignUser = await _context.CampaignUsers
                    .FirstOrDefaultAsync(x => x.CampaignId == transferRequest.CampaignId 
                    && x.InfluencerId == transferRequest.InfluencerId);

                if (campaignUser != null)
                {
                    var userCampaignAchievements = await _context.UserCampaignAchievementPoints
                        .Include(a => a.AchievementPoint)
                        .ThenInclude(at => at.AchievementType)
                        .Where(x => x.CampaignId == transferRequest.CampaignId
                        && x.UserId == transferRequest.InfluencerId)
                        .ToListAsync();

                    if (userCampaignAchievements != null)
                    {
                        foreach(var achievement in userCampaignAchievements)
                        {
                            if(achievement.Status == AchievementStatus.Done.Value)
                            {
                                transferValue += achievement.AchievementPoint.AchievementType.Value;
                            }
                        }
                    }
                }

                // If calculated value is 0, return
                if (transferValue == 0)
                {
                    throw new BadRequestException("Cannot transfer 0 tokens!");
                }

                // Check if brand/company has enough balance
                if (user.Balance < transferValue)
                {
                    throw new BadRequestException("Not enough balance!");
                }

                // Get receiver/influencer user
                var receiver = await _context.Users.FirstOrDefaultAsync(x => x.Id == transferRequest.InfluencerId);
                if (receiver == null)
                {
                    throw new BadRequestException("Cannot find receiver!");
                }

                // Update user balance
                user.Balance -= transferValue;
                receiver.Balance += transferValue;

                campaignUser.Status = CampaignUserStatus.PayedOut.Value;

                await _context.SaveChangesAsync();

                // Create transfer
                CreateTransfer(transferValue, transferRequest.CampaignId, transferRequest.InfluencerId);

                return await _campaignCompanyService.GetById(transferRequest.CampaignId);
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while making transfer!");
            }   
        }

        public async Task<PaymentUserResponse> UpdatePaypalEmailAsync(PaypalEmailRequest paypalEmailRequest)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();

                // Check if email is valid
                var validator = new PaypalEmailValidator();
                var validationResult = await validator.ValidateAsync(paypalEmailRequest);

                if (!validationResult.IsValid)
                {
                    var validationErrors = validationResult.Errors.Select(error => error.ErrorMessage);
                    throw new BadRequestException("Validation failed: " + string.Join(", ", validationErrors));
                }

                // get user
                var user = await _context.Users.FirstOrDefaultAsync(x => x.Id == userId);
                if (user == null)
                {
                    throw new BadRequestException("Cannot find user!");
                }

                // update user
                user.PaypalEmail = paypalEmailRequest.PaypalEmail;
                await _context.SaveChangesAsync();

                return await GetPaymentUser();
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while updating paypal email!");
            }
        }

        private void CreateTransfer(int amount, int campaignId, int influencerId)
        {
            var campaignUser = _context.CampaignUsers.FirstOrDefault(x => x.CampaignId == campaignId && x.InfluencerId == influencerId);
            if (campaignUser == null)
            {
                  throw new BadRequestException("Cannot find campaign user!");
            }

            var transfer = new Transfer
            {
                Created = DateTime.Now,
                CreatedBy = _userContextService.GetCurrentUserId().ToString(),
                LastModified = DateTime.Now,
                LastModifiedBy = _userContextService.GetCurrentUserId().ToString(),
                AmountSigmaToken = amount,
                Status = "SUCCESS",
                CampaignUserId = campaignUser.Id,
                
            };

            _context.Transfers.Add(transfer);
            _context.SaveChanges();
        }


        /// <summary>
        /// Private method for sending email via RabbitMQ
        /// </summary>
        /// <param name="emailRequest"></param>
        private void SendEmail(EmailData emailRequest)
        {
            using var bus = RabbitHutch.CreateBus("host=localhost");
            bus.PubSub.Publish(emailRequest, "withdrawals");
        }

        /// <summary>
        /// Private method for checking withdraw payout status recursively
        /// </summary>
        /// <param name="payoutBatchId"></param>
        /// <param name="attempt"></param>
        /// <param name="maxAttempts"></param>
        /// <returns></returns>
        private async Task<PayoutStatusResponse?> CheckWithdrawPayoutRecursively(string payoutBatchId, int attempt = 1, int maxAttempts = 10)
        {
            if (attempt > maxAttempts)
            {
                return null;
            }

            var payoutStatusResponse = await _paypalClientApi.CheckWithdrawPayout(payoutBatchId);

            if (payoutStatusResponse == null)
            {
                return null;
            }

            if (payoutStatusResponse.Items.Count > 0 && payoutStatusResponse.Items[0].TransactionStatus != "SUCCESS")
            {
                // Pause for 2 seconds and check again recursively
                await Task.Delay(2000);
                return await CheckWithdrawPayoutRecursively(payoutBatchId, attempt + 1, maxAttempts);
            }

            return payoutStatusResponse;
        }
    }
}
