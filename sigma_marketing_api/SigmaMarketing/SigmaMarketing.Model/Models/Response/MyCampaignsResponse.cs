namespace SigmaMarketing.Model.Models.Response
{
    public class MyCampaignsResponse
    {
        public List<MyCampaignItem> Finished { get; set; }
        public List<MyCampaignItem> InProgress { get; set; }
        public List<MyCampaignItem> Requested { get; set; }
    }

    public class MyCampaignItem
    {
        public int CampaignId { get; set; }
        public string Image { get; set; }
        public string Name { get; set; }
        public string Location { get; set; }
        public int Stars { get; set; }
        public int Days { get; set; }
        public int DaysPassed { get; set; }
        public string Status { get; set; }
    }
}
