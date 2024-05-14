namespace SigmaMarketing.Model.Models.Response
{
    public class PaymentUserResponse
    {
        public int Balance { get; set; }
        public string PaypalEmail { get; set; }
        public List<PaymentUserItem> Payments { get; set; }
    }

    public class PaymentUserItem
    {
        public string Type { get; set; }
        public decimal Price { get; set; }
        public int Amount { get; set; }
        public string Status { get; set; }
        public string Campaign { get; set; }
        public DateTime Date { get; set; }
    }
}
