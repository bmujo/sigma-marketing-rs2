namespace SigmaMarketing.Model.Models.Request
{
    public class CampaignStateRequest
    {
        public int CampaignId { get; set; }
        public int CampaignUserStatus { get; set; }
        public bool IsUpdateStatus { get; set; }
        public bool Liked { get; set; }
    }
}
