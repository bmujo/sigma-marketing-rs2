using SigmaMarketing.Model.Models.Response.Base;

namespace SigmaMarketing.Model.Models.Response
{
    public class DetailsCVM
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Details { get; set; }
        public int Budget { get; set; }
        public int MaxPositions { get; set; }
        public DateTime Start { get; set; }
        public DateTime End { get; set; }
        public DateTime DeadlineForApplications { get; set; }
        public string ImageUrl { get; set; }
        public string VideoUrl { get; set; }
        public string AssetsUrl { get; set; }
        public string RequirementsAndContentGuidelines { get; set; }
        public int Likes { get; set; }
        public int Influencers { get; set; }
        public BaseStatus CampaignStatus { get; set; }
        public bool isActive { get; set; }
        public List<TagData> Tags { get; set; }
        public List<AchievementResponse> AchievementPoints { get; set; }
        public List<PlatformData> Platforms { get; set; }
        public PaymentTermsData PaymentTerms { get; set; }
        public List<InfluencerResponse> CurrentInfluencers { get; set; }
        public CampaignCreateDataResponse CampaignCreateData { get; set; }
    }
}
