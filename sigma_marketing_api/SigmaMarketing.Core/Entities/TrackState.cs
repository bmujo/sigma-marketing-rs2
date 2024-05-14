using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class TrackState : BaseEntity
    {
        public string Explanation { get; set; }
        public int Type { get; set; }
        public int UserId { get; set; }

        [ForeignKey(nameof(UserCampaignAchievementPoint))]
        public int UserCampaignAchievementPointId { get; set; }
        public UserCampaignAchievementPoint UserCampaignAchievementPoint { get; set; }
    }
}
