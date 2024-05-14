using EasyNetQ;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using SigmaMarketing.Email.Configuration;
using SigmaMarketing.Email.RabbitMqManager;
using SigmaMarketing.Email.Services;
using SigmaMarketing.Model.Models.Email;

namespace SigmaMarketing.Email
{
    public class Worker : IHostedService
    {
        private readonly IEmailService _emailService;
        private readonly ILogger<Worker> _logger;

        private readonly RabbitManager _rabbitManager;

        private readonly string connectionString;
        private readonly string subscriptionId;

        private int? _exitCode;

        public Worker(
            IEmailService service,
            IOptions<RabbitMq> rabbitMq,
            RabbitManager rabbitManager,
            ILogger<Worker> logger)
        {
            _emailService = service ??
                throw new ArgumentNullException(nameof(service));

            _logger = logger ??
                throw new ArgumentNullException(nameof(logger));

            _rabbitManager = rabbitManager ?? throw new ArgumentNullException(nameof(rabbitManager));

            connectionString = rabbitMq.Value.ConnectionString;
            subscriptionId = rabbitMq.Value.SubscriptionId;
        }

        public Task StartAsync(CancellationToken cancellationToken)
        {
            try
            {
                _logger?.LogInformation("Starting the Email service");
                _logger?.LogInformation("Connecting to the queue {connectionString}", connectionString);
                _logger?.LogInformation("Subscribing to the queue {subscriptionId}", subscriptionId);

                _rabbitManager.Subscribe<EmailData>(subscriptionId, SendEmail);

                _logger?.LogInformation("Subscribed to the queue");
                _exitCode = 0;
            }
            catch(TimeoutException ex)
            {
                _logger?.LogError(ex, "Timeout!");
                _exitCode = 1;
            }
            catch(TaskCanceledException ex)
            {
                _logger?.LogError(ex, "Task canceled!");
                _exitCode = 1;
            }
            catch (OperationCanceledException)
            {
                _logger?.LogInformation("The worker has been killed with CTRL+C");
                _exitCode = -1;
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "An error occurred");
                _exitCode = 1;
            }

            return Task.CompletedTask;
        }

        private void SendEmail(EmailData emailRequest)
        {
            _logger.LogInformation("Sending email to {email}", emailRequest.Email);
            _emailService.SendWithdrawStatusEmail(emailRequest);
            _logger.LogInformation("Email sent to {email}", emailRequest.Email);
        }

        public Task StopAsync(CancellationToken cancellationToken)
        {
            Environment.ExitCode = _exitCode.GetValueOrDefault(-1);
            _logger?.LogInformation("Shutting down the service with code {exitCode}", Environment.ExitCode);
            return Task.CompletedTask;
        }
    }
}
