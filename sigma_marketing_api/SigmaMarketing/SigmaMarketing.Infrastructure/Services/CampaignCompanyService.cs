using AutoMapper.Internal;
using Microsoft.EntityFrameworkCore;
using SigmaMarketing.Core.Data;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Exceptions;
using SigmaMarketing.Core.Helper;
using SigmaMarketing.Core.Helper.enums;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Models.PagedList;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Request.Validators;
using SigmaMarketing.Model.Models.Response;
using SigmaMarketing.Model.Models.Response.Base;

namespace SigmaMarketing.Infrastructure.Services
{
    public class CampaignCompanyService : ICampaignCompanyService
    {
        private readonly ApplicationDbContext _context;
        private readonly INotificationHubService _notificationHubService;
        private readonly IUserContextService _userContextService;

        public CampaignCompanyService(ApplicationDbContext context, INotificationHubService notificationHubService, IUserContextService userContextService)
        {
            _context = context;
            _notificationHubService = notificationHubService;
            _userContextService = userContextService;
        }

        public async Task<PagedList<CampaignCVM>> GetBrandCampaignsAsync(string query, int page, int pageSize)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var host = _userContextService.GetHostUrl();

                if (pageSize < 0) pageSize = 10;
                if (page < 0) page = 1;

                // collection to start from
                var campaignsQuery = _context.Campaigns.Include(company => company.Company) as IQueryable<Campaign>;

                if (!string.IsNullOrWhiteSpace(query))
                {
                    query = query.Trim();
                    campaignsQuery = campaignsQuery.Where(a => a.Name.Contains(query.ToLower())
                                                                      || a.Name != null && a.Name.Contains(query.ToLower()));
                }

                // Order by creation date
                campaignsQuery = campaignsQuery
                    .OrderBy(c =>
                        c.Status == CampaignStatus.Open.Value ? 0 :
                        c.Status == CampaignStatus.InProgress.Value ? 1 :
                        c.Status == CampaignStatus.NotActive.Value ? 2 :
                        c.Status == CampaignStatus.Completed.Value ? 3 :
                        4)
                    .ThenByDescending(c => c.Created);

                var campaignResponsesQuery = campaignsQuery.Select(c => new CampaignCVM
                {
                    Id = c.Id,
                    Title = c.Name,
                    Likes = 0,
                    Influencers = 0,
                    Image = host + SigmaConstants.DefaultCampaignImage,
                    Status = CampaignStatus.ToBaseStatus(c.Status),
                });

                var campaigns = await PagedList<CampaignCVM>.CreateAsync(campaignResponsesQuery, page, pageSize);

                foreach (var campaign in campaigns.Items)
                {
                    campaign.Likes = await GetNumberOfLikesAsync(campaign.Id);
                    campaign.Influencers = await GetNumberOfInfluencersAsync(campaign.Id);
                }

                return campaigns;
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        

        private async Task<int> GetNumberOfLikesAsync(int campaignId)
        {
            var numberOfLikes = 0;
            var likes = await _context.LikedCampaigns.Where(lc => lc.CampaignId == campaignId).ToListAsync();
            if (likes != null)
            {
                numberOfLikes = likes.Count;
            }
            return numberOfLikes;
        }

        private async Task<int> GetNumberOfInfluencersAsync(int campaignId)
        {
            var numberOfInfluencers = 0;
            var influencers = await _context.CampaignUsers.Where(cu => cu.CampaignId == campaignId).ToListAsync();
            if (influencers != null)
            {
                numberOfInfluencers = influencers.Count;
            }
            return numberOfInfluencers;
        }

