using Microsoft.AspNetCore.SignalR;
using SigmaMarketing.Core.Data;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Hubs.Notification;
using SigmaMarketing.Core.Interfaces;

namespace SigmaMarketing.Infrastructure.Services
{
    public class NotificationHubService : INotificationHubService
    {
        private readonly ApplicationDbContext _context;
        private readonly IHubContext<NotificationHub> _hubContext;

        public NotificationHubService(ApplicationDbContext context, IHubContext<NotificationHub> hubContext)
        {
            _context = context;
            _hubContext = hubContext;
        }

        public async Task SendNotification(Notification notification, int userId)
        {
            var receiverId = notification.UserId;
            var senderId = userId.ToString();
            var notificationText = "new notification";

            var connection = _context.HubConnections.FirstOrDefault(c => c.UserId == receiverId);
            if (connection != null)
            {
                await _hubContext.Clients.Group(connection.UserId.ToString()).SendAsync("ReceiveNotification", senderId, notificationText);
            }
        }

        public async Task SendNumberOfUnreadNotifications(Notification notification, int userId)
        {
            var numberOfUnreadNotifications = 0;
            var notifications = _context.Notifications.Where(n => n.UserId == notification.UserId && !n.IsOpen).Select(n => n.Id).ToList();
            if (notifications.Any())
            {
                numberOfUnreadNotifications = notifications.Count;
            }

            var connection = _context.HubConnections.FirstOrDefault(c => c.UserId == notification.UserId);
            if (connection != null)
            {
                await _hubContext.Clients.Group(connection.UserId.ToString()).SendAsync("ReceiveNumberOfUnreadNotifications", numberOfUnreadNotifications);
            }
        }
    }
}
