using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class AchievementTrackNote : BaseEntity
    {
        public string Type { get; set; }
        public string Comment { get; set; }

        [ForeignKey(nameof(UserCampaignAchievementPoint))]
        public int UserCampaignAchievementPointId { get; set; }
        public UserCampaignAchievementPoint UserCampaignAchievementPoint { get; set; }
    }
}