        public async Task<string> CreateCampaignAsync(NewCampaignRequest newCampaign)
        {
            var userId = _userContextService.GetCurrentUserId();

            var validator = new NewCampaignValidator();
            var result = validator.Validate(newCampaign);
            if (!result.IsValid)
            {
                throw new BadRequestException(result.Errors.ToString());
            }

            var campaignStatus = CampaignStatus.Open.Value;


            // Create campaign 
            var campaign = new Campaign
            {
                Created = DateTime.Now,
                CreatedBy = userId.ToString(),
                LastModified = DateTime.Now,
                LastModifiedBy = userId.ToString(),
                Name = newCampaign.Name,
                StartDate = newCampaign.StartDate,
                EndDate = newCampaign.EndDate,
                DeadlineForApplications = newCampaign.DeadlineForApplications,
                Details = newCampaign.Details,
                Budget = newCampaign.Budget,
                OpenPositions = newCampaign.OpenPositions,
                Status = CampaignStatus.Open.Value,
                IsActive = newCampaign.IsActive,
                VideoUrl = newCampaign.VideoUrl,
                AssetsUrl = newCampaign.AssetsUrl,
                RequirementsAndContentGuidelines = newCampaign.RequirementsAndContentGuidelines,
                PaymentTermId = newCampaign.PaymentTermId,
                CompanyId = userId
            };

            _context.Campaigns.Add(campaign);
            await _context.SaveChangesAsync();

            // Add achivement points to campaing
            foreach (NewAchievement achievement in newCampaign.Achievements)
            {
                var achievementPoint = new AchievementPoint
                {
                    Created = DateTime.Now,
                    CreatedBy = userId.ToString(),
                    LastModified = DateTime.Now,
                    LastModifiedBy = userId.ToString(),
                    Title = achievement.Title,
                    Description = achievement.Title,
                    AchievementTypeId = achievement.AchievementTypeId,
                    CampaignId = campaign.Id
                };

                _context.AchievementPoints.Add(achievementPoint);
            }
            await _context.SaveChangesAsync();

            // Add tags to campaign
            foreach (int tagId in newCampaign.Tags)
            {
                var campaignTag = new CampaignTag
                {
                    Created = DateTime.Now,
                    CreatedBy = userId.ToString(),
                    LastModified = DateTime.Now,
                    LastModifiedBy = userId.ToString(),
                    TagId = tagId,
                    CampaignId = campaign.Id
                };

                _context.CampaignTags.Add(campaignTag);
            }
            await _context.SaveChangesAsync();

            // Add photos to campaign
            foreach (string photo in newCampaign.Photos)
            {
                string extension = ".png";
                var filename = $"{Guid.NewGuid()}{extension}";

                //Generate unique filename
                string filepath = "wwwroot/images/campaign/" + filename;
                string filepathToSave = "/images/campaign/" + filename;
                var bytess = Convert.FromBase64String(photo);
                using (var imageFile = new FileStream(filepath, FileMode.Create))
                {
                    imageFile.Write(bytess, 0, bytess.Length);
                    imageFile.Flush();
                }

                var campaignImage = new Photo
                {
                    Created = DateTime.Now,
                    CreatedBy = userId.ToString(),
                    LastModified = DateTime.Now,
                    LastModifiedBy = userId.ToString(),
                    Name = filename,
                    ImageUrl = filepathToSave,
                    Position = 0,
                    CampaignId = campaign.Id
                };

                _context.Photos.Add(campaignImage);
                await _context.SaveChangesAsync();
            }

            // Add platforms to campaign
            foreach (int platformId in newCampaign.Platforms)
            {
                var campaignPlatform = new CampaignPlatform
                {
                    Created = DateTime.Now,
                    CreatedBy = userId.ToString(),
                    LastModified = DateTime.Now,
                    LastModifiedBy = userId.ToString(),
                    PlatformId = platformId,
                    CampaignId = campaign.Id
                };

                _context.CampaignPlatforms.Add(campaignPlatform);
            }

            // Add video to campaign
            var videoToAdd = new Video
            {
                Created = DateTime.Now,
                CreatedBy = userId.ToString(),
                LastModified = DateTime.Now,
                LastModifiedBy = userId.ToString(),
                Name = "Video" + campaign.Id,
                VideoUrl = newCampaign.VideoUrl,
                CampaignId = campaign.Id
            };

            _context.Videos.Add(videoToAdd);
            await _context.SaveChangesAsync();

            // Add and invite influencers to campaign
            foreach (int influencerId in newCampaign.InvitedInfluencers)
            {
                var campaignUser = new CampaignUser
                {
                    Created = DateTime.Now,
                    CreatedBy = userId.ToString(),
                    LastModified = DateTime.Now,
                    LastModifiedBy = userId.ToString(),
                    InfluencerId = influencerId,
                    CampaignId = campaign.Id,
                    Status = CampaignUserStatus.Initial.Value
                };

                _context.CampaignUsers.Add(campaignUser);
            }

            return "";
        }

