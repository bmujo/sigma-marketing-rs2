using SigmaMarketing.Core.Entities;

namespace SigmaMarketing.Core.Data.MockData
{
    public class CampaignPlatforms
    {
        public List<CampaignPlatform> ListOfCampaignPlatforms { get; set; }

        public CampaignPlatforms()
        {
            var id = -16000;
            ListOfCampaignPlatforms = new List<CampaignPlatform>();
            for (int i = -42; i <= -5; i++)
            {
                for (int j = 0; j < 2; j++)
                {
                    Random rnd = new Random();
                    var platformId = -1 * rnd.Next(44110, 44121);
                    id++;
                    ListOfCampaignPlatforms.Add(new CampaignPlatform
                    {
                        Created = DateTime.UtcNow,
                        CreatedBy = "System",
                        LastModified = DateTime.UtcNow,
                        LastModifiedBy = "System",
                        Id = id,
                        CampaignId = i,
                        PlatformId = platformId,
                    });
                }
            }
        }
    }
}
