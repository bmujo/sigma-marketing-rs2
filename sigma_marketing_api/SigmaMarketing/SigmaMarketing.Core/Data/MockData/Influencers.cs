using SigmaMarketing.Core.Entities;

namespace SigmaMarketing.Core.Data.MockData
{
    public class Influencers
    {
        public List<ApplicationUser> ListOfInfluencers { get; set; }

        public Influencers()
        {
            ListOfInfluencers = new List<ApplicationUser>();
            for (int i = 1; i <= 1500; i++)
            {
                ListOfInfluencers.Add(new ApplicationUser
                {
                    CreatedBy = "System",
                    LastModifiedBy = "System",
                    Created = DateTime.Now,
                    LastModified = DateTime.Now,
                    Id = -3000 + i,
                    FirstName = $"Influencer{i}",
                    LastName = $"LastName{i}",
                    Email = $"influencer_user{i}@sigmamarketing.com",
                    IsInfluencer = true,
                    LockoutEnabled = true,
                    PhoneNumber = $"12345678{i % 10}",
                    ProfilePhotoUrl = "/images/profile/profile_default.png",
                    InstagramLink = "https://www.instagram.com/instagram/",
                    FacebookLink = "https://www.facebook.com/facebook/",
                    TikTokLink = "https://www.tiktok.com/@tiktok",
                    LinkedInLink = "https://www.linkedin.com/company/linkedin/",
                    Bio = $"Bio{i}",
                });
            }
        }
    }
}