namespace SigmaMarketing.Model.Models.Request.SigmaToken
{
    public class PurchaseRequest
    {
        public string OrderId { get; set; }
        public string Package { get; set; }
        public string PayerId { get; set; }
    }
}
