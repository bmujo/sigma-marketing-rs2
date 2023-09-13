using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Request.SigmaToken;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Core.Interfaces
{
    public interface ISigmaTokenService
    {
        Task<List<SigmaTokenResponse>> GetSigmaTokensPackagesAsync();
        Task<bool?> PurchaseTokensAsync(PurchaseRequest purchaseRequest);
        Task<PaymentBrandResponse> GetPaymentsBrandAsync();
        Task<PaymentUserResponse> GetPaymentsUserAsync();

        Task<bool> WithdrawAsync(WithdrawRequest withdrawRequest);
        Task<DetailsCVM> TransferSigmaTokens(TransferRequest transferRequest);
        Task<PaymentUserResponse> UpdatePaypalEmailAsync(PaypalEmailRequest paypalEmailRequest);
    }
}
