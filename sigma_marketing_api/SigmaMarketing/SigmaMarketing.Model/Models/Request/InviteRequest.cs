namespace SigmaMarketing.Model.Models.Request
{
    public class InviteRequest
    {
        public int CampaignId { get; set; }
        public List<int> Users { get; set; }
    }
}
