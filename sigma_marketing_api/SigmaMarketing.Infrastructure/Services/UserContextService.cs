using Microsoft.AspNetCore.Http;
using SigmaMarketing.Core.Interfaces;
using System.Security.Claims;

namespace SigmaMarketing.Infrastructure.Services
{
    public class UserContextService : IUserContextService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public UserContextService(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public int GetCurrentUserId()
        {
            var userId = int.Parse(_httpContextAccessor.HttpContext.User.FindFirst(ClaimTypes.NameIdentifier).Value);
            return userId;
        }

        public string GetHostUrl()
        {
            var request = _httpContextAccessor.HttpContext.Request;
            return request.Scheme + "://" + request.Host.Value;
        }
    }
}
