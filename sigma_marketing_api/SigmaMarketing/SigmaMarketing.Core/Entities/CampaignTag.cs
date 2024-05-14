using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class CampaignTag : BaseEntity
    {
        [ForeignKey(nameof(Campaign))]
        public int CampaignId { get; set; }
        public Campaign Campaign { get; set; }

        [ForeignKey(nameof(Tag))]
        public int TagId { get; set; }
        public Tag Tag { get; set; }
    }
}
