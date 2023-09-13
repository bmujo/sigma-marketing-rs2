using Microsoft.EntityFrameworkCore;
using SigmaMarketing.Core.Data;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Exceptions;
using SigmaMarketing.Core.Helper;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Models.PagedList;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Infrastructure.Services
{
    public class ChatService : IChatService
    {
        private readonly ApplicationDbContext _context;
        private readonly IChatHubService _chatHubService;
        private readonly IUserContextService _userContextService;

        public ChatService(ApplicationDbContext context, IChatHubService chatHubService, IUserContextService userContextService)
        {
            _context = context;
            _chatHubService = chatHubService;
            _userContextService = userContextService;
        }

        public async Task<PagedList<ConversationResponse>> GetConversationsAsync(int page, int pageSize)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var host = _userContextService.GetHostUrl();


                if (pageSize < 0) pageSize = SigmaConstants.DefaultPageSize;
                if (page < 0) page = SigmaConstants.DefualtPageNumber;


                var conversationsQuery = _context.Conversations
                    .Where(users => users.UserId1 == userId || users.UserId2 == userId);

                if (conversationsQuery == null)
                {
                    return PagedList<ConversationResponse>.CreateEmpty(page, pageSize);
                }

                conversationsQuery = conversationsQuery.OrderByDescending(conversation => conversation.Created);

                var conversationsResponse = conversationsQuery.Select(conversation => new ConversationResponse
                {
                    Id = conversation.Id,
                    Name = "",
                    LastMessage = "",
                    TimeOfLastMessage = DateTime.Now,
                    ImageOfSender = host + SigmaConstants.DefaultUserImage,
                    SenderId = userId != conversation.UserId1 ? conversation.UserId1 : conversation.UserId2,
                    NumberOfUnread = 0,
                });

                var conversations = await PagedList<ConversationResponse>.CreateAsync(conversationsResponse, page, pageSize);

                foreach(var conversationUpdated in conversations.Items)
                {
                    if (userId != conversationUpdated.SenderId)
                    {
                        var messagesForCount = await _context.Messages
                            .Where(m => m.ConversationId == conversationUpdated.Id && m.MessageOwnerId != userId && !m.IsRead)
                            .Select(m => m.Id)
                            .ToListAsync();
                        var numOfUnread = messagesForCount.Any() ? messagesForCount.Count : 0;

                        var user1 = await GetUserInformation(conversationUpdated.SenderId);
                        conversationUpdated.Name = user1.FirstName + " " + user1.LastName;
                        conversationUpdated.SenderId = user1.Id;
                        conversationUpdated.ImageOfSender = host + user1.ProfilePhotoUrl;
                        conversationUpdated.NumberOfUnread = numOfUnread;
                    }

                    if (userId != conversationUpdated.SenderId)
                    {
                        var messagesForCount = await _context.Messages
                            .Where(m => m.ConversationId == conversationUpdated.Id && m.MessageOwnerId != userId && !m.IsRead)
                            .Select(m => m.Id)
                            .ToListAsync();
                        var numOfUnread = messagesForCount.Any() ? messagesForCount.Count : 0;

                        var user2 = await GetUserInformation(conversationUpdated.SenderId);
                        conversationUpdated.Name = user2.FirstName + " " + user2.LastName;
                        conversationUpdated.SenderId = user2.Id;
                        conversationUpdated.ImageOfSender = host + user2.ProfilePhotoUrl;
                        conversationUpdated.NumberOfUnread = numOfUnread;
                    }

                    var lastMessage = await _context.Messages
                        .Where(m => m.ConversationId == conversationUpdated.Id)
                        .OrderByDescending(m => m.Created)
                        .FirstOrDefaultAsync();

                    conversationUpdated.LastMessage = lastMessage.MessageText;
                    conversationUpdated.TimeOfLastMessage = lastMessage.Created;
                }

                return conversations;
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while getting conversations!");
            }
        }

        public async Task<PagedList<MessageResponse>> GetConversationChatAsync(int receiverId, int page, int pageSize)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var host = _userContextService.GetHostUrl();

                if (pageSize < 0) pageSize = SigmaConstants.DefaultPageSize;
                if (page < 0) page = SigmaConstants.DefualtPageNumber;

                var conversation = await _context.Conversations
                    .Where(c => c.UserId1 == userId && c.UserId2 == receiverId || c.UserId1 == receiverId && c.UserId2 == userId)
                    .FirstOrDefaultAsync();

                if (conversation == null)
                {
                    return PagedList<MessageResponse>.CreateEmpty(page, pageSize);
                }

                // collection to start from
                var messagesQuery = _context.Messages.Where(message => message.ConversationId == conversation.Id);

                messagesQuery = messagesQuery.OrderByDescending(message => message.Created);

                var messagesResponse = messagesQuery.Select(message => new MessageResponse
                {
                    Id = message.Id,
                    Created = message.Created,
                    MessageText = message.MessageText,
                    SenderId = message.SenderId,
                    ReceiverId = message.ReceiverId,
                    IsRead = message.IsRead,
                    MessageOwnerId = message.MessageOwnerId,
                    SenderImage = host + SigmaConstants.DefaultUserImage,
                    ReceiverImage = host + SigmaConstants.DefaultUserImage,
                });

                var messages = await PagedList<MessageResponse>.CreateAsync(messagesResponse, page, pageSize);

                foreach (var message in messages.Items)
                {
                    if (message.MessageOwnerId == userId)
                    {
                        var user = await GetUserInformation(userId);
                        if (user != null)
                        {
                            message.SenderImage = host + user.ProfilePhotoUrl;
                        }
                    }
                    else
                    {
                        var user = await GetUserInformation(message.MessageOwnerId);
                        if (user != null)
                        {
                            message.ReceiverImage = host + user.ProfilePhotoUrl;
                        }
                    }
                }

                return messages;
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while getting chat details!");
            }
        }

        public async Task<MessageResponse> SendMessageAsync(NewMessageRequest newMessageVM)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var host = _userContextService.GetHostUrl();

                var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == userId);
                if (user == null)
                {
                    throw new NotFoundException("User not found!");
                }

                // Check if conversation exists
                var conversation = await _context.Conversations
                    .Where(c => c.UserId1 == userId && c.UserId2 == newMessageVM.ReceiverId
                    || c.UserId1 == newMessageVM.ReceiverId && c.UserId2 == userId)
                    .FirstOrDefaultAsync();

                if (conversation == null)
                {
                    // make new Conversation
                    conversation = new Conversation
                    {
                        Created = DateTime.Now,
                        CreatedBy = user.FirstName + " " + user.LastName,
                        LastModified = DateTime.Now,
                        LastModifiedBy = user.FirstName + " " + user.LastName,
                        UserId1 = userId,
                        UserId2 = newMessageVM.ReceiverId
                    };

                    // save to database
                    _context.Conversations.Add(conversation);
                    await _context.SaveChangesAsync();
                }

                var message = new Message
                {
                    Created = DateTime.Now,
                    CreatedBy = user.FirstName + " " + user.LastName,
                    LastModified = DateTime.Now,
                    LastModifiedBy = user.FirstName + " " + user.LastName,
                    ConversationId = conversation.Id,
                    SenderId = userId,
                    ReceiverId = newMessageVM.ReceiverId,
                    MessageText = newMessageVM.MessageText,
                    IsRead = false,
                    MessageOwnerId = userId
                };

                _context.Messages.Add(message);
                await _context.SaveChangesAsync();

                // Broadcast message to receiver client
                await _chatHubService.SendMessage(message);
                await _chatHubService.SendConversations(message);
                await _chatHubService.SendNumberOfUnreadMessages(message);

                var senderImage = host + SigmaConstants.DefaultUserImage;
                var receiverImage = host + SigmaConstants.DefaultUserImage;

                var sender = await GetUserInformation(message.SenderId);
                if (sender != null)
                {
                    senderImage = host + sender.ProfilePhotoUrl;
                }

                var receiver = await GetUserInformation(message.ReceiverId);
                if (receiver != null)
                {
                    receiverImage = host + receiver.ProfilePhotoUrl;
                }

                MessageResponse addedMessage = new MessageResponse
                {
                    Id = message.Id,
                    Created = message.Created,
                    MessageText = message.MessageText,
                    SenderId = message.SenderId,
                    ReceiverId = message.ReceiverId,
                    IsRead = message.IsRead,
                    MessageOwnerId = message.MessageOwnerId,
                    SenderImage = senderImage,
                    ReceiverImage = receiverImage
                };

                return addedMessage;
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while sending message!");
            }
        }

        public async Task<bool> ReadMessagesAsync(int receiverId)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var host = _userContextService.GetHostUrl();

                var conversation = await _context.Conversations
                    .Where(c => c.UserId1 == userId && c.UserId2 == receiverId || c.UserId1 == receiverId && c.UserId2 == userId)
                    .FirstOrDefaultAsync();

                if (conversation == null)
                {
                    return false;
                }

                var messages = await _context.Messages
                    .Where(m => m.ConversationId == conversation.Id && m.MessageOwnerId != userId && m.IsRead == false)
                    .ToListAsync();

                foreach (var message in messages)
                {
                    message.IsRead = true;
                    await _context.SaveChangesAsync();
                }

                var messageForChatHubService = new Message
                {
                    Created = DateTime.Now,
                    CreatedBy = "",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "",
                    ConversationId = conversation.Id,
                    SenderId = receiverId,
                    ReceiverId = userId,
                    MessageText = "Read",
                    IsRead = true,
                    MessageOwnerId = userId
                };

                await _chatHubService.SendConversations(messageForChatHubService);
                await _chatHubService.SendNumberOfUnreadMessages(messageForChatHubService);

                return true;
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while reading messages!");
            }
        }

        private async Task<ApplicationUser> GetUserInformation(int userId)
        {
            return await _context.Users.FirstOrDefaultAsync(u => u.Id == userId);
        }
    }
}
