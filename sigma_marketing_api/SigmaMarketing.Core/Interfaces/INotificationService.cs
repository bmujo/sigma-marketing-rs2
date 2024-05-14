using SigmaMarketing.Model.Models.PagedList;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Core.Interfaces
{
    public interface INotificationService
    {
        Task<PagedList<NotificationResponse>> GetNotificationsAsync(int pageNumber, int pageSize);
        Task<NotificationResponse> SetNotificationOpenAsync(int notificationId);
        Task<bool> SaveNotificationTokenAsync(string token);
        Task<bool> SendNotificationAsync(int createdById, int receiverId, string title, string message, int type);
    }
}