        public async Task<CampaignCreateDataResponse> GetCampaignCreateDataAsync()
        {
            return await GetCampaignDataForCreationAsync();
        }

        private async Task<CampaignCreateDataResponse> GetCampaignDataForCreationAsync()
        {
            var host = _userContextService.GetHostUrl();
            var tagsDatabase = await _context.Tags.ToListAsync();
            var platformsDatabase = await _context.Platforms.ToListAsync();
            var paymentTermsDatabase = await _context.PaymentTerms.ToListAsync();
            var achievementTypesDatabase = await _context.AchievementsTypes.ToListAsync();

            var tags = new List<TagData>();
            var platforms = new List<PlatformData>();
            var paymentTerms = new List<PaymentTermsData>();
            var achievementTypes = new List<AchievementTypeResponse>();

            if (tagsDatabase != null)
            {
                foreach (var tag in tagsDatabase)
                {
                    tags.Add(new TagData { Id = tag.Id, Name = tag.TagName });
                }
            }

            if (platformsDatabase != null)
            {
                foreach (var platform in platformsDatabase)
                {
                    platforms.Add(new PlatformData { Id = platform.Id, Name = platform.Name });
                }
            }

            if (paymentTermsDatabase != null)
            {
                foreach (var paymentTerm in paymentTermsDatabase)
                {
                    paymentTerms.Add(new PaymentTermsData { Id = paymentTerm.Id, Name = paymentTerm.Name });
                }
            }

            if (achievementTypesDatabase != null)
            {
                foreach (var achievementType in achievementTypesDatabase)
                {
                    achievementTypes.Add(new AchievementTypeResponse
                    {
                        Id = achievementType.Id,
                        Name = achievementType.Name,
                        Explanation = achievementType.Explanation,
                        ImageUrl = host + achievementType.ImageUrl,
                        Type = achievementType.Type,
                        Value = achievementType.Value,
                        ValueCash = achievementType.Value * 0.9
                    });
                }
            }

            var campaignCreateData = new CampaignCreateDataResponse
            {
                Tags = tags,
                Platforms = platforms,
                PaymentTerms = paymentTerms,
                AchievementTypes = achievementTypes
            };

            return campaignCreateData;
        }

        public async Task<DetailsCVM> GetCampaignByIdCompanyAsync(int id)
        {
            return await GetById(id);
        }

        public async Task<bool> InviteUsersAsync(InviteRequest invite)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();

                var campaign = await _context.Campaigns.FirstOrDefaultAsync(c => c.Id == invite.CampaignId);

                if (campaign == null)
                {
                    throw new BadRequestException("Campaign not found!");
                }

