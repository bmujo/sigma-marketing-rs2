using SigmaMarketing.Core.Entities.Base;

namespace SigmaMarketing.Core.Entities
{
    public class Platform : BaseEntity
    {
        // YouTube, Instagram...
        public string Name { get; set; }
        public bool IsVisible { get; set; }
    }
}
