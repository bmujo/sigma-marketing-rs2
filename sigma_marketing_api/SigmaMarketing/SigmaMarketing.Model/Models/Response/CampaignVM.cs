namespace SigmaMarketing.Model.Models.Response
{
    public class CampaignVM
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string ImageUrl { get; set; }
        public string Company { get; set; }
        public int Likes { get; set; }
        public bool Liked { get; set; }
    }
}