using SigmaMarketing.Core.Entities.Base;

namespace SigmaMarketing.Core.Entities
{
    public class HubConnection : BaseEntity
    {
        public string ConnectionId { get; set; }
        public int UserId { get; set; }
    }
}
