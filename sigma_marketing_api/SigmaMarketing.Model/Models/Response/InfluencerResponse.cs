using SigmaMarketing.Model.Models.Response.Base;

namespace SigmaMarketing.Model.Models.Response
{
    public class InfluencerResponse
    {
        public int Id { get; set; }
        public string ImageUrl { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public BaseStatus Status { get; set; }
        public int CurrentEarningSigma { get; set; }
        public double CurrentEarningCash { get; set; }
        public List<AchievementResponse> Achievements { get; set; }
    }
}
