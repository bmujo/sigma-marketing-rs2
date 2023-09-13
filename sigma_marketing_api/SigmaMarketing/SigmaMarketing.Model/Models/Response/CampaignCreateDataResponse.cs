namespace SigmaMarketing.Model.Models.Response
{
    public class CampaignCreateDataResponse
    {
        public List<PlatformData> Platforms { get; set; }
        public List<TagData> Tags { get; set; }
        public List<PaymentTermsData> PaymentTerms { get; set; }
        public List<AchievementTypeResponse> AchievementTypes { get; set; }
    }

    public class PlatformData
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class TagData
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class PaymentTermsData
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
