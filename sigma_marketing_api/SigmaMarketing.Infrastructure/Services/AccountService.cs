using Duende.IdentityServer.Extensions;
using FluentValidation.Results;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using SigmaMarketing.Core.Data;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Exceptions;
using SigmaMarketing.Core.Helper;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Request.Validators;
using SigmaMarketing.Model.Models.Response;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace SigmaMarketing.Infrastructure.Services
{
    public class AccountService : IAccountService
    {
        private readonly SignInManager<ApplicationUser> _signInManager;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly ApplicationDbContext _context;
        private readonly IConfiguration _config;
        private readonly IUserContextService _userContextService;

        public AccountService(
            SignInManager<ApplicationUser> signInManager, 
            UserManager<ApplicationUser> userManager, 
            ApplicationDbContext context, 
            IConfiguration config, 
            IUserContextService userContextService
            )
        {
            _signInManager = signInManager;
            _userManager = userManager;
            _context = context;
            _config = config;
            _userContextService = userContextService;
        }

        public async Task<TokenResponse> SignInAsync(string email, string password)
        {
            var token = await Login(email, password);
            if (token == null)
            {
                throw new BadRequestException("Username or password is incorrect!");
            }
            return token;
        }

        public async Task<TokenResponse> CreateInfluencerProfileAsync(NewProfile newProfile)
        {
            ApplicationUser userInfluencer = new ApplicationUser()
            {
                UserName = newProfile.Email,
                FirstName = newProfile.FirstName,
                LastName = newProfile.LastName,
                Email = newProfile.Email,
                NormalizedEmail = newProfile.Email.ToUpper(),
                LockoutEnabled = true,
                IsInfluencer = true,
                Gender = newProfile.Gender,
                PhoneNumber = newProfile.PhoneNumber,
                ProfilePhotoUrl = SigmaConstants.DefaultUserImage,
                InstagramLink = "https://www.instagram.com/",
                FacebookLink = "https://www.facebook.com/",
                TikTokLink = "https://www.tiktok.com/",
                LinkedInLink = "https://www.linkedin.com/",
            };

            PasswordHasher<ApplicationUser> passwordHasher2 = new PasswordHasher<ApplicationUser>();
            userInfluencer.PasswordHash = passwordHasher2.HashPassword(userInfluencer, newProfile.Password);

            _context.Users.Add(userInfluencer);
            _context.SaveChanges();

            var token = await Login(newProfile.Email, newProfile.Password);
            if (token == null)
            {
                throw new BadRequestException("Username or password is incorrect!");
            }
            return token;
        }

        public async Task<ProfileResponse> GetProfileAsync()
        {
            var userId = _userContextService.GetCurrentUserId();
            var host = _userContextService.GetHostUrl();

            ProfileResponse model = await _context.Users.Where(x => x.Id == userId)
                .Select(x => new ProfileResponse
                {
                    Id = x.Id,
                    Email = x.Email,
                    FirstName = x.FirstName,
                    LastName = x.LastName,
                    Instagram = x.InstagramLink,
                    TikTok = x.TikTokLink,
                    Facebook = x.FacebookLink,
                    LinkedIn = x.LinkedInLink,
                    Bio = x.Bio == null ? "" : x.Bio,
                    ProfileImageUrl = host + x.ProfilePhotoUrl
                }).FirstOrDefaultAsync();

            return model;
        }

        public async Task<ProfileResponse> UpdateProfileAsync(UpdateProfileVM updateProfileVM)
        {
            var userId = _userContextService.GetCurrentUserId();
            var host = _userContextService.GetHostUrl();

            UpdateProfileVMValidator validator = new UpdateProfileVMValidator();
            ValidationResult results = validator.Validate(updateProfileVM);

            if (!results.IsValid)
            {
                throw new BadRequestException(results.Errors.ToString());
            }

            var user = _context.Users.Where(x => x.Id == userId).FirstOrDefault();
            if (user == null)
            {
                throw new BadRequestException("Username not fount!");
            }

            user.FirstName = updateProfileVM.FirstName;
            user.LastName = updateProfileVM.LastName;
            user.Email = updateProfileVM.Email;
            user.NormalizedEmail = updateProfileVM.Email.ToUpper();

            user.Bio = updateProfileVM.Bio;
            user.InstagramLink = updateProfileVM.Instagram;
            user.TikTokLink = updateProfileVM.TikTok;
            user.FacebookLink = updateProfileVM.Facebook;
            user.LinkedInLink = updateProfileVM.LinkedIn;

            if (updateProfileVM.ProfileImage != null)
            {
                //Generate unique filename
                string extension = ".png";
                var filename = $"{Guid.NewGuid()}{extension}";
                string filepath = "wwwroot/images/profile/" + filename;
                string filepathToSave = "/images/profile/" + filename;
                var bytess = Convert.FromBase64String(updateProfileVM.ProfileImage);
                using (var imageFile = new FileStream(filepath, FileMode.Create))
                {
                    imageFile.Write(bytess, 0, bytess.Length);
                    imageFile.Flush();
                }

                user.ProfilePhotoUrl = filepathToSave;
            }

            _context.SaveChanges();

            ProfileResponse model = await _context.Users.Where(x => x.Id == userId)
                .Select(x => new ProfileResponse
                {
                    Id = x.Id,
                    Email = x.Email,
                    FirstName = x.FirstName,
                    LastName = x.LastName,
                    Instagram = x.InstagramLink,
                    TikTok = x.TikTokLink,
                    Facebook = x.FacebookLink,
                    LinkedIn = x.LinkedInLink,
                    Bio = x.Bio,
                    ProfileImageUrl = host + x.ProfilePhotoUrl
                }).FirstOrDefaultAsync();

            return model;
        }

        public async Task<List<SearchUserResponse>> SearchUsersAsync(string? query)
        {
            var host = _userContextService.GetHostUrl();

            if (query.IsNullOrEmpty())
                return new List<SearchUserResponse>();


            // collection to start from
            var collection = _context.Users as IQueryable<ApplicationUser>;

            if (!string.IsNullOrWhiteSpace(query))
            {
                query = query.Trim();
                collection = collection.Where(a => a.FirstName.StartsWith(query) || a.LastName.StartsWith(query));
            }

            var totalItemCount = await collection.CountAsync();

            var collectionToReturn = await collection.OrderBy(c => c.FirstName)
                .Take(10)
                .ToListAsync();

            var model = collectionToReturn.Select(x => new SearchUserResponse
            {
                Id = x.Id,
                FirstName = x.FirstName,
                LastName = x.LastName,
                ImageUrl = host + x.ProfilePhotoUrl
            }).ToList();

            if (model == null)
            {
                return new List<SearchUserResponse>();
            }

            return model;
        }

        // Helper methods
        private async Task<TokenResponse> Login(string email, string password)
        {
            var host = _userContextService.GetHostUrl();

            var user = await _userManager.FindByEmailAsync(email);
            if (user == null)
            {
                return null;
            }

            var result = await _signInManager.CheckPasswordSignInAsync(user, password, true);
            if (!result.Succeeded)
            {
                return null;
            }

            var token = new TokenResponse
            {
                Token = JwtTokenGeneratorMachine(user),
                UserId = user.Id,
                Username = user.FirstName,
                ProfileUrl = host + user.ProfilePhotoUrl
            };

            return token;
        }

        private string JwtTokenGeneratorMachine(ApplicationUser user)
        {
            var claims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new Claim(ClaimTypes.Name, user.UserName),
                new Claim("aud","api"),
            };
            var securityKey =
                new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config.GetSection("AppSettings:Key").Value));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha512Signature);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(claims),
                Expires = DateTime.Now.AddDays(10),
                SigningCredentials = credentials,
                Issuer = "https://localhost:5000",
                Audience = "api"
            };

            var tokenHandler = new JwtSecurityTokenHandler();
            var token = tokenHandler.CreateToken(tokenDescriptor);

            return tokenHandler.WriteToken(token);
        }
    }
}
