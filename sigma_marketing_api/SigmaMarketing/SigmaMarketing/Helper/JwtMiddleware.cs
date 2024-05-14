using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace SigmaMarketing.API.Helper
{
    public class JwtMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<JwtMiddleware> _logger;

        public JwtMiddleware(RequestDelegate next, ILogger<JwtMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task Invoke(HttpContext context)
        {
            string authHeader = context.Request.Headers["Authorization"];
            if (authHeader != null && authHeader.StartsWith("Bearer "))
            {
                string token = authHeader.Substring("Bearer ".Length).Trim();
                _logger.LogInformation(authHeader);

                try
                {
                    var handler = new JwtSecurityTokenHandler();
                    var jwtToken = handler.ReadJwtToken(token);
                    context.User = new ClaimsPrincipal(new ClaimsIdentity(jwtToken.Claims));
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error validating JWT token");
                }
            }

            await _next(context);
        }
    }
}
