using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class Campaign : BaseEntity
    {
        public string Name { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public DateTime DeadlineForApplications { get; set; }

        public string Details { get; set; }
        public int Budget { get; set; }
        public int OpenPositions { get; set; }

        public int Status { get; set; } // connected to enum
        public bool IsActive { get; set; }

        public string VideoUrl { get; set; }
        public string AssetsUrl { get; set; }
        public string RequirementsAndContentGuidelines { get; set; }


        [ForeignKey(nameof(PaymentTerm))]
        public int PaymentTermId { get; set; }
        public PaymentTerm PaymentTerm { get; set; }


        [ForeignKey(nameof(Company))]
        public int CompanyId { get; set; }
        public ApplicationUser Company { get; set; }


        public ICollection<CampaignUser> CampaignUsers { get; set; }
        public ICollection<CampaignTag> CampaignTags { get; set; }
        public ICollection<CampaignPlatform> CampaignPlatforms { get; set; }
        public ICollection<AchievementPoint> AchievementPoints { get; set; }
        public ICollection<Photo> CampaignPhotos { get; set; }
    }
}
