using SigmaMarketing.Model.Models.PagedList;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Core.Interfaces
{
    public interface ICampaignCompanyService
    {
        Task<DetailsCVM> GetCampaignByIdCompanyAsync(int id);
        Task<PagedList<CampaignCVM>> GetBrandCampaignsAsync(string query, int page, int pageSize);
        Task<string> CreateCampaignAsync(NewCampaignRequest newCampaign);
        Task<CampaignCreateDataResponse> GetCampaignCreateDataAsync();

        Task<bool> InviteUsersAsync(InviteRequest invite);
        Task<DetailsCVM> AcceptUserAsync(int campaignId, int influencerId);
        Task<DetailsCVM> DeclineUserAsync(int campaignId, int influencerId);

        Task<DetailsCVM> GetById(int campaignId);
    }
}
