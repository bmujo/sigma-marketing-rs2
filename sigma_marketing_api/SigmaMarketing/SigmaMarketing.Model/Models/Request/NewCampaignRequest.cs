namespace SigmaMarketing.Model.Models.Request
{
    public class NewCampaignRequest
    {
        public string Name { get; set; }
        public bool IsActive { get; set; }


        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public DateTime DeadlineForApplications { get; set; }

        public int PaymentTermId { get; set; }


        public string Details { get; set; }
        public int Budget { get; set; }
        public int OpenPositions { get; set; }
        public int Status { get; set; }

        public List<int> Tags { get; set; }
        public List<NewAchievement> Achievements { get; set; }
        public List<string> Photos { get; set; }
        public List<int> Platforms { get; set; }

        public string VideoUrl { get; set; }
        public string AssetsUrl { get; set; }
        public string RequirementsAndContentGuidelines { get; set; }

        public List<int> InvitedInfluencers { get; set; }
    }

    public class NewAchievement
    {
        public string Title { get; set; }
        public string Description { get; set; }
        public int Type { get; set; }
        public int AchievementTypeId { get; set;}
    }
}
