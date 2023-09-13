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
    public class ChatController : BaseController
    {
        private readonly IChatService _chatService;

        public ChatController(UserManager<ApplicationUser> userManager, IChatService chatService) : base(userManager)
        {
            _chatService = chatService;
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<PagedList<ConversationResponse>>> GetConversations(int page = 1, int pageSize = 10)
        {
            var response = await _chatService.GetConversationsAsync(page, pageSize);
            return response;
        }

        [HttpGet]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult<PagedList<MessageResponse>>> GetConversationChat(int receiverId, int page = 1, int pageSize = 20)
        {
            var response = await _chatService.GetConversationChatAsync(receiverId, page, pageSize);

            return Ok(response);
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult> SendMessage([FromBody] NewMessageRequest newMessageVM)
        {
            try
            {
                var addedMessage = await _chatService.SendMessageAsync(newMessageVM);
                return Ok(addedMessage);
            }
            catch (NotFoundException)
            {
                return NotFound();
            }
        }

        [HttpPost]
        [Authorize(AuthenticationSchemes = "Bearer")]
        public async Task<ActionResult> ReadMessages(int receiverId)
        {
            var response = await _chatService.ReadMessagesAsync(receiverId);
            return Ok(response);
        }
    }
}
