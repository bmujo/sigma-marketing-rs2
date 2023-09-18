namespace SigmaMarketing.Model.Configuration
{
    public class AppSettings
    {
        public string Key { get; set; }
        public string Issuer { get; set; }
        public string PaypalBaseUrl { get; set; }
        public string PaypalClientId { get; set; }
        public string PaypalClientSecret { get; set; }

        public string EmailMicroserviceConnectionString { get; set; }
        public string EmailMicroservicePort { get; set; }
    }
}
