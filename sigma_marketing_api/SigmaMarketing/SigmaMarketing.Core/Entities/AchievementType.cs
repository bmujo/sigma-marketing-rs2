using SigmaMarketing.Core.Entities.Base;

namespace SigmaMarketing.Core.Entities
{
    public class AchievementType : BaseEntity
    {
        public int Type { get; set; }
        public string ImageUrl { get; set; }
        public string Name { get; set; }
        public string Explanation { get; set; }
        public int Value { get; set; }
    }
}
