using Microsoft.Extensions.Configuration;

namespace SigmaMarketing.Email.Helper
{
    public class AppSettings
    {
        public string EmailFrom { get; set; }
        public string SmtpHost { get; set; }
        public int SmtpPort { get; set; }
        public string SmtpUser { get; set; }
        public string SmtpPass { get; set; }
        public string EmailMicroserviceConnectionString { get; set; }
        public string EmailMicroservicePort { get; set; }

        public AppSettings(IConfigurationRoot configuration)
        {
            var appSettings = configuration.GetSection("AppSettings");

            EmailFrom = appSettings["EmailFrom"];
            SmtpHost = appSettings["SmtpHost"];
            SmtpPort = int.Parse(appSettings["SmtpPort"]);
            SmtpUser = appSettings["SmtpUser"];
            SmtpPass = appSettings["SmtpPass"];
            EmailMicroserviceConnectionString = appSettings["EmailMicroserviceConnectionString"];
            EmailMicroservicePort = appSettings["EmailMicroservicePort"];
        }
    }
}
