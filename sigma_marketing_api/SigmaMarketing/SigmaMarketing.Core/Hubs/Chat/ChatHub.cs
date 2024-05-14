using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using SigmaMarketing.Core.Data;
using SigmaMarketing.Core.Entities;
using System.IdentityModel.Tokens.Jwt;

namespace SigmaMarketing.Core.Hubs.Chat
{
    public class ChatHub : Hub
    {
        private readonly ApplicationDbContext _db;

        public ChatHub(ApplicationDbContext db)
        {
            _db = db;
        }

        [Authorize]
        override public async Task OnConnectedAsync()
        {
            await base.OnConnectedAsync();
            var httpContext = Context.GetHttpContext();

            // Get the token from the Authorization header
            var token = httpContext.Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            if (token == "")
            {
                token = httpContext.Request.Query["access_token"].ToString().Replace("Bearer ", "");
            }

            // Decode the token to get the claims
            var tokenHandler = new JwtSecurityTokenHandler();
            var decodedToken = tokenHandler.ReadJwtToken(token);

            // Get the user ID from the claims
            var userId = decodedToken.Claims.FirstOrDefault(c => c.Type == "nameid")?.Value;
            var groupName = userId.ToString();

            // Add the connection to the database
            var connection = new HubConnection
            {
                Created = DateTime.Now,
                CreatedBy = userId,
                LastModified = DateTime.Now,
                LastModifiedBy = userId,
                ConnectionId = Context.ConnectionId,
                UserId = Convert.ToInt32(userId)
            };
            _db.HubConnections.Add(connection);
            _db.SaveChanges();

            await Groups.AddToGroupAsync(Context.ConnectionId, groupName);

            await Clients.Group(groupName).SendAsync("UserConnected", Context.ConnectionId);

            // Now that user is connected send it the number of unread messages
            var conversations = _db.Conversations
                .Where(conv => conv.UserId1 == Convert.ToInt32(userId) || conv.UserId2 == Convert.ToInt32(userId))
                .ToList();
            var sumOfUnreadMessages = 0;

            if (conversations != null)
            {
                conversations.ForEach(conversation =>
                {
                    var numberOfUnreadMessages = _db.Messages
                        .Where(m => m.ConversationId == conversation.Id && m.ReceiverId == Convert.ToInt32(userId) && m.IsRead == false)
                        .Count();
                    sumOfUnreadMessages += numberOfUnreadMessages;
                });
                
                await Clients.Group(connection.UserId.ToString()).SendAsync("ReceiveNumberOfUnreadMessages", Convert.ToInt32(userId), sumOfUnreadMessages.ToString());
            }
        }

        public override Task OnDisconnectedAsync(Exception exception)
        {
            var connection = _db.HubConnections.FirstOrDefault(x => x.ConnectionId == Context.ConnectionId);
            _db.HubConnections.Remove(connection);
            _db.SaveChanges();
            return base.OnDisconnectedAsync(exception);
        }
    }
}
