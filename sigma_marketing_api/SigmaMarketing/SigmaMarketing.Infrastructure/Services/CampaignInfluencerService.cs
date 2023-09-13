using Microsoft.EntityFrameworkCore;
using SigmaMarketing.Core.Data;
using SigmaMarketing.Core.Data.MockData;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Exceptions;
using SigmaMarketing.Core.Helper;
using SigmaMarketing.Core.Helper.enums;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Models.PagedList;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Infrastructure.Services
{
    public class CampaignInfluencerService : ICampaignInfluencerService
    {
        private readonly ApplicationDbContext _context;
        private readonly INotificationHubService _notificationHubService;
        private readonly IUserContextService _userContextService;

        public CampaignInfluencerService(ApplicationDbContext context, INotificationHubService notificationHubService, IUserContextService userContextService)
        {
            _context = context;
            _notificationHubService = notificationHubService;
            _userContextService = userContextService;
        }

        public async Task<PagedList<CampaignVM>> GetAllAsync(string query, int page, int pageSize)
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
                campaignsQuery = campaignsQuery.OrderByDescending(c => c.Created);

                var campaignResponsesQuery = campaignsQuery.Select(c => new CampaignVM
                {
                    Id = c.Id,
                    Title = c.Name,
                    ImageUrl = host + SigmaConstants.DefaultCampaignImage,
                    Company = c.Company.FirstName,
                    Likes = 0,
                    Liked = false
                });

                var campaigns = await PagedList<CampaignVM>.CreateAsync(campaignResponsesQuery, page, pageSize);

                foreach (var campaign in campaigns.Items)
                {
                    var liked = _context.LikedCampaigns.FirstOrDefault(lc => lc.CampaignId == campaign.Id && lc.InfluencerId == userId);
                    if (liked != null)
                    {
                        campaign.Liked = true;
                    }

                    var image = _context.Photos.FirstOrDefault(p => p.CampaignId == campaign.Id);
                    if (image != null)
                    {
                        campaign.ImageUrl = host + image.ImageUrl;
                    }

                    var likes = _context.LikedCampaigns.Where(c => c.CampaignId == campaign.Id).Select(s => s).ToList();
                    campaign.Likes = likes.Count;
                }

                return campaigns;
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        public async Task<DetailsIVM> GetByIdAsync(int id)
        {
            var campaign = await _context.Campaigns.Include(com => com.Company).FirstOrDefaultAsync(c => c.Id == id);
            if (campaign == null)
            {
                throw new BadRequestException("Campaign not found");
            }

            return await getDetailsAsync(campaign, id);
        }


        public async Task<DetailsIVM> UpdateAsync(CampaignStateRequest campaignState)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();

                // ############################################################
                // Handle if user is liked/unliked the campaign
                // ############################################################
                var isLiked = _context.LikedCampaigns.FirstOrDefault(lc => lc.CampaignId == campaignState.CampaignId && lc.InfluencerId == userId);

                if (campaignState.Liked)
                {
                    if (isLiked == null)
                    {
                        var likedCampaign = new LikedCampaign
                        {
                            Created = DateTime.Now,
                            CreatedBy = userId.ToString(),
                            LastModified = DateTime.Now,
                            LastModifiedBy = userId.ToString(),
                            CampaignId = campaignState.CampaignId,
                            InfluencerId = userId
                        };
                        _context.LikedCampaigns.Add(likedCampaign);
                        _context.SaveChanges();
                    }
                }
                else
                {
                    if (isLiked != null)
                    {
                        _context.LikedCampaigns.Remove(isLiked);
                        _context.SaveChanges();
                    }
                }

                // ############################################################
                // Handle if user is requesting to join the campaign
                // ############################################################
                if (campaignState.CampaignUserStatus == CampaignUserStatus.Requested.Value && campaignState.IsUpdateStatus)
                {

                    // Handle if user changed the status of the campaign
                    var userObject = _context.Users.FirstOrDefault(u => u.Id == userId);

                    // update status if campaign is there or create Campaign User
                    var campaignUser = _context.CampaignUsers.FirstOrDefault(c => c.CampaignId == campaignState.CampaignId && c.InfluencerId == userId);
                    if (campaignUser == null)
                    {
                        // create new campaign user
                        var newCampaignUser = new CampaignUser
                        {
                            Created = DateTime.Now,
                            CreatedBy = userId.ToString(),
                            LastModified = DateTime.Now,
                            LastModifiedBy = userId.ToString(),
                            CampaignId = campaignState.CampaignId,
                            InfluencerId = userId,
                            Status = CampaignUserStatus.Requested.Value,
                            ReviewMark = 0,
                            ReviewMessage = "",
                        };
                        _context.CampaignUsers.Add(newCampaignUser);
                        _context.SaveChanges();
                    }
                    else
                    {
                        campaignUser.Status = CampaignUserStatus.Requested.Value;
                        _context.SaveChanges();
                    }

                    var campaign = await _context.Campaigns.Include(com => com.Company).FirstOrDefaultAsync(c => c.Id == campaignState.CampaignId);
                    if (campaign == null)
                    {
                        throw new BadRequestException("Campaign not found");
                    }

                    //create notification
                    var notification = new Notification
                    {
                        Created = DateTime.Now,
                        CreatedBy = userId.ToString(),
                        LastModified = DateTime.Now,
                        LastModifiedBy = userId.ToString(),
                        Title = "Campaign Request",
                        Message = userObject.FirstName + " " + userObject.LastName + " has requested to join your campaign " + campaign.Name,
                        IsOpen = false,
                        UserId = campaign.CompanyId,
                        Type = (int)NotificationType.Campaign,
                    };

                    _context.Notifications.Add(notification);
                    _context.SaveChanges();

                    await _notificationHubService.SendNotification(notification, userId);
                    await _notificationHubService.SendNumberOfUnreadNotifications(notification, userId);
                }

                // ############################################################
                // Handle if user is removing the request to join the campaign
                // ############################################################
                if (campaignState.CampaignUserStatus == CampaignUserStatus.Initial.Value && campaignState.IsUpdateStatus)
                {
                    // update status if campaign is there or create Campaign User
                    var campaignUser = _context.CampaignUsers.FirstOrDefault(c => c.CampaignId == campaignState.CampaignId && c.InfluencerId == userId);
                    if (campaignUser == null)
                    {
                        throw new BadRequestException("You have not requested this campaign first!");
                    }
                    else
                    {
                        campaignUser.Status = CampaignUserStatus.Initial.Value;
                        _context.SaveChanges();
                    }
                }

                // Return the updated campaign
                var campaignUpdated = _context.Campaigns.Include(com => com.Company).FirstOrDefault(cam => cam.Id == campaignState.CampaignId);
                if (campaignUpdated != null)
                {
                    return await getDetailsAsync(campaignUpdated, campaignState.CampaignId);
                }

                throw new BadRequestException("Campaign not found");
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        public async Task<MyCampaignsResponse> GetMyCampaignsAsync()
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var host = _userContextService.GetHostUrl();
                var defaultImage = host + SigmaConstants.DefaultCampaignImage;

                MyCampaignsResponse myCampaignsVM = new MyCampaignsResponse
                {
                    Finished = new List<MyCampaignItem>(),
                    InProgress = new List<MyCampaignItem>(),
                    Requested = new List<MyCampaignItem>()
                };

                var myCampaigns = await _context.CampaignUsers
                    .Include(cc => cc.Campaign)
                    .Where(c => c.InfluencerId == userId)
                    .Select(s => s)
                    .ToListAsync();

                if (myCampaigns == null)
                {
                    return myCampaignsVM;
                }

                foreach (var campaign in myCampaigns)
                {
                    var campaignItem = new MyCampaignItem
                    {
                        CampaignId = campaign.Campaign.Id,
                        Image = defaultImage,
                        Name = campaign.Campaign.Name,
                        Location = "Sarajevo",
                        Stars = 0,
                        Days = campaign.Campaign.EndDate.Subtract(campaign.Campaign.StartDate).Days,
                        DaysPassed = DateTime.Today.Subtract(campaign.Campaign.StartDate).Days,
                        Status = CampaignUserStatus.ToBaseStatus(campaign.Status).Name
                    };

                    var image = await _context.Photos.FirstOrDefaultAsync(p => p.CampaignId == campaign.Id);
                    if (image != null)
                    {
                        campaignItem.Image = host + image.ImageUrl;
                    }

                    if (campaign.Status == CampaignUserStatus.Completed.Value
                        || campaign.Status == CampaignUserStatus.PayedOut.Value)
                    {
                        myCampaignsVM.Finished.Add(campaignItem);
                    }
                    else if (campaign.Status == CampaignUserStatus.InProgress.Value
                        || campaign.Status == CampaignUserStatus.Accepted.Value)
                    {
                        myCampaignsVM.InProgress.Add(campaignItem);
                    }
                    else if (campaign.Status == CampaignUserStatus.Requested.Value
                        || campaign.Status == CampaignUserStatus.Invited.Value
                        || campaign.Status == CampaignUserStatus.Denied.Value)
                    {
                        myCampaignsVM.Requested.Add(campaignItem);
                    }
                }

                return myCampaignsVM;
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        public async Task<CampaignVM> ToggleLikeCampaignAsync(int campaignId, bool liked)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var isLiked = !liked
                    ? await _context.LikedCampaigns.FirstOrDefaultAsync(lc => lc.CampaignId == campaignId && lc.InfluencerId == userId)
                    : null;

                if (liked)
                {
                    if (isLiked != null)
                    {
                        return await GetCampaignByIdAsync(campaignId, userId);
                    }

                    var likedCampaign = new LikedCampaign
                    {
                        Created = DateTime.Now,
                        CreatedBy = userId.ToString(),
                        LastModified = DateTime.Now,
                        LastModifiedBy = userId.ToString(),
                        CampaignId = campaignId,
                        InfluencerId = userId
                    };
                    _context.LikedCampaigns.Add(likedCampaign);
                }
                else if (isLiked != null)
                {
                    _context.LikedCampaigns.Remove(isLiked);
                }

                await _context.SaveChangesAsync();
                return await GetCampaignByIdAsync(campaignId, userId);
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        // Methods common
        private async Task<CampaignVM> GetCampaignByIdAsync(int campaignId, int userId)
        {
            var campaign = await _context.Campaigns.Include(com => com.Company).FirstOrDefaultAsync(cam => cam.Id == campaignId);
            if (campaign == null)
            {
                throw new BadRequestException("Campaign not found!");
            }

            return await getSingleCampaignAsync(campaign, userId);
        }

        private async Task<CampaignVM> getSingleCampaignAsync(Campaign campaign, int userId)
        {
            try
            {
                var host = _userContextService.GetHostUrl();
                var defaultImage = host + SigmaConstants.DefaultCampaignImage;

                var c = new CampaignVM
                {
                    Id = campaign.Id,
                    Title = campaign.Name,
                    ImageUrl = defaultImage,
                    Company = campaign.Company.FirstName,
                    Likes = 0,
                    Liked = false
                };

                var liked = await _context.LikedCampaigns.FirstOrDefaultAsync(lc => lc.CampaignId == campaign.Id && lc.InfluencerId == userId);
                if (liked != null)
                {
                    c.Liked = true;
                }

                var image = await _context.Photos.FirstOrDefaultAsync(p => p.CampaignId == campaign.Id);
                if (image != null)
                {
                    c.ImageUrl = host + image.ImageUrl;
                }

                var likes = await _context.LikedCampaigns.Where(c => c.CampaignId == campaign.Id).Select(s => s).ToListAsync();
                if (likes != null)
                {
                    c.Likes = likes.Count();
                }

                return c;
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        private async Task<DetailsIVM> getDetailsAsync(Campaign campaign, int id)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var host = _userContextService.GetHostUrl();
                var defaultImage = host + SigmaConstants.DefaultCampaignImage;

                var photosListWithDefaultPhoto = new List<string>
            {
                defaultImage
            };

                var campaignToReturn = new DetailsIVM
                {
                    Id = campaign.Id,
                    Title = campaign.Name,
                    Details = campaign.Details,
                    Start = campaign.StartDate,
                    End = campaign.EndDate,
                    MaxPositions = campaign.OpenPositions,
                    CampaignStatus = campaign.Status,
                    Company = campaign.Company.FirstName + " " + campaign.Company.LastName,
                    Tags = new List<string>(),
                    AchievementPoints = new List<AchievementResponse>(),
                    VideoUrl = SigmaConstants.DefaultVideoUrl,
                    Likes = 0,
                    Liked = false,
                    Influencers = 0,
                    CampaignUserStatus = CampaignUserStatus.Initial.Value,
                    CompanyBio = campaign.Company.Bio,
                    CampaignLocation = "Sarajevo, BiH",
                };

                // Load company profile photo
                var companyProfilePhoto = campaign.Company.ProfilePhotoUrl;
                if (companyProfilePhoto != null)
                {
                    campaignToReturn.CompanyImageUrl = host + companyProfilePhoto;
                }

                // Load tags
                var tags = await _context.CampaignTags.Include(t => t.Tag).Where(c => c.CampaignId == campaign.Id).Select(s => s.Tag.TagName).ToListAsync();

                if (tags != null)
                {
                    campaignToReturn.Tags = tags;
                }

                // Load achievements points
                var achievements = await _context.AchievementPoints.Include(at => at.AchievementType).Where(c => c.CampaignId == campaign.Id).Select(s => new AchievementResponse
                {
                    Id = s.Id,
                    Description = s.Description,
                    Name = s.Title,
                    Type = new AchievementTypeResponse
                    {
                        Id = s.AchievementType.Id,
                        Name = s.AchievementType.Name,
                        Explanation = s.AchievementType.Explanation,
                        ImageUrl = host + s.AchievementType.ImageUrl,
                        Type = s.AchievementType.Type,
                        Value = s.AchievementType.Value,
                        ValueCash = s.AchievementType.Value * 0.9,
                    },
                    Status = AchievementStatus.ToBaseStatus(AchievementStatus.Initial.Value)
                }).ToListAsync();

                if (achievements != null)
                {
                    campaignToReturn.AchievementPoints = achievements;
                }

                // Load photos
                var campaignPhotos = await _context.Photos.Where(c => c.CampaignId == campaign.Id).Select(p => p).ToListAsync();
                if (campaignPhotos != null && campaignPhotos.Count() > 0)
                {
                    var campaignPhotosUpdated = new List<string>();
                    foreach (var photo in campaignPhotos)
                    {
                        campaignPhotosUpdated.Add(host + photo.ImageUrl);
                    }
                    campaignToReturn.Photos = campaignPhotosUpdated;
                }
                else
                {
                    campaignToReturn.Photos = photosListWithDefaultPhoto;
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
                var influencers = await _context.CampaignUsers.Where(c => c.CampaignId == campaign.Id).Select(s => s).ToListAsync();
                if (influencers != null)
                {
                    campaignToReturn.Influencers = influencers.Count();
                }

                // Load does user liked this campaign
                var liked = await _context.LikedCampaigns.FirstOrDefaultAsync(lc => lc.CampaignId == campaign.Id && lc.InfluencerId == userId);
                if (liked != null)
                {
                    campaignToReturn.Liked = true;
                }

                // Load campaign user status
                var campaignUserStatus = await _context.CampaignUsers.FirstOrDefaultAsync(cu => cu.CampaignId == id && cu.InfluencerId == userId);
                if (campaignUserStatus != null)
                {
                    campaignToReturn.CampaignUserStatus = campaignUserStatus.Status;
                }

                // Check if campaign user status is accepted or in progress or completed  or payed out
                if(campaignToReturn.CampaignUserStatus == CampaignUserStatus.Accepted.Value
                   || campaignToReturn.CampaignUserStatus == CampaignUserStatus.InProgress.Value
                   || campaignToReturn.CampaignUserStatus == CampaignUserStatus.Completed.Value
                   || campaignToReturn.CampaignUserStatus == CampaignUserStatus.PayedOut.Value)
                {
                    // Load achievements points attached to user
                    var achievementsAttached = await _context.UserCampaignAchievementPoints
                        .Include(a => a.AchievementPoint)
                        .ThenInclude(at => at.AchievementType)
                        .Where(c => c.CampaignId == campaign.Id && c.UserId == userId)
                        .Select(s => new AchievementResponse
                    {
                        Id = s.Id,
                        Description = s.AchievementPoint.Description,
                        Name = s.AchievementPoint.Title,
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
                        Status = AchievementStatus.ToBaseStatus(AchievementStatus.Initial.Value)
                    }).ToListAsync();

                    if (achievementsAttached != null)
                    {
                        campaignToReturn.AchievementPoints = achievementsAttached;
                    }
                }

                return campaignToReturn;
            }
            catch (Exception ex)
            {
                throw new BadRequestException("Error while getting campaign details!");
            }
        }
    }
}
