using SigmaMarketing.Core.Entities.Base;

namespace SigmaMarketing.Core.Entities
{
    public class Withdraw : BaseEntity
    {
        public string WithdrawName { get; set; }
        public int AmountSigmaTokens { get; set; }
        public double AmountUSD { get; set; }
        public string Status { get; set; }
        public string PaypalEmail { get; set; }
    }
}
