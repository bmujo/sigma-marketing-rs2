namespace SigmaMarketing.Model.Models.Response
{
    public class DetailsIVM
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Details { get; set; }
        public int MaxPositions { get; set; }
        public DateTime Start { get; set; }
        public DateTime End { get; set; }
        public List<string> Photos { get; set; }
        public string VideoUrl { get; set; }
        public string Company { get; set; }
        public int Likes { get; set; }
        public int Influencers { get; set; }
        public bool Liked { get; set; }
        public int CampaignStatus { get; set; }
        public List<string> Tags { get; set; }
        public List<AchievementResponse> AchievementPoints { get; set; }
        public int CampaignUserStatus { get; set; }

        public string CompanyBio { get; set; }
        public string CompanyImageUrl { get; set; }

        public string CampaignLocation { get; set; }
    }
}
