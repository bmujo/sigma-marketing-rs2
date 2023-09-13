using SigmaMarketing.Model.Models.Response.Base;

namespace SigmaMarketing.Model.Models.Response
{
    public class CampaignCVM
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public int Likes { get; set; }
        public int Influencers { get; set; }
        public string Image { get; set; }
        public BaseStatus Status { get; set; }
    }
}
