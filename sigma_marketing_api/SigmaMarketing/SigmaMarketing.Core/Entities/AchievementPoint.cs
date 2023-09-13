using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class AchievementPoint : BaseEntity
    {
        public string Title { get; set; }
        public string Description { get; set; }

        [ForeignKey(nameof(AchievementType))]
        public int AchievementTypeId { get; set; }
        public AchievementType AchievementType { get; set; }

        [ForeignKey(nameof(Campaign))]
        public int CampaignId { get; set; }
        public Campaign Campaign { get; set; }
    }
}
