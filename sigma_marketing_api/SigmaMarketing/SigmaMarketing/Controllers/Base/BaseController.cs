using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SigmaMarketing.Core.Entities;

namespace SigmaMarketing.API.Controllers.Base
{
    public abstract class BaseController : Controller
    {
        protected UserManager<ApplicationUser> UserManager { get; }

        protected BaseController(UserManager<ApplicationUser> userManager)
        {
            UserManager = userManager;
        }
    }
}
