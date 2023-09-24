using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using SigmaMarketing.Email.Services;
using Serilog;
using SigmaMarketing.Email.Configuration;
using SigmaMarketing.Email.RabbitMqManager;

namespace SigmaMarketing.Email;

public class Program
{
    public static void Main(string[] args)
    {
        CreateHostBuilder(args).Build().Run();
    }

    public static IHostBuilder CreateHostBuilder(string[] args)
    {
        return Host.CreateDefaultBuilder(args)
            .ConfigureLogging(logging =>
            {
                logging.ClearProviders();
            })
            .UseSerilog((hostContext, loggerConfiguration) =>
            {
                loggerConfiguration.ReadFrom
                .Configuration(hostContext.Configuration)
                .WriteTo.Console();
            })
            .ConfigureAppConfiguration((hostContext, builder) =>
            {
                builder.Sources.Clear();
                var env = hostContext.HostingEnvironment;
                var envName = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");

                builder.SetBasePath(Directory.GetCurrentDirectory());
                builder.AddJsonFile($"appsettings.{envName}.json", optional: false, reloadOnChange: true);
                builder.AddEnvironmentVariables();
            })
            .ConfigureServices((hostContext, services) =>
            {
                services.Configure<AppSettings>(hostContext.Configuration.GetSection("AppSettings"));
                services.Configure<RabbitMq>(hostContext.Configuration.GetSection("RabbitMq"));

                services.AddSingleton(provider =>
                {
                    var rabbitMqConnectionString = hostContext.Configuration.GetValue<string>("RabbitMq:ConnectionString");
                    return new RabbitManager(rabbitMqConnectionString);
                });

                services.AddScoped<IEmailService, EmailService>();
                services.AddHostedService<Worker>();
            });
    }
}