using SigmaMarketing.Email.Helper;
using MimeKit;
using MimeKit.Text;
using System.Net.Mime;
using MailKit.Net.Smtp;
using Microsoft.AspNetCore.Mvc;
using SigmaMarketing.Email.Model;

namespace SigmaMarketing.Email.Services
{
    public class EmailService
    {
        private readonly AppSettings _appSettings;

        public EmailService(Microsoft.Extensions.Configuration.IConfigurationRoot configuration)
        {
            _appSettings = new AppSettings();
            _appSettings.EmailFrom = configuration.GetSection("AppSettings:EmailFrom").Value;
            _appSettings.SmtpHost = configuration.GetSection("AppSettings:SmtpHost").Value;
            _appSettings.SmtpPort = int.Parse(configuration.GetSection("AppSettings:SmtpPort").Value);
            _appSettings.SmtpUser = configuration.GetSection("AppSettings:SmtpUser").Value;
            _appSettings.SmtpPass = configuration.GetSection("AppSettings:SmtpPass").Value;
        }

        public void sendWithdrawStatusEmail(EmailData emailRequest)
        {
            // kreiraj racun u pdf formatu 
            string racunBody = string.Empty;
            using (StreamReader reader = new StreamReader("Helper/EmailTemplates/withdraw.html"))
            {
                racunBody = reader.ReadToEnd();
            }

            racunBody = racunBody.Replace("client_name", emailRequest.Subject);
            racunBody = racunBody.Replace("client_email", emailRequest.Email);
            racunBody = racunBody.Replace("withdraw_date", DateTime.UtcNow.ToString());
            racunBody = racunBody.Replace("total_amount_sigma", emailRequest.SigmaAmount.ToString());
            racunBody = racunBody.Replace("total_amount_dollars", emailRequest.Amount.ToString());

            var htmlToPdf = new NReco.PdfGenerator.HtmlToPdfConverter();
            var pdfBytes = htmlToPdf.GeneratePdf(racunBody);

            MemoryStream ms = new MemoryStream(pdfBytes);
            ms.Position = 0;

            FileStreamResult fileStreamResult = new FileStreamResult(ms, "application/pdf");
            fileStreamResult.FileDownloadName = "withdraw.pdf";

            var multipart = new Multipart("mixed");
            var textPart = new TextPart(TextFormat.Html)
            {
                Text = generateWithdrawTemplate(),
                ContentTransferEncoding = ContentEncoding.Base64,
            };
            multipart.Add(textPart);

            var attachmentPart = new MimePart(MediaTypeNames.Application.Pdf)
            {
                Content = new MimeContent(ms),
                ContentId = "withdraw.pdf",
                ContentTransferEncoding = ContentEncoding.Base64,
                FileName = "withdraw.pdf"
            };
            multipart.Add(attachmentPart);

            // create email message
            var email = new MimeMessage();
            email.From.Add(MailboxAddress.Parse(_appSettings.EmailFrom));
            email.To.Add(MailboxAddress.Parse(emailRequest.Email));
            email.Subject = "Sima Marketing - Withdraw information";
            email.Body = multipart;

            // send email
            using var smtp = new SmtpClient();

            smtp.Connect(_appSettings.SmtpHost, _appSettings.SmtpPort, true);
            smtp.Authenticate(_appSettings.SmtpUser, _appSettings.SmtpPass);
            smtp.Send(email);
            smtp.Disconnect(true);
        }

        private string generateWithdrawTemplate()
        {
            string body = string.Empty;
            using (StreamReader reader = new StreamReader("Helper/EmailTemplates/withdraw.html"))
            {
                body = reader.ReadToEnd();
            }

            body = body.Replace("header_message", "Withdraw Info - Sigma Marketing");
            body = body.Replace("message_content", "You made witdraw, if anything is not right contact support");

            return body;
        }
    }
}
