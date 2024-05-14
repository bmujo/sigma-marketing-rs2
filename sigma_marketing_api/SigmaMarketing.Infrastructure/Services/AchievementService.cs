using Microsoft.EntityFrameworkCore;
using SigmaMarketing.Core.Data;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Exceptions;
using SigmaMarketing.Core.Helper.enums;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Infrastructure.Services
{
    public class AchievementService : IAchievementService
    {
        private readonly ApplicationDbContext _context;
        private readonly INotificationService _notificationService;
        private readonly IUserContextService _userContextService;

        public AchievementService(ApplicationDbContext context, IUserContextService userContextService, INotificationService notificationService)
        {
            _context = context;
            _userContextService = userContextService;
            _notificationService = notificationService;
        }

        public async Task<AchievementResponse> SubmitReviewAsync(AchievementSubmit achievementSubmit)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var user = _context.Users.FirstOrDefault(u => u.Id == userId);
                if (user == null)
                {
                    throw new BadRequestException("User not found");
                }

                var type = "COMMENT";
                var status = AchievementStatus.Revision.Value;

                var userCampaignAchievementPoint = _context.UserCampaignAchievementPoints.FirstOrDefault(u => u.Id == achievementSubmit.Id);
                if (userCampaignAchievementPoint == null)
                {
                    throw new BadRequestException("User campaign achievement point not found");
                }

                CreateAchievementTrackNote(userCampaignAchievementPoint, type, status, achievementSubmit.Comment);

                // Create and send notification
                var campaingName = _context.Campaigns.FirstOrDefault(c => c.Id == userCampaignAchievementPoint.CampaignId)?.Name ?? "";
                var achivementName = _context.AchievementPoints.FirstOrDefault(a => a.Id == userCampaignAchievementPoint.AchievementPointId)?.Title ?? "";

                var notificationTitle = "Achievement needs review";
                var notificationMessage = $"{achivementName} in campaign {campaingName} needs review!";

                await _notificationService.SendNotificationAsync(
                    userId,
                    userCampaignAchievementPoint.UserId,
                    notificationTitle, 
                    notificationMessage, 
                    (int)NotificationType.Achievement
                    );

                return await GetById(userCampaignAchievementPoint.Id);
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        public async Task<AchievementResponse> SubmitRevisionAsync(AchievementSubmit achievementSubmit)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var user = _context.Users.FirstOrDefault(u => u.Id == userId);
                if (user == null)
                {
                    throw new BadRequestException("User not found");
                }

                var type = "PROOF";
                var status = AchievementStatus.Review.Value;

                var userCampaignAchievementPoint = _context.UserCampaignAchievementPoints
                    .Include(c => c.Campaign)
                    .ThenInclude(co => co.Company)
                    .FirstOrDefault(u => u.Id == achievementSubmit.Id);
                if (userCampaignAchievementPoint == null)
                {
                    throw new BadRequestException("User campaign achievement point not found");
                }

                CreateAchievementTrackNote(userCampaignAchievementPoint, type, status, achievementSubmit.Comment);

                // Create and send notification
                var campaingName = _context.Campaigns.FirstOrDefault(c => c.Id == userCampaignAchievementPoint.CampaignId)?.Name ?? "";
                var achivementName = _context.AchievementPoints.FirstOrDefault(a => a.Id == userCampaignAchievementPoint.AchievementPointId)?.Title ?? "";

                var notificationTitle = "Achievement done";
                var notificationMessage = $"{achivementName} in campaign {campaingName} successfully done!";

                await _notificationService.SendNotificationAsync(
                    userId,
                    userCampaignAchievementPoint.Campaign.Company.Id,
                    notificationTitle,
                    notificationMessage,
                    (int)NotificationType.Achievement
                    );

                return await GetById(userCampaignAchievementPoint.Id);
            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        public async Task<AchievementResponse> CompleteAsync(int achievementId)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var user = _context.Users.FirstOrDefault(u => u.Id == userId);
                if (user == null)
                {
                    throw new BadRequestException("User not found");
                }

                var userCampaignAchievementPoint = _context.UserCampaignAchievementPoints
                    .FirstOrDefault(u => u.Id == achievementId);
                if (userCampaignAchievementPoint == null)
                {
                    throw new BadRequestException("User campaign achievement point not found");
                }

                userCampaignAchievementPoint.Status = AchievementStatus.Done.Value;
                _context.SaveChanges();

                // Create and send notification
                var campaingName = _context.Campaigns.FirstOrDefault(c => c.Id == userCampaignAchievementPoint.CampaignId)?.Name ?? "";
                var achivementName = _context.AchievementPoints.FirstOrDefault(a => a.Id == userCampaignAchievementPoint.AchievementPointId)?.Title ?? "";

                var notificationTitle = "Achievement needs review";
                var notificationMessage = $"{achivementName} in campaign {campaingName} needs review!";

                await _notificationService.SendNotificationAsync(
                    userId,
                    userCampaignAchievementPoint.UserId,
                    notificationTitle,
                    notificationMessage,
                    (int)NotificationType.Achievement
                    );

                var isAllDone = await CheckAllAchievementsDone(userCampaignAchievementPoint.UserId, userCampaignAchievementPoint.CampaignId);
                if(isAllDone)
                {
                    var campaignUser = _context.CampaignUsers
                        .FirstOrDefault(c => c.InfluencerId == userCampaignAchievementPoint.UserId && 
                        c.CampaignId == userCampaignAchievementPoint.CampaignId
                        );

                    if(campaignUser != null)
                    {
                        campaignUser.Status = CampaignUserStatus.Completed.Value;
                        _context.SaveChanges();

                        // Create and send notification
                        var notificationTitleCampaign = "Campaign completed";
                        var notificationMessageCampaign = $"Campaign {campaingName} successfully completed!";

                        await _notificationService.SendNotificationAsync(
                    userId,
                    userCampaignAchievementPoint.UserId,
                    notificationTitleCampaign,
                    notificationMessageCampaign,
                    (int)NotificationType.Campaign
                    );
                    }
                }

                return await GetById(userCampaignAchievementPoint.Id);
            } 
            catch(Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        public async Task<bool> CheckAllAchievementsDone(int influencerId, int campaignId)
        {
            try
            {
                var userAchievements = _context.UserCampaignAchievementPoints
                    .Where(u => u.UserId == influencerId && u.CampaignId == campaignId)
                    .ToList();

                if (userAchievements == null || userAchievements.Count == 0)
                {
                    throw new BadRequestException("User campaign achievement points not found");
                }

                var allDone = true;
                foreach (var userAchievement in userAchievements)
                {
                    if (userAchievement.Status != AchievementStatus.Done.Value)
                    {
                        allDone = false;
                        break;
                    }
                }
                
                return allDone;
            }
            catch(Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }   
        }

            public async Task<AchievementResponse> GetByIdAsync(int id)
        {
            try
            {
                  return await GetById(id);
            }
            catch(Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        private async Task<AchievementResponse> GetById(int id)
        {
            var host = _userContextService.GetHostUrl();

            var userCampaignAchievementPoint = await _context.UserCampaignAchievementPoints
                    .Include(ap => ap.AchievementPoint)
                    .FirstOrDefaultAsync(u => u.Id == id);
            if (userCampaignAchievementPoint == null)
            {
                throw new BadRequestException("User campaign achievement point not found");
            }

            var achivementResponse = new AchievementResponse
            {
                Id = userCampaignAchievementPoint.Id,
                Name = userCampaignAchievementPoint.AchievementPoint.Title,
                Description = userCampaignAchievementPoint.AchievementPoint.Description,
                Status = AchievementStatus.ToBaseStatus(userCampaignAchievementPoint.Status),
                TrackNotes = new List<TrackNoteItem>()
            };

            var achievementType = _context.AchievementsTypes
                .FirstOrDefault(at => at.Id == userCampaignAchievementPoint.AchievementPoint.AchievementTypeId);

            achivementResponse.Type = new AchievementTypeResponse
            {
                Id = achievementType.Id,
                Name = achievementType.Name,
                Explanation = achievementType.Explanation,
                ImageUrl = host + achievementType.ImageUrl,
                Type = achievementType.Type,
                Value = achievementType.Value,
                ValueCash = achievementType.Value * 0.9,
            };
            
            var trackNotes = _context.AchievementTrackNotes
                .Where(a => a.UserCampaignAchievementPointId == userCampaignAchievementPoint.Id)
                .Select(atn => atn)
                .ToList();

            if (trackNotes != null && trackNotes.Count > 0)
            {
                achivementResponse.TrackNotes = trackNotes.Select(a => new TrackNoteItem
                {
                    Type = a.Type,
                    Comment = a.Comment,
                    CreatedAt = a.Created,
                }).ToList();
            }

            return achivementResponse;
        } 

        private void CreateAchievementTrackNote(UserCampaignAchievementPoint userCampaignAchievementPoint, string type, int status, string comment)
        {
            userCampaignAchievementPoint.Status = status;

            var achievementTrackNote = new AchievementTrackNote
            {
                Created = DateTime.Now,
                CreatedBy = _userContextService.GetCurrentUserId().ToString(),
                LastModified = DateTime.Now,
                LastModifiedBy = _userContextService.GetCurrentUserId().ToString(),
                UserCampaignAchievementPointId = userCampaignAchievementPoint.Id,
                Comment = comment,
                Type = type
            };

            _context.AchievementTrackNotes.Add(achievementTrackNote);
            _context.SaveChanges();
        }
    }
}
