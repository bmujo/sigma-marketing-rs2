using SigmaMarketing.Core.Entities.Base;

namespace SigmaMarketing.Core.Entities
{
    public class PaymentTerm : BaseEntity
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public int Days { get; set; }
        public ICollection<Campaign> Campaigns { get; set; }
    }
}
