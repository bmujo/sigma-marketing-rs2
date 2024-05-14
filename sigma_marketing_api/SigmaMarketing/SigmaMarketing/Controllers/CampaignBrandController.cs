using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SigmaMarketing.API.Controllers.Base;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Exceptions;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Models.PagedList;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.API.Controllers
{
    [ApiController]
    [Route("api/[controller]/[action]")]
    public class CampaignBrandController : BaseController
    {
        private readonly ICampaignCompanyService _campaignCompanyService;

        public CampaignBrandController(
            UserManager<ApplicationUser> userManager,
            ICampaignCompanyService campaignCompanyService
            ) : base(userManager)
        {
            _campaignCompanyService = campaignCompanyService;
        }

        // Final endpoints
        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<PagedList<CampaignCVM>>> GetBrandCampaigns(
            string? query = null,
            [FromQuery] int page = 1,
            [FromQuery] int pageSize = 10)
        {
            try
            {
                var response = await _campaignCompanyService.GetBrandCampaignsAsync(query, page, pageSize);
                return Ok(response);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<CampaignVM>> CreateCampaign(NewCampaignRequest newCampaign)
        {
            var response = await _campaignCompanyService.CreateCampaignAsync(newCampaign);
            return Ok(response);
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<CampaignCreateDataResponse>> GetCampaignCreateData()
        {
            var response = await _campaignCompanyService.GetCampaignCreateDataAsync();
            return Ok(response);
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<DetailsCVM>> GetCampaignByIdCompany(int id)
        {
            try
            {
                var response = await _campaignCompanyService.GetCampaignByIdCompanyAsync(id);
                return Ok(response);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<bool>> InviteUsers([FromBody] InviteRequest invite)
        {
            var response = await _campaignCompanyService.InviteUsersAsync(invite);
            return Ok(response);
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<DetailsCVM>> AcceptUser(int campaignId, int influencerId)
        {
            var response = await _campaignCompanyService.AcceptUserAsync(campaignId, influencerId);
            return Ok(response);
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<DetailsCVM>> DeclineUser(int campaignId, int influencerId)
        {
            var response = await _campaignCompanyService.DeclineUserAsync(campaignId, influencerId);
            return Ok(response);
        }
    }
}