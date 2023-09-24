using EasyNetQ;

namespace SigmaMarketing.Email.RabbitMqManager
{
    public class RabbitManager : IDisposable
    {
        private IBus _bus;
        private readonly string _connectionString;

        public RabbitManager(string connectionString)
        {
            _connectionString = connectionString;
            InitializeBus();
        }

        private void InitializeBus()
        {
            _bus = RabbitHutch.CreateBus(_connectionString);
        }

        public void Subscribe<TMessage>(string subscriptionId, Action<TMessage> onMessage)
        {
            _bus.PubSub.Subscribe(subscriptionId, onMessage);
        }

        public void Dispose()
        {
            _bus.Dispose();
        }
    }
}
