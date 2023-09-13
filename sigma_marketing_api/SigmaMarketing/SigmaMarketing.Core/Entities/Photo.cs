using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class Photo : BaseEntity
    {
        public string Name { get; set; }
        public string ImageUrl { get; set; }
        public int Position { get; set; }

        [ForeignKey(nameof(Campaign))]
        public int CampaignId { get; set; }
        public Campaign Campaign { get; set; }
    }
}
