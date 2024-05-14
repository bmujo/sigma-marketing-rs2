namespace SigmaMarketing.Model.Models.Request
{
    public class CampaignAnalyticsRequest
    {
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public List<int>? Statuses { get; set; } = null;
        public List<int>? Platforms { get; set; } = null;
        public List<int>? Tags { get; set; } = null;
        public int Page { get; set; }
        public int PageSize { get; set; }
    }
}
