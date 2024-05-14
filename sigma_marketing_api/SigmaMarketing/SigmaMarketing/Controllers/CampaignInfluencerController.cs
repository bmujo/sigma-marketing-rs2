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
    public class CampaignInfluencerController : BaseController
    {
        private readonly ICampaignInfluencerService _campaignInfluencerService;

        public CampaignInfluencerController(
            UserManager<ApplicationUser> userManager,
            ICampaignInfluencerService campaignInfluencerService) : base(userManager)
        {
            _campaignInfluencerService = campaignInfluencerService;
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<PagedList<CampaignVM>>> GetAll(
            string? query = null,
            [FromQuery] int page = 1,
            [FromQuery] int pageSize = 10)
        {
            try
            {
                var response = await _campaignInfluencerService.GetAllAsync(query, page, pageSize);
                return Ok(response);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<DetailsIVM>> Update(CampaignStateRequest campaignState)
        {
            try
            {
                var response = await _campaignInfluencerService.UpdateAsync(campaignState);
                return Ok(response);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }   

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<MyCampaignsResponse>> GetMyCampaigns()
        {
            var response = await _campaignInfluencerService.GetMyCampaignsAsync();
            return Ok(response);
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<DetailsIVM>> GetById(int id)
        {
            try
            {
                var response = await _campaignInfluencerService.GetByIdAsync(id);
                return Ok(response);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<CampaignVM>> ToggleLikeCampaign(int campaignId, bool liked)
        {
            try
            {
                var response = await _campaignInfluencerService.ToggleLikeCampaignAsync(campaignId, liked);
                return Ok(response);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}