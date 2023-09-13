using Newtonsoft.Json;

namespace SigmaMarketing.Paypal.Model.Response
{
    public class PayoutResponse
    {
        [JsonProperty("batch_header")]
        public BatchHeader batch_header { get; set; }

        [JsonProperty("links")]
        public List<LinkPaypal> links { get; set; }
    }

    public class BatchHeader
    {
        [JsonProperty("payout_batch_id")]
        public string payout_batch_id { get; set; }

        [JsonProperty("batch_status")]
        public string batch_status { get; set; }

        [JsonProperty("sender_batch_header")]
        public SenderBatchHeader sender_batch_header { get; set; }
    }

    public class SenderBatchHeader
    {
        [JsonProperty("sender_batch_id")]
        public string sender_batch_id { get; set; }

        [JsonProperty("email_subject")]
        public string email_subject { get; set; }
    }

    public class LinkPaypal
    {
        [JsonProperty("href")]
        public string href { get; set; }

        [JsonProperty("rel")]
        public string rel { get; set; }

        [JsonProperty("method")]
        public string method { get; set; }

        [JsonProperty("encType")]
        public string encType { get; set; }
    }
}