                foreach (var influencerId in invite.Users)
                {
                    var campaignUser = await _context.CampaignUsers
                        .FirstOrDefaultAsync(c => c.CampaignId == invite.CampaignId &&
                        c.InfluencerId == influencerId);
                    if (campaignUser != null)
                    {
                        continue;
                    }

                    var newCampaignUser = new CampaignUser
                    {
                        CampaignId = invite.CampaignId,
                        InfluencerId = influencerId,
                        Status = CampaignUserStatus.Invited.Value,
                        Created = DateTime.Now,
                        CreatedBy = userId.ToString(),
                        LastModified = DateTime.Now,
                        LastModifiedBy = userId.ToString(),
                        ReviewMark = 0,
                        ReviewMessage = "",
                    };

                    _context.CampaignUsers.Add(newCampaignUser);
                    _context.SaveChanges();

                    //create notification
                    var notification = new Notification
                    {
                        Created = DateTime.Now,
                        CreatedBy = userId.ToString(),
                        LastModified = DateTime.Now,
                        LastModifiedBy = userId.ToString(),
                        Title = "Campaign invitation",
                        Message = "You have been invited to campaign " + campaign.Name,
                        IsOpen = false,
                        UserId = influencerId,
                        Type = (int)NotificationType.Campaign,
                    };

                    _context.Notifications.Add(notification);
                    _context.SaveChanges();

                    await _notificationHubService.SendNotification(notification, userId);
                    await _notificationHubService.SendNumberOfUnreadNotifications(notification, userId);
                }

                return true;
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        public async Task<DetailsCVM> AcceptUserAsync(int campaignId, int influencerId)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var campaignUser = await _context.CampaignUsers
                    .FirstOrDefaultAsync(c => c.CampaignId == campaignId &&
                    c.InfluencerId == influencerId) ?? throw new BadRequestException("Campaign user not found!");


                // Update campaign user status
                campaignUser.Status = CampaignUserStatus.Accepted.Value;
                campaignUser.LastModified = DateTime.Now;
                campaignUser.LastModifiedBy = userId.ToString();

                _context.CampaignUsers.Update(campaignUser);
                await _context.SaveChangesAsync();

                var campaign = await _context.Campaigns.FirstOrDefaultAsync(c => c.Id == campaignId) ?? throw new BadRequestException("Campaign not found!");

                // Create achievement points for accepted influencer
                var achievements = await _context.AchievementPoints.Where(a => a.CampaignId == campaignId).ToListAsync();
                achievements?.ForEach(achievement =>
                    {
                        var campaignUserAchievement = new UserCampaignAchievementPoint
                        {
                            CampaignId = campaignId,
                            UserId = influencerId,
                            AchievementPointId = achievement.Id,
                            Status = AchievementStatus.Initial.Value,
                            Created = DateTime.Now,
                            CreatedBy = userId.ToString(),
                            LastModified = DateTime.Now,
                            LastModifiedBy = userId.ToString(),

                        };

                        _context.UserCampaignAchievementPoints.Add(campaignUserAchievement);
                        _context.SaveChanges();
                    });

                //create notification
                var notification = new Notification
                {
                    Created = DateTime.Now,
                    CreatedBy = userId.ToString(),
                    LastModified = DateTime.Now,
                    LastModifiedBy = userId.ToString(),
                    Title = "Campaign invitation",
                    Message = "You have been accepted to campaign " + campaign.Name,
                    IsOpen = false,
                    UserId = influencerId,
                    Type = (int)NotificationType.Campaign,
                };

                _context.Notifications.Add(notification);
                _context.SaveChanges();

                await _notificationHubService.SendNotification(notification, userId);
                await _notificationHubService.SendNumberOfUnreadNotifications(notification, userId);

                return await GetById(campaignId);
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        public async Task<DetailsCVM> DeclineUserAsync(int campaignId, int influencerId)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var campaignUser = await _context.CampaignUsers
                    .FirstOrDefaultAsync(c => c.CampaignId == campaignId &&
                    c.InfluencerId == influencerId) ?? throw new BadRequestException("Campaign user not found!");


                // Update campaign user status
                campaignUser.Status = CampaignUserStatus.Denied.Value;
                campaignUser.LastModified = DateTime.Now;
                campaignUser.LastModifiedBy = userId.ToString();

                _context.CampaignUsers.Update(campaignUser);
                await _context.SaveChangesAsync();

                var campaign = await _context.Campaigns.FirstOrDefaultAsync(c => c.Id == campaignId) ?? throw new BadRequestException("Campaign not found!");

