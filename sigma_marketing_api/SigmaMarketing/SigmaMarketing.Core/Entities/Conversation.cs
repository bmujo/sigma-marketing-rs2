using SigmaMarketing.Core.Entities.Base;

namespace SigmaMarketing.Core.Entities
{
    public class Conversation : BaseEntity
    {
        public int UserId1 { get; set; }
        public int UserId2 { get; set; }

        public ICollection<Message> Messages { get; set; }
    }
}
