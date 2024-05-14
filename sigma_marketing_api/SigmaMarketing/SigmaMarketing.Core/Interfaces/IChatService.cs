using SigmaMarketing.Model.Models.PagedList;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Core.Interfaces
{
    public interface IChatService
    {
        Task<PagedList<ConversationResponse>> GetConversationsAsync(int pageNumber, int pageSize);
        Task<PagedList<MessageResponse>> GetConversationChatAsync(int receiverId, int page, int pageSize);
        Task<MessageResponse> SendMessageAsync(NewMessageRequest newMessageVM);
        Task<bool> ReadMessagesAsync(int receiverId);
    }
}
