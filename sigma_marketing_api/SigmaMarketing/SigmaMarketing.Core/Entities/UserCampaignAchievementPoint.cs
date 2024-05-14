using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class UserCampaignAchievementPoint : BaseEntity
    {
        public int Status { get; set; }

        [ForeignKey(nameof(User))]
        public int UserId { get; set; }
        public ApplicationUser User { get; set; }

        [ForeignKey(nameof(Campaign))]
        public int CampaignId { get; set; }
        public Campaign Campaign { get; set; }

        [ForeignKey(nameof(AchievementPoint))]
        public int AchievementPointId { get; set; }
        public AchievementPoint AchievementPoint { get; set; }

        public ICollection<AchievementTrackNote> AchievementTrackNotes { get; set; }
    }
}
