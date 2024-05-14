using SigmaMarketing.Model.Models.Response.Base;

namespace SigmaMarketing.Model.Models.Response
{
    public class AchievementResponse
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public AchievementTypeResponse Type { get; set; }
        public BaseStatus Status { get; set; }
        public List<TrackNoteItem> TrackNotes { get; set; } = new List<TrackNoteItem>();
    }

    public class TrackNoteItem
    {
        public string Type { get; set; }
        public string Comment { get; set; }
        public DateTime CreatedAt { get; set; }
    }

    public class AchievementTypeResponse
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Explanation { get; set; }
        public string ImageUrl { get; set; }
        public int Value { get; set; }
        public double ValueCash { get; set; }
        public int Type { get; set; }
    }
}
