using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SigmaMarketing.API.Controllers.Base;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Exceptions;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.API.Controllers
{
    [ApiController]
    [Route("api/[controller]/[action]")]
    public class AnalyticsController : BaseController
    {
        private readonly IAnalyticsService _analyticsService;

        public AnalyticsController(
            UserManager<ApplicationUser> userManager,
            IAnalyticsService analyticsService
            ) : base(userManager)
        {
            _analyticsService = analyticsService;
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<AnalyticsResponse>> GetCampaignsAnalytics([FromBody] CampaignAnalyticsRequest request)
        {
            try
            {
                var response = await _analyticsService.GetCampaignsAnalyticsAsync(request);
                return Ok(response);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
