using Newtonsoft.Json;

namespace SigmaMarketing.Paypal.Model.Response
{
    public class PayoutStatusResponse
    {
        [JsonProperty("batch_header")]
        public BatchHeaderStatus BatchHeader { get; set; }

        [JsonProperty("items")]
        public List<ItemStatus> Items { get; set; }

        [JsonProperty("links")]
        public List<LinkStatus> Links { get; set; }
    }

    public class BatchHeaderStatus
    {
        [JsonProperty("payout_batch_id")]
        public string PayoutBatchId { get; set; }

        [JsonProperty("batch_status")]
        public string BatchStatus { get; set; }

        [JsonProperty("time_created")]
        public DateTimeOffset TimeCreated { get; set; }

        [JsonProperty("sender_batch_header")]
        public SenderBatchHeaderStatus SenderBatchHeader { get; set; }

        [JsonProperty("funding_source")]
        public string FundingSource { get; set; }

        [JsonProperty("amount")]
        public AmountStatus Amount { get; set; }
    }

    public class AmountStatus
    {
        [JsonProperty("currency")]
        public string Currency { get; set; }

        [JsonProperty("value")]
        public string Value { get; set; }
    }

    public class SenderBatchHeaderStatus
    {
        [JsonProperty("sender_batch_id")]
        public Guid SenderBatchId { get; set; }

        [JsonProperty("email_subject")]
        public string EmailSubject { get; set; }
    }

    public class ItemStatus
    {
        [JsonProperty("payout_item_id")]
        public string PayoutItemId { get; set; }

        [JsonProperty("transaction_status")]
        public string TransactionStatus { get; set; }

        [JsonProperty("payout_batch_id")]
        public string PayoutBatchId { get; set; }

        [JsonProperty("payout_item")]
        public PayoutItem PayoutItem { get; set; }

        [JsonProperty("links")]
        public List<LinkStatus> Links { get; set; }
    }

    public class LinkStatus
    {
        [JsonProperty("href")]
        public Uri Href { get; set; }

        [JsonProperty("rel")]
        public string Rel { get; set; }

        [JsonProperty("method")]
        public string Method { get; set; }

        [JsonProperty("encType")]
        public string EncType { get; set; }
    }

    public class PayoutItem
    {
        [JsonProperty("recipient_type")]
        public string RecipientType { get; set; }

        [JsonProperty("amount")]
        public Amount Amount { get; set; }

        [JsonProperty("note")]
        public string Note { get; set; }

        [JsonProperty("receiver")]
        public string Receiver { get; set; }

        [JsonProperty("recipient_wallet")]
        public string RecipientWallet { get; set; }
    }
}
