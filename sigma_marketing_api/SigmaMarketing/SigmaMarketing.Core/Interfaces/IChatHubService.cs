using SigmaMarketing.Core.Entities;

namespace SigmaMarketing.Core.Interfaces
{
    public interface IChatHubService
    {
        Task SendMessage(Message message);
        Task SendConversations(Message message);
        Task SendNumberOfUnreadMessages(Message message);
    }
}
