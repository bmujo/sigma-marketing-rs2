using SigmaMarketing.Model.Models.PagedList;
using SigmaMarketing.Model.Models.Response.Base;

namespace SigmaMarketing.Model.Models.Response
{
    public class AnalyticsResponse
    {
        public int Total { get; set; }
        public List<PlatformItem> Platforms { get; set; }
        public List<int> ListNumberOfApplications { get; set; }
        public int FinishedCampaignsCount { get; set; }
        public PagedList<AnalyticsItem> CampaignsList { get; set; }
        public List<DropdownItem> AvailableTags { get; set; }
        public List<DropdownItem> AllPlatforms { get; set; }
        public List<DropdownItem> AllStatuses { get; set; }

    }

    public class AnalyticsItem
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime Start { get; set; }
        public DateTime End { get; set; }
        public int Budget { get; set; }
        public int NumberOfApplications { get; set; }
        public int NumberOfParticipants { get; set; }
        public double EngagementRate { get; set; }
        public double ROI { get; set; }
        public BaseStatus Status { get; set; }
    }

    public class PlatformItem
    {
        public string Name { get; set; }
        public int Percentage { get; set; }
    }

    public class DropdownItem
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
