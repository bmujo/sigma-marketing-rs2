using EasyNetQ;
using Microsoft.Extensions.Configuration;
using SigmaMarketing.Email.Helper;
using SigmaMarketing.Email.Model;
using SigmaMarketing.Email.Services;

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Sigma Marketing Email");

        var configuration = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
            .Build();

        var appSettings = new AppSettings(configuration);

        var emailService = new EmailService(appSettings);

        try
        {
            var host = appSettings.EmailMicroserviceConnectionString;
            var port = appSettings.EmailMicroservicePort;

            using (var bus = RabbitHutch.CreateBus($"host={host};port={port}"))
            {
                bus.PubSub.Subscribe<EmailData>("withdrawals", SendEmail);

                Console.WriteLine(" Press [enter] to exit.");
                Console.ReadLine();
            }

            void SendEmail(EmailData emailRequest)
            {
                emailService.SendWithdrawStatusEmail(emailRequest);

                Console.WriteLine(" [x] Received {0}", emailRequest);
                Console.WriteLine(" [x] Received {0}", emailRequest.Email);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error creating!");
            Console.WriteLine(ex.Message);
            Console.ReadLine();
        }
    }
}