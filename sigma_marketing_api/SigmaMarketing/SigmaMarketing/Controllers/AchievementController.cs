using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SigmaMarketing.API.Controllers.Base;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.API.Controllers
{
    [ApiController]
    [Route("api/[controller]/[action]")]
    public class AchievementController : BaseController
    {
        private readonly IAchievementService _achievementService;

        public AchievementController(UserManager<ApplicationUser> userManager, IAchievementService achievementService) : base(userManager)
        {
            _achievementService = achievementService;
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<AchievementResponse>> GetById(int id)
        {
            try
            {
                var response = await _achievementService.GetByIdAsync(id);
                return Ok(response);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<AchievementResponse>> SubmitReview([FromBody] AchievementSubmit achievementSubmit)
        {
            var response = await _achievementService.SubmitReviewAsync(achievementSubmit);
            return response;
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<AchievementResponse>> Complete(int achievementId)
        {
            var response = await _achievementService.CompleteAsync(achievementId);
            return response;
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<AchievementResponse>> SubmitRevision([FromBody] AchievementSubmit achievementSubmit)
        {
            var response = await _achievementService.SubmitRevisionAsync(achievementSubmit);
            return response;
        }
    }
}
