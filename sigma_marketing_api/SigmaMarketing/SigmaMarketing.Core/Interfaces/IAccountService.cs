using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Core.Interfaces
{
    public interface IAccountService
    {
        Task<TokenResponse> SignInAsync(string email, string password);
        Task<TokenResponse> CreateInfluencerProfileAsync(NewProfile newProfile);
        Task<ProfileResponse> GetProfileAsync();
        Task<ProfileResponse> UpdateProfileAsync(UpdateProfileVM updateProfileVM);
        Task<List<SearchUserResponse>> SearchUsersAsync(string? query);
    }
}