                //create notification
                var notification = new Notification
                {
                    Created = DateTime.Now,
                    CreatedBy = userId.ToString(),
                    LastModified = DateTime.Now,
                    LastModifiedBy = userId.ToString(),
                    Title = "Campaign Declined",
                    Message = "Your request have been declined for " + campaign.Name,
                    IsOpen = false,
                    UserId = influencerId,
                    Type = (int)NotificationType.Campaign,
                };

                _context.Notifications.Add(notification);
                _context.SaveChanges();

                await _notificationHubService.SendNotification(notification, userId);
                await _notificationHubService.SendNumberOfUnreadNotifications(notification, userId);

                return await GetById(campaignId);
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        public async Task<DetailsCVM> GetById(int campaignId)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var host = _userContextService.GetHostUrl();
                var defaultImage = host + SigmaConstants.DefaultCampaignImage;

                var campaign = await _context.Campaigns.Include(com => com.Company).FirstOrDefaultAsync(c => c.Id == campaignId);
                if (campaign == null)
                {
                    throw new BadRequestException("Campaign not found!");
                }

                var campaignToReturn = new DetailsCVM
                {
                    Id = campaign.Id,
                    Title = campaign.Name,
                    Details = campaign.Details,
                    Budget = campaign.Budget,
                    Start = campaign.StartDate,
                    End = campaign.EndDate,
                    DeadlineForApplications = campaign.DeadlineForApplications,
                    MaxPositions = campaign.OpenPositions,
                    isActive = campaign.IsActive,
                    Tags = new List<TagData>(),
                    AchievementPoints = new List<AchievementResponse>(),
                    Platforms = new List<PlatformData>(),
                    ImageUrl = defaultImage,
                    VideoUrl = "https://www.youtube.com/watch?v=aqz-KE-bpKQ",
                    AssetsUrl = campaign.AssetsUrl,
                    RequirementsAndContentGuidelines = campaign.RequirementsAndContentGuidelines,
                    Likes = 0,
                    Influencers = 0,
                };

                // Load status
                var status = CampaignStatus.FromValue(campaign.Status);
                var baseStatus = new BaseStatus
                {
                    Value = status.Value,
                    Name = status.Name,
                    Color = status.HexColor
                };
                campaignToReturn.CampaignStatus = baseStatus;

                // Load tags
                var tags = await _context.CampaignTags.Include(t => t.Tag).Where(c => c.CampaignId == campaign.Id).Select(s => s.Tag).ToListAsync();

                if (tags != null)
                {
                    tags.ForAll(t => campaignToReturn.Tags.Add(new TagData { Id = t.Id, Name = t.TagName }));
                }

                // Load achievements points
                var achievements = await _context.AchievementPoints.Where(c => c.CampaignId == campaign.Id).Select(s => new AchievementResponse
                {
                    Id = s.Id,
                    Name = s.Title,
                    Description = s.Description,
                    Type = _context.AchievementsTypes
                .Where(at => at.Id == s.AchievementTypeId).Select(ac => new AchievementTypeResponse
                {
                    Id = ac.Id,
                    Name = ac.Name,
                    Explanation = ac.Explanation,
                    ImageUrl = host + ac.ImageUrl,
                    Type = ac.Type,
                    Value = ac.Value,
                    ValueCash = ac.Value * 0.9,
                }).SingleOrDefault(),
                    Status = AchievementStatus.ToBaseStatus(AchievementStatus.Initial.Value),
                }).ToListAsync();

                if (achievements != null)
                {
                    campaignToReturn.AchievementPoints = achievements;
                }

                // Load photos
                var campaignPhoto = await _context.Photos.FirstOrDefaultAsync(c => c.CampaignId == campaign.Id);
                if (campaignPhoto != null)
                {
                    campaignToReturn.ImageUrl = host + campaignPhoto.ImageUrl;
                }

