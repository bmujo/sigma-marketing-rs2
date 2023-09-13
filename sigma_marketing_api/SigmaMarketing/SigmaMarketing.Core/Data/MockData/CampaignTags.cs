using SigmaMarketing.Core.Entities;

namespace SigmaMarketing.Core.Data.MockData
{
    public class CampaignTags
    {
        public List<CampaignTag> ListOfCampaignTags{ get; set; }

        public CampaignTags()
        {
            var id = -15000;
            ListOfCampaignTags = new List<CampaignTag>();
            for (int i = -42; i <= -5; i++)
            {
                for(int j = 0; j < 5; j++)
                {
                    Random rnd = new Random();
                    var tagId = -1 * rnd.Next(10000, 10112);
                    id++;
                    ListOfCampaignTags.Add(new CampaignTag
                    {
                        Created = DateTime.UtcNow,
                        CreatedBy = "System",
                        LastModified = DateTime.UtcNow,
                        LastModifiedBy = "System",
                        Id = id,
                        CampaignId = i,
                        TagId = tagId,
                    });
                }
            }
        }
    }
}
