using SigmaMarketing.Core.Data;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Exceptions;
using SigmaMarketing.Core.Helper;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Models.PagedList;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Infrastructure.Services
{
    public class NotificationService : INotificationService
    {
        private readonly ApplicationDbContext _context;
        private readonly INotificationHubService _notificationHubService;
        private readonly IUserContextService _userContextService;

        public NotificationService(ApplicationDbContext context, INotificationHubService notificationHubService, IUserContextService userContextService)
        {
            _context = context;
            _notificationHubService = notificationHubService;
            _userContextService = userContextService;
        }

        public async Task<PagedList<NotificationResponse>> GetNotificationsAsync(int page, int pageSize)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();

                if (pageSize < 0) pageSize = SigmaConstants.DefaultPageSize;
                if (page < 0) page = SigmaConstants.DefualtPageNumber;

                var notificationsQuery = _context.Notifications.Where(user => user.UserId == userId);

                if(notificationsQuery == null)
                {
                    return PagedList<NotificationResponse>.CreateEmpty(page, pageSize);
                }

                notificationsQuery = notificationsQuery.OrderByDescending(c => c.Created);

                var notificationsResponse = notificationsQuery.Select(notification => new NotificationResponse
                {
                    Id = notification.Id,
                    Created = notification.Created,
                    Title = notification.Title,
                    Message = notification.Message,
                    IsOpen = notification.IsOpen,
                    Type = notification.Type
                });

                var notifications = await PagedList<NotificationResponse>.CreateAsync(notificationsResponse, page, pageSize);
              
                return notifications;
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while getting notifications!");
            }
        }

        public async Task<NotificationResponse> SetNotificationOpenAsync(int notificationId)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();

                // Get notification
                var notification = await _context.Notifications.FindAsync(notificationId);
                if (notification == null)
                {
                    throw new NotFoundException("Notification not found!");
                }

                // Check if notification belongs to user
                if (notification.UserId != userId)
                {
                    throw new BadRequestException("Notification does not belong to user!");
                }

                // Set notification to open
                notification.IsOpen = true;
                await _context.SaveChangesAsync();

                NotificationResponse notificationToReturn = new NotificationResponse
                {
                    Id = notification.Id,
                    Created = notification.Created,
                    Title = notification.Title,
                    Message = notification.Message,
                    IsOpen = notification.IsOpen,
                    Type = notification.Type
                };

                await _notificationHubService.SendNumberOfUnreadNotifications(notification, userId);

                return notificationToReturn;
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while setting notification to open!");
            }
        }

        public async Task<bool> SaveNotificationTokenAsync(string token)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();

                // Get user
                var user = await _context.Users.FindAsync(userId);
                if (user == null)
                {
                    throw new NotFoundException("User not found!");
                }

                // Save token
                user.NotificationToken = token;
                await _context.SaveChangesAsync();

                return true;
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while saving notification token!");
            }
        }

        public async Task<bool> SendNotificationAsync(int createdById, int receiverId, string title, string message, int type)
        {
            try
            {
                var notification = new Notification
                {
                    Created = DateTime.Now,
                    CreatedBy = createdById.ToString(),
                    LastModified = DateTime.Now,
                    LastModifiedBy = createdById.ToString(),
                    Title = title,
                    Message = message,
                    IsOpen = false,
                    UserId = receiverId,
                    Type = type,
                };

                _context.Notifications.Add(notification);
                _context.SaveChanges();

                await _notificationHubService.SendNotification(notification, receiverId);
                await _notificationHubService.SendNumberOfUnreadNotifications(notification, receiverId);

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        } 
    }
}
