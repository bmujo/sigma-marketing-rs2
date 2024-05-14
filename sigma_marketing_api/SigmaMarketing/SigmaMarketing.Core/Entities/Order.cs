using SigmaMarketing.Core.Entities.Base;
using System.ComponentModel.DataAnnotations.Schema;

namespace SigmaMarketing.Core.Entities
{
    public class Order : BaseEntity
    {
        public int OrderStatus { get; set; }
        public string Type { get; set; }
        public double Price { get; set; }
        public int Quantity { get; set; }

        [ForeignKey(nameof(Brand))]
        public int BrandId { get; set; }
        public ApplicationUser Brand { get; set; }

        // Paypal payer
        public string PaypalGivenName { get; set; }
        public string PaypalSurname { get; set; }
        public string PaypalEmailAddress { get; set; }
        public string PaypalPayerId { get; set; }

        // Paypal order
        public string PaypalOrderId { get; set; }
        public string PaypalIntent { get; set; }
        public string PaypalStatus { get; set; }

        // Paypal unit
        public string PaypalCurrencyCode { get; set; }
        public string PaypalValue { get; set; }
    }
}
