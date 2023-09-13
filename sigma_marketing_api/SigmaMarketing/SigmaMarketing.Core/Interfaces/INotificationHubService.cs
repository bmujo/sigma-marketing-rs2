using SigmaMarketing.Core.Entities;

namespace SigmaMarketing.Core.Interfaces
{
    public interface INotificationHubService
    {
        Task SendNotification(Notification notification, int userId);
        Task SendNumberOfUnreadNotifications(Notification notification, int userId);
    }
}
