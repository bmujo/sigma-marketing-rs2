using Newtonsoft.Json;

namespace SigmaMarketing.Paypal.Model.Response
{
    public partial class OrderResponse
    {
        [JsonProperty("id")]
        public string Id { get; set; }

        [JsonProperty("intent")]
        public string Intent { get; set; }

        [JsonProperty("status")]
        public string Status { get; set; }

        [JsonProperty("payment_source")]
        public PaymentSource PaymentSource { get; set; }

        [JsonProperty("purchase_units")]
        public List<PurchaseUnit> PurchaseUnits { get; set; }

        [JsonProperty("payer")]
        public Payer Payer { get; set; }

        [JsonProperty("create_time")]
        public DateTimeOffset CreateTime { get; set; }

        [JsonProperty("update_time")]
        public DateTimeOffset UpdateTime { get; set; }

        [JsonProperty("links")]
        public List<Link> Links { get; set; }
    }

    public partial class Link
    {
        [JsonProperty("href")]
        public Uri Href { get; set; }

        [JsonProperty("rel")]
        public string Rel { get; set; }

        [JsonProperty("method")]
        public string Method { get; set; }
    }

    public partial class Payer
    {
        [JsonProperty("name")]
        public PayerName Name { get; set; }

        [JsonProperty("email_address")]
        public string EmailAddress { get; set; }

        [JsonProperty("payer_id")]
        public string PayerId { get; set; }

        [JsonProperty("address")]
        public PayerAddress Address { get; set; }
    }

    public partial class PayerAddress
    {
        [JsonProperty("country_code")]
        public string CountryCode { get; set; }
    }

    public partial class PayerName
    {
        [JsonProperty("given_name")]
        public string GivenName { get; set; }

        [JsonProperty("surname")]
        public string Surname { get; set; }
    }

    public partial class PaymentSource
    {
        [JsonProperty("paypal")]
        public Paypal Paypal { get; set; }
    }

    public partial class Paypal
    {
        [JsonProperty("email_address")]
        public string EmailAddress { get; set; }

        [JsonProperty("account_id")]
        public string AccountId { get; set; }

        [JsonProperty("account_status")]
        public string AccountStatus { get; set; }

        [JsonProperty("name")]
        public PayerName Name { get; set; }

        [JsonProperty("address")]
        public PayerAddress Address { get; set; }
    }

    public partial class PurchaseUnit
    {
        [JsonProperty("reference_id")]
        public Guid ReferenceId { get; set; }

        [JsonProperty("amount")]
        public Amount Amount { get; set; }

        [JsonProperty("payee")]
        public Payee Payee { get; set; }

        [JsonProperty("items")]
        public List<Item> Items { get; set; }

        [JsonProperty("shipping")]
        public Shipping Shipping { get; set; }

        [JsonProperty("payments")]
        public Payments Payments { get; set; }
    }

    public partial class Amount
    {
        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }

        [JsonProperty("value")]
        public string Value { get; set; }

        [JsonProperty("breakdown")]
        public Breakdown Breakdown { get; set; }
    }

    public partial class Breakdown
    {
        [JsonProperty("item_total")]
        public ItemTotal ItemTotal { get; set; }

        [JsonProperty("tax_total")]
        public ItemTotal TaxTotal { get; set; }
    }

    public partial class ItemTotal
    {
        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }

        [JsonProperty("value")]
        public string Value { get; set; }
    }

    public partial class Item
    {
        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("unit_amount")]
        public ItemTotal UnitAmount { get; set; }

        [JsonProperty("tax")]
        public ItemTotal Tax { get; set; }

        [JsonProperty("quantity")]
        public long Quantity { get; set; }

        [JsonProperty("description")]
        public string Description { get; set; }
    }

    public partial class Payee
    {
        [JsonProperty("email_address")]
        public string EmailAddress { get; set; }

        [JsonProperty("merchant_id")]
        public string MerchantId { get; set; }
    }

    public partial class Payments
    {
        [JsonProperty("captures")]
        public List<Capture> Captures { get; set; }
    }

    public partial class Capture
    {
        [JsonProperty("id")]
        public string Id { get; set; }

        [JsonProperty("status")]
        public string Status { get; set; }

        [JsonProperty("amount")]
        public ItemTotal Amount { get; set; }

        [JsonProperty("final_capture")]
        public bool FinalCapture { get; set; }

        [JsonProperty("seller_protection")]
        public SellerProtection SellerProtection { get; set; }

        [JsonProperty("seller_receivable_breakdown")]
        public SellerReceivableBreakdown SellerReceivableBreakdown { get; set; }

        [JsonProperty("links")]
        public List<Link> Links { get; set; }

        [JsonProperty("create_time")]
        public DateTimeOffset CreateTime { get; set; }

        [JsonProperty("update_time")]
        public DateTimeOffset UpdateTime { get; set; }
    }

    public partial class SellerProtection
    {
        [JsonProperty("status")]
        public string Status { get; set; }

        [JsonProperty("dispute_categories")]
        public List<string> DisputeCategories { get; set; }
    }

    public partial class SellerReceivableBreakdown
    {
        [JsonProperty("gross_amount")]
        public ItemTotal GrossAmount { get; set; }

        [JsonProperty("paypal_fee")]
        public ItemTotal PaypalFee { get; set; }

        [JsonProperty("net_amount")]
        public ItemTotal NetAmount { get; set; }
    }

    public partial class Shipping
    {
        [JsonProperty("name")]
        public ShippingName Name { get; set; }

        [JsonProperty("address")]
        public ShippingAddress Address { get; set; }
    }

    public partial class ShippingAddress
    {
        [JsonProperty("address_line_1")]
        public string AddressLine1 { get; set; }

        [JsonProperty("admin_area_2")]
        public string AdminArea2 { get; set; }

        [JsonProperty("postal_code")]
        public long PostalCode { get; set; }

        [JsonProperty("country_code")]
        public string CountryCode { get; set; }
    }

    public partial class ShippingName
    {
        [JsonProperty("full_name")]
        public string FullName { get; set; }
    }
}
