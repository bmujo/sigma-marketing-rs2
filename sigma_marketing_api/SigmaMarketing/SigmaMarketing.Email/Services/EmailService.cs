using MimeKit;
using MimeKit.Text;
using System.Net.Mime;
using MailKit.Net.Smtp;
using SigmaMarketing.Model.Models.Email;
using Microsoft.Extensions.Options;
using SigmaMarketing.Email.Configuration;
using Microsoft.Extensions.Logging;
using SigmaMarketing.Email.PdfGenerator;
using QuestPDF.Infrastructure;

namespace SigmaMarketing.Email.Services
{
    public class EmailService : IEmailService
    {
        private readonly ILogger<Worker> _logger;

        private string EmailFrom { get; set; }
        private string SmtpHost { get; set; }
        private int SmtpPort { get; set; }
        private string SmtpUser { get; set; }
        private string SmtpPass { get; set; }



        public EmailService(
            IOptions<AppSettings> appSettings,
            ILogger<Worker> logger
            )
        {
            _logger = logger ??
                throw new ArgumentNullException(nameof(logger));

            EmailFrom = appSettings.Value.EmailFrom;
            SmtpHost = appSettings.Value.SmtpHost;
            SmtpPort = appSettings.Value.SmtpPort;
            SmtpUser = appSettings.Value.SmtpUser;
            SmtpPass = appSettings.Value.SmtpPass;
        }

        public async void SendWithdrawStatusEmail(EmailData emailData)
        {
            try
            {
                var emailContent = GenerateWithdrawTemplate(emailData);

                // Generate pdf 
                var filePath = "withdraw.pdf";

                QuestPDF.Settings.License = LicenseType.Community;

                var model = InvoiceDocumentDataSource.GetInvoiceDetails();
                var document = new InvoiceDocument(model);
                var pdfBytes = document.Compose();

                var pdfStream = new MemoryStream();
                pdfStream.Write(pdfBytes, 0, pdfBytes.Length);
                pdfStream.Position = 0;

                var multipart = new Multipart("mixed");
                var textPart = new TextPart(TextFormat.Html)
                {
                    Text = emailContent,
                    ContentTransferEncoding = ContentEncoding.Base64,
                };
                multipart.Add(textPart);

                var attachmentPart = new MimePart(MediaTypeNames.Application.Pdf)
                {
                    Content = new MimeContent(pdfStream),
                    ContentId = "withdraw.pdf",
                    ContentTransferEncoding = ContentEncoding.Base64,
                    FileName = "withdraw.pdf"
                };
                multipart.Add(attachmentPart);

                // create email message
                var email = new MimeMessage();
                email.From.Add(MailboxAddress.Parse(EmailFrom));
                email.To.Add(MailboxAddress.Parse(emailData.Email));
                email.Subject = "Sima Marketing - Withdraw information";
                email.Body = multipart;

                // send email
                using var smtp = new SmtpClient();

                smtp.Connect(SmtpHost, SmtpPort, true);
                smtp.Authenticate(SmtpUser, SmtpPass);
                smtp.Send(email);
                smtp.Disconnect(true);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Error sending email");
            }
        }

        private string GenerateWithdrawTemplate(EmailData emailData)
        {
            string content = string.Empty;
            using (StreamReader reader = new StreamReader("Helper/EmailTemplates/withdraw.html"))
            {
                content = reader.ReadToEnd();
            }

            content = content.Replace("client_name", emailData.Subject);
            content = content.Replace("client_email", emailData.Email);
            content = content.Replace("withdraw_date", DateTime.UtcNow.ToString());
            content = content.Replace("total_amount_sigma", emailData.SigmaAmount.ToString());
            content = content.Replace("total_amount_dollars", emailData.Amount.ToString());

            return content;
        }
    }
}
