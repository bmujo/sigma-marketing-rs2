using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class CampaignUser : BaseEntity
    {
        public int ReviewMark { get; set; }
        public string ReviewMessage { get; set; }
        public int Status { get; set; }

        [ForeignKey(nameof(Influencer))]
        public int InfluencerId { get; set; }
        public ApplicationUser Influencer { get; set; }

        [ForeignKey(nameof(Campaign))]
        public int CampaignId { get; set; }
        public Campaign Campaign { get; set; }
    }
}
