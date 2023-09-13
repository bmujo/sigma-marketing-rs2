using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class CampaignPlatform : BaseEntity
    {
        [ForeignKey(nameof(Campaign))]
        public int CampaignId { get; set; }
        public Campaign Campaign { get; set; }

        [ForeignKey(nameof(Platform))]
        public int PlatformId { get; set; }
        public Platform Platform { get; set; }
    }
}
