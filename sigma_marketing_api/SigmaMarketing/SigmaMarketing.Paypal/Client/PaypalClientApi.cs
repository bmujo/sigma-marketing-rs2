using IdentityModel.Client;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using SigmaMarketing.Paypal.Model.Response;
using System.Net.Http.Headers;
using System.Text;

namespace SigmaMarketing.Paypal.Client
{
    public class PaypalClientApi
    {
        private HttpClient _client;

        private string _baseUrl;
        private string _clientId;
        private string _clientSecret;

        public PaypalClientApi(string baseUrl, string cliendId, string clientSecret)
        {
            _baseUrl = baseUrl;
            _clientId = cliendId;
            _clientSecret = clientSecret;

            CreateHttpClient();
        }

        private void CreateHttpClient()
        {
            _client = new HttpClient();
        }

        public async Task<AuthorizationResponseData> GetAuthorizationRequest()
        {
            EnsureHttpClientCreated();

            var byteArray = Encoding.ASCII.GetBytes($"{_clientId}:{_clientSecret}");
            _client.DefaultRequestHeaders.Authorization =
                new AuthenticationHeaderValue("Basic", Convert.ToBase64String(byteArray));

            var keyValueParis = new List<KeyValuePair<string, string>>
                { new KeyValuePair<string, string>("grant_type", "client_credentials") };

            var response = await _client.PostAsync($"{_baseUrl}/v1/oauth2/token", new FormUrlEncodedContent(keyValueParis));

            var responseAsString = await response.Content.ReadAsStringAsync();

            var authorizationResponse = JsonConvert.DeserializeObject<AuthorizationResponseData>(responseAsString);

            return authorizationResponse;
        }

        public async Task<bool> AuthorizeClient()
        {

            var authorizationResponse = await GetAuthorizationRequest();

            if (authorizationResponse == null)
            {
                return false;
            }

            _client.DefaultRequestHeaders.Authorization =
                new AuthenticationHeaderValue("Bearer", authorizationResponse.access_token);

            return true;
        }

        public async Task<OrderResponse> GetOrderDetails(string orderId)
        {
            EnsureHttpClientCreated();

            var response = await _client.GetAsync($"{_baseUrl}/v2/checkout/orders/{orderId}");

            var responseAsString = await response.Content.ReadAsStringAsync();

            var result = JsonConvert.DeserializeObject<OrderResponse>(responseAsString);

            return result;
        }

        public async Task<bool> VerifyEvent(string json, IHeaderDictionary headerDictionary)
        {
            // !!IMPORTANT!!
            // Without this direct JSON serialization, PayPal WILL ALWAYS return verification_status = "FAILURE".
            // This is probably because the order of the fields are different and PayPal does not sort them. 
            var paypalVerifyRequestJsonString = $@"{{
				""transmission_id"": ""{headerDictionary["PAYPAL-TRANSMISSION-ID"][0]}"",
				""transmission_time"": ""{headerDictionary["PAYPAL-TRANSMISSION-TIME"][0]}"",
				""cert_url"": ""{headerDictionary["PAYPAL-CERT-URL"][0]}"",
				""auth_algo"": ""{headerDictionary["PAYPAL-AUTH-ALGO"][0]}"",
				""transmission_sig"": ""{headerDictionary["PAYPAL-TRANSMISSION-SIG"][0]}"",
				""webhook_id"": ""6WC685942N447610S"",
				""webhook_event"": {json}
				}}";

            var content = new StringContent(paypalVerifyRequestJsonString, Encoding.UTF8, "application/json");

            var resultResponse = await _client.PostAsync($"{_baseUrl}/v1/notifications/verify-webhook-signature", content);

            var responseBody = await resultResponse.Content.ReadAsStringAsync();

            var verifyWebhookResponse = JsonConvert.DeserializeObject<WebHookVerificationResponse>(responseBody);

            if (verifyWebhookResponse.verification_status != "SUCCESS")
            {
                return false;
            }

            return true;
        }

        public async Task<PayoutResponse> InitiatePayout(string influencerPayPalEmail, decimal amount)
        {
            EnsureHttpClientCreated();

            var payoutRequestBody = new
            {
                sender_batch_header = new
                {
                    email_subject = "Payout from Your Company",
                    sender_batch_id = Guid.NewGuid().ToString()
                },
                items = new List<object>
        {
            new
            {
                recipient_type = "EMAIL",
                amount = new
                {
                    value = amount.ToString("0.00"),
                    currency = "USD"
                },
                receiver = influencerPayPalEmail,
                note = "Thank you for your contributions!"
            }
        }
            };

            var payoutRequestJson = JsonConvert.SerializeObject(payoutRequestBody);

            var content = new StringContent(payoutRequestJson, Encoding.UTF8, "application/json");

            var response = await _client.PostAsync($"{_baseUrl}/v1/payments/payouts", content);

            var responseAsString = await response.Content.ReadAsStringAsync();

            var payoutResponse = JsonConvert.DeserializeObject<PayoutResponse>(responseAsString);

            return payoutResponse;
        }

        public async Task<PayoutStatusResponse> CheckWithdrawPayout(string payoutBatchId)
        {
            EnsureHttpClientCreated();

            var response = await _client.GetAsync($"{_baseUrl}/v1/payments/payouts/{payoutBatchId}");

            var responseAsString = await response.Content.ReadAsStringAsync();

            var payoutStatusResponse = JsonConvert.DeserializeObject<PayoutStatusResponse>(responseAsString);

            return payoutStatusResponse;
        }

        public void SetToken(string token)
        {
            _client.SetBearerToken(token);
        }
        private void EnsureHttpClientCreated()
        {
            if (_client == null)
            {
                CreateHttpClient();
            }
        }
    }
}
