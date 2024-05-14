using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class LikedCampaign : BaseEntity
    {
        [ForeignKey(nameof(Campaign))]
        public int CampaignId { get; set; }
        public Campaign Campaign { get; set; }

        [ForeignKey(nameof(Influencer))]
        public int InfluencerId { get; set; }
        public ApplicationUser Influencer { get; set; }
    }
}
