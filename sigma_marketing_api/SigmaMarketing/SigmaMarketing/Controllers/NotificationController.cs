using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SigmaMarketing.API.Controllers.Base;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Exceptions;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Models.PagedList;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.API.Controllers
{
    [ApiController]
    [Route("api/[controller]/[action]")]
    public class NotificationController : BaseController
    {
        private readonly INotificationService _notificationService;

        public NotificationController(
            UserManager<ApplicationUser> userManager,
            INotificationService notificationService) : base(userManager)
        {
            _notificationService = notificationService;
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<PagedList<NotificationResponse>>> GetNotifications(int page = 1, int pageSize = 10)
        {
            var notifications = await _notificationService.GetNotificationsAsync(page, pageSize);

            return notifications;
        }

        [HttpPut]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<NotificationResponse>> SetNotificationOpen(int id)
        {
            try
            {
                var notification = await _notificationService.SetNotificationOpenAsync(id);
                return Ok(notification);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<bool>> SaveNotificationToken(string token)
        {
            try
            {
                var result = await _notificationService.SaveNotificationTokenAsync(token);
                return Ok(result);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(ex.Message);
            }
        }   
    }
}
