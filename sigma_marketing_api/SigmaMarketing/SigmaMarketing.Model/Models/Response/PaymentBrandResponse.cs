namespace SigmaMarketing.Model.Models.Response
{
    public class PaymentBrandResponse
    {
        public int Balance { get; set; }
        public List<BrandPayments> Payments { get; set; }
    }

    public class BrandPayments
    {
        public int Id { get; set; }
        public string UserFullName { get; set; }
        public string Type { get; set; }
        public double Price { get; set; }
        public int Amount { get; set; }
        public string Status { get; set; }
        public string Campaign { get; set; }
        public string Date { get; set; }
        public string Time { get; set; }
    }
}
