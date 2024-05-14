using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class Video : BaseEntity
    {
        public string Name { get; set; }
        public string VideoUrl { get; set; }


        [ForeignKey(nameof(Campaign))]
        public int CampaignId { get; set; }
        public Campaign Campaign { get; set; }
    }
}
