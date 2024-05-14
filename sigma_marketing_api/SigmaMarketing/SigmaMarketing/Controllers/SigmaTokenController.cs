using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SigmaMarketing.API.Controllers.Base;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Exceptions;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Request.SigmaToken;

namespace SigmaMarketing.API.Controllers
{
    [ApiController]
    [Route("api/[controller]/[action]")]
    public class SigmaTokenController : BaseController
    {
        private readonly ISigmaTokenService _sigmaTokenService;

        public SigmaTokenController(UserManager<ApplicationUser> userManager, ISigmaTokenService sigmaTokenService) : base(userManager)
        {
            _sigmaTokenService = sigmaTokenService;
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<IActionResult> GetSigmaTokensPackages()
        {
            try
            {
                var result = await _sigmaTokenService.GetSigmaTokensPackagesAsync();
                return Ok(result);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<IActionResult> PurchaseTokens([FromBody] PurchaseRequest purchaseRequest)
        {
            try
            {
                // validate purchase request
                if (purchaseRequest == null)
                {
                    throw new BadRequestException("Invalid purchase request");
                }

                var isPurchased = await _sigmaTokenService.PurchaseTokensAsync(purchaseRequest);

                return Ok(isPurchased);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<IActionResult> GetPaymentsBrand()
        {
            try
            {
                var paymentsBrand = await _sigmaTokenService.GetPaymentsBrandAsync();

                return Ok(paymentsBrand);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<IActionResult> GetPaymentsUser()
        {
            try
            {
                var paymentsUser = await _sigmaTokenService.GetPaymentsUserAsync();

                return Ok(paymentsUser);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<IActionResult> Withdraw([FromBody] WithdrawRequest withdrawRequest)
        {
            try
            {
                // validate purchase request
                if (withdrawRequest == null)
                {
                    throw new BadRequestException("Invalid withdraw request");
                }

                var isWithdrawn = await _sigmaTokenService.WithdrawAsync(withdrawRequest);

                return Ok(isWithdrawn);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<IActionResult> Payout([FromBody] TransferRequest transferRequest)
        {
            try
            {
                // validate purchase request
                if (transferRequest == null)
                {
                    throw new BadRequestException("Invalid transfer request");
                }

                var isTransferred = await _sigmaTokenService.TransferSigmaTokens(transferRequest);

                return Ok(isTransferred);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<IActionResult> UpdatePaypalEmail([FromBody] PaypalEmailRequest paypalEmailRequest)
        { 
            try
            {
                var paymentsUser = await _sigmaTokenService.UpdatePaypalEmailAsync(paypalEmailRequest);

                return Ok(paymentsUser);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
