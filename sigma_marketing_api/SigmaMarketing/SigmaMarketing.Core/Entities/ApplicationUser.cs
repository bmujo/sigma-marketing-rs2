using Microsoft.AspNetCore.Identity;

namespace SigmaMarketing.Core.Entities
{
    public class ApplicationUser : IdentityUser<int>
    {
        public DateTime Created { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? LastModified { get; set; }
        public string LastModifiedBy { get; set; }
        
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string? Gender { get; set; }

        public DateTime? BirthDate { get; set; }

        public DateTime? RegistrationDate { get; set; }

        public string InstagramLink { get; set; }
        public string TikTokLink { get; set; }
        public string LinkedInLink { get; set; }
        public string FacebookLink { get; set; }
        public string Bio { get; set; }

        public string ProfilePhotoUrl { get; set; }
        public bool IsInfluencer { get; set; } = false;

        public int Balance { get; set; } = 0;
        public string NotificationToken { get; set; } = "";
        public string PaypalEmail { get; set; } = "";

        public ICollection<CampaignUser> CampaignUsers { get; set; }
    }
}
