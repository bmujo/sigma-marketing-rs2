using SigmaMarketing.Model.Models.Email;

namespace SigmaMarketing.Email.Services
{
    public interface IEmailService
    {
        void SendWithdrawStatusEmail(EmailData emailData);
    }
}
