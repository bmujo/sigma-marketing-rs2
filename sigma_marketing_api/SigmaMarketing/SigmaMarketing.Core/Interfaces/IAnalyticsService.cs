using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Core.Interfaces
{
    public interface IAnalyticsService
    {
        Task<AnalyticsResponse> GetCampaignsAnalyticsAsync(CampaignAnalyticsRequest request);
    }
}
