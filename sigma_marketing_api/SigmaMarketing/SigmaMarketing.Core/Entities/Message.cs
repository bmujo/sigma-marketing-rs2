using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class Message : BaseEntity
    {
        public string MessageText { get; set; }
        public int SenderId { get; set; }
        public int ReceiverId { get; set; }
        public int MessageOwnerId { get; set; }
        public bool IsRead { get; set; }

        [ForeignKey(nameof(Conversation))]
        public int ConversationId { get; set; }
        public Conversation Conversation { get; set; }
    }
}
