using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class Transfer : BaseEntity
    {
        public int AmountSigmaToken { get; set; }
        public string Status { get; set; }

        [ForeignKey(nameof(CampaignUser))]
        public int CampaignUserId { get; set; }
        public CampaignUser CampaignUser { get; set; }
    }
}