                // Load video url
                var campaignVideo = await _context.Videos.FirstOrDefaultAsync(c => c.CampaignId == campaign.Id);
                if (campaignVideo != null)
                {
                    campaignToReturn.VideoUrl = campaignVideo.VideoUrl;
                }

                // Load likes
                var likes = await _context.LikedCampaigns.Where(c => c.CampaignId == campaign.Id).Select(s => s).ToListAsync();
                if (likes != null)
                {
                    campaignToReturn.Likes = likes.Count();
                }

                // Load influencers
                var influencers = await _context.CampaignUsers.Include(inf => inf.Influencer).Where(c => c.CampaignId == campaign.Id).Select(s => s).ToListAsync();
                if (influencers != null)
                {
                    campaignToReturn.Influencers = influencers.Count();
                }

                var campaignInfluencers = new List<InfluencerResponse>();
                foreach (var item in influencers)
                {
                    var user = new InfluencerResponse
                    {
                        Id = item.Influencer.Id,
                        FirstName = item.Influencer.FirstName,
                        LastName = item.Influencer.LastName,
                        ImageUrl = host + item.Influencer.ProfilePhotoUrl,
                        Status = CampaignUserStatus.ToBaseStatus(item.Status),
                    };

                    var userSpecificAchievements = await _context.UserCampaignAchievementPoints
                        .Include(x => x.AchievementPoint)
                        .ThenInclude(x => x.AchievementType)
                        .Where(c => c.UserId == item.InfluencerId && c.CampaignId == campaignId)
                        .Select(s => s)
                        .ToListAsync();

                    if (userSpecificAchievements != null)
                    {
                        user.Achievements = userSpecificAchievements.Select(s => new AchievementResponse
                        {
                            Id = s.Id,
                            Name = s.AchievementPoint.Title,
                            Description = s.AchievementPoint.Description,
                            Type = new AchievementTypeResponse
                            {
                                Id = s.AchievementPoint.AchievementType.Id,
                                Name = s.AchievementPoint.AchievementType.Name,
                                Explanation = s.AchievementPoint.AchievementType.Explanation,
                                ImageUrl = host + s.AchievementPoint.AchievementType.ImageUrl,
                                Type = s.AchievementPoint.AchievementType.Type,
                                Value = s.AchievementPoint.AchievementType.Value,
                                ValueCash = s.AchievementPoint.AchievementType.Value * 0.9,
                            },
                            Status = AchievementStatus.ToBaseStatus(s.Status),
                        }).ToList();
                    }

                    user.CurrentEarningSigma = 0;
                    user.CurrentEarningCash = 0.0;

                    if (user.Achievements.Count > 0)
                    {
                        foreach (var achievement in user.Achievements)
                        {
                            if (achievement.Status.Value == AchievementStatus.Done.Value)
                            {
                                user.CurrentEarningSigma += achievement.Type.Value;
                                user.CurrentEarningCash += (achievement.Type.Value * 0.9);
                            }
                        }
                    }

                    campaignInfluencers.Add(user);
                }
                campaignToReturn.CurrentInfluencers = campaignInfluencers;

                // Load platforms
                var platforms = await _context.CampaignPlatforms.Include(p => p.Platform).Where(c => c.CampaignId == campaign.Id).Select(s => s.Platform).ToListAsync();
                if (platforms != null)
                {
                    platforms.ForAll(p => campaignToReturn.Platforms.Add(new PlatformData { Id = p.Id, Name = p.Name }));
                }

                // Load payment term
                var paymentTerm = await _context.PaymentTerms.Where(c => c.Id == campaign.PaymentTermId).FirstOrDefaultAsync();
                if (paymentTerm != null)
                {
                    campaignToReturn.PaymentTerms = new PaymentTermsData { Id = paymentTerm.Id, Name = paymentTerm.Name };
                }

                campaignToReturn.CampaignCreateData = await GetCampaignDataForCreationAsync();


                return campaignToReturn;
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }
    }
}
