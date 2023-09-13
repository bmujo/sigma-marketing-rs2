using SigmaMarketing.Core.Entities;

namespace SigmaMarketing.Core.Data.MockData
{
    public class Platforms
    {
        public List<Platform> ListOfPlatforms { get; set; }

        public Platforms()
        {
            ListOfPlatforms = GetPlatforms();
        }

        public static List<Platform> GetPlatforms()
        {
            return new List<Platform>
            {
                new Platform
                {
                    Id = -44110,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Facebook"
                },
                new Platform
                {
                    Id = -44111,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Instagram"
                },
                new Platform
                {
                    Id = -44112,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Twitter/X"
                },
                new Platform
                {
                    Id = -44113,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Youtube"
                },
                new Platform
                {
                    Id = -44114,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "TikTok"
                },
                new Platform
                {
                    Id = -44115,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Snapchat"
                },
                new Platform
                {
                    Id = -44116,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Pinterest"
                },
                new Platform
                {
                    Id = -44117,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "LinkedIn"
                },
                new Platform
                {
                    Id = -44118,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Twitch"
                },
                new Platform
                {
                    Id = -44119,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Reddit"
                },
                new Platform
                {
                    Id = -44120,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Location Based"
                },
                new Platform
                {
                    Id = -44121,
                    Created = DateTime.Now,
                    CreatedBy = "System",
                    LastModified = DateTime.Now,
                    LastModifiedBy = "System",
                    Name = "Other"
                }
            };
        }   
    }
}
