using SigmaMarketing.Model.Models.PagedList;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Core.Interfaces
{
    public interface ICampaignInfluencerService
    {
        Task<PagedList<CampaignVM>> GetAllAsync(string query, int page, int pageSize);
        Task<DetailsIVM> GetByIdAsync(int id);
        Task<DetailsIVM> UpdateAsync(CampaignStateRequest campaignState);
        Task<MyCampaignsResponse> GetMyCampaignsAsync();
        Task<CampaignVM> ToggleLikeCampaignAsync(int campaignId, bool liked);
    }
}
