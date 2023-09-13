using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Core.Interfaces
{
    public interface IAchievementService
    {
        Task<AchievementResponse> SubmitReviewAsync(AchievementSubmit achievementSubmit);
        Task<AchievementResponse> SubmitRevisionAsync(AchievementSubmit achievementSubmit);
        Task<AchievementResponse> CompleteAsync(int achievementId);
        Task<AchievementResponse> GetByIdAsync(int id);
    }
}
