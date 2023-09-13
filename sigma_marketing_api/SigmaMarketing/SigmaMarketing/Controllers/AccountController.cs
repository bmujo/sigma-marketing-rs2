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
    public class AccountController : BaseController
    {
        private readonly IAccountService _accountService;

        public AccountController(UserManager<ApplicationUser> userManager, IAccountService accountService) : base(userManager)
        {
            _accountService = accountService;
        }

        [HttpPost]
        public async Task<IActionResult> SignIn(string email, string password)
        {
            try
            {
                var token = await _accountService.SignInAsync(email, password);
                return Ok(token);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        public async Task<IActionResult> CreateInfluencerProfile(NewProfile newProfile)
        {
            try
            {
                var token = await _accountService.CreateInfluencerProfileAsync(newProfile);
                return Ok(token);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<IActionResult> GetProfile()
        {
            var response = await _accountService.GetProfileAsync();
            return Ok(response);
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<IActionResult> UpdateProfile(UpdateProfileVM updateProfileVM)
        {
            try
            {
                var profileUpdated = await _accountService.UpdateProfileAsync(updateProfileVM);
                return Ok(profileUpdated);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<List<SearchUserResponse>>> SearchUsers(string? query = null)
        {
            var response = await _accountService.SearchUsersAsync(query);
            return Ok(response);
        }
    }
}