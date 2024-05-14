using Duende.IdentityServer.Extensions;
using Microsoft.AspNetCore.SignalR;
using SigmaMarketing.Core.Data;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Hubs.Chat;
using SigmaMarketing.Core.Interfaces;

namespace SigmaMarketing.Infrastructure.Services
{
    public class ChatHubService : IChatHubService
    {
        private readonly ApplicationDbContext _context;
        private readonly IHubContext<ChatHub> _hubContext;

        public ChatHubService(ApplicationDbContext context, IHubContext<ChatHub> hubContext)
        {
            _context = context;
            _hubContext = hubContext;
        }

        public async Task SendMessage(Message message)
        {
            var receiverId = message.ReceiverId;
            var senderId = message.SenderId.ToString();

            var senderUser = _context.Users.FirstOrDefault(u => u.Id == message.SenderId);
            if(senderUser != null)
            {
                senderId = senderUser.FirstName + " " + senderUser.LastName;
            }
            var messageText = message.MessageText;

            // Send push notification
            var user = _context.Users.FirstOrDefault(u => u.Id == receiverId);
            var notificationToken = user == null ? "" : user.NotificationToken;

            if (!notificationToken.IsNullOrEmpty())
            {
                var notificationMessage = new FirebaseAdmin.Messaging.Message
                {
                    Token = notificationToken, // The user's FCM token
                    Notification = new FirebaseAdmin.Messaging.Notification
                    {
                        Title = "New Message",
                        Body = "You have a new message!"
                    },
                };

                var messaging = FirebaseAdmin.Messaging.FirebaseMessaging.DefaultInstance;
                var fcmResponse = await messaging.SendAsync(notificationMessage);
            }

            var connection = _context.HubConnections.FirstOrDefault(c => c.UserId == receiverId);
            if (connection != null)
            {
                await _hubContext.Clients.Group(connection.UserId.ToString()).SendAsync("ReceiveMessage", senderId, messageText);
            }
        }

        public async Task SendConversations(Message message)
        {
            var receiverId = message.ReceiverId;
            var senderId = message.SenderId.ToString();
            var messageText = message.MessageText;

            var connection = _context.HubConnections.FirstOrDefault(c => c.UserId == receiverId);
            if (connection != null)
            {
                await _hubContext.Clients.Group(connection.UserId.ToString()).SendAsync("ReceiveConversations", senderId, messageText);
            }
        }

        public async Task SendNumberOfUnreadMessages(Message message)
        {
            var conversations = _context.Conversations
                .Where(conv => conv.UserId1 == message.ReceiverId || conv.UserId2 == message.ReceiverId)
                .ToList();
            var sumOfUnreadMessages = 0;

            if (conversations != null)
            {
                conversations.ForEach(conversation =>
                {
                    var numberOfUnreadMessages = _context.Messages
                        .Where(m => m.ConversationId == conversation.Id && m.MessageOwnerId == message.SenderId && m.IsRead == false)
                        .Count();
                    sumOfUnreadMessages += numberOfUnreadMessages;
                });

                var connection = _context.HubConnections.FirstOrDefault(c => c.UserId == message.ReceiverId);
                if (connection != null)
                {
                    await _hubContext.Clients.Group(connection.UserId.ToString()).SendAsync("ReceiveNumberOfUnreadMessages", message.SenderId, sumOfUnreadMessages.ToString());
                }
            }
        }
    }
}
