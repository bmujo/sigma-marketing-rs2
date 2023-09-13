using Microsoft.EntityFrameworkCore;
using SigmaMarketing.Core.Data;
using SigmaMarketing.Core.Entities;
using SigmaMarketing.Core.Exceptions;
using SigmaMarketing.Core.Helper.enums;
using SigmaMarketing.Core.Interfaces;
using SigmaMarketing.Model.Models.PagedList;
using SigmaMarketing.Model.Models.Request;
using SigmaMarketing.Model.Models.Response;

namespace SigmaMarketing.Infrastructure.Services
{
    public class AnalyticsService : IAnalyticsService
    {
        private readonly ApplicationDbContext _context;
        private readonly INotificationHubService _notificationHubService;
        private readonly IUserContextService _userContextService;

        public AnalyticsService(ApplicationDbContext context, INotificationHubService notificationHubService, IUserContextService userContextService)
        {
            _context = context;
            _notificationHubService = notificationHubService;
            _userContextService = userContextService;
        }

        public async Task<AnalyticsResponse> GetCampaignsAnalyticsAsync(CampaignAnalyticsRequest request)
        {
            try
            {
                var userId = _userContextService.GetCurrentUserId();
                var host = _userContextService.GetHostUrl();

                if (request.PageSize <= 0) request.PageSize = 10;
                if (request.Page <= 0) request.Page = 1;

                // collection to start from
                var campaignsQuery = _context.Campaigns.Include(company => company.Company) as IQueryable<Campaign>;

                // order by creation date
                campaignsQuery = campaignsQuery.OrderByDescending(c => c.Created);

                // filter campaigns by start and end date
                if (request.StartDate != null && request.EndDate != null)
                {
                    campaignsQuery = campaignsQuery.Where(c => c.StartDate >= request.StartDate && c.EndDate <= request.EndDate);
                }

                // filter campaigns by list of statuses
                if (request.Statuses != null && request.Statuses.Count > 0)
                {
                    campaignsQuery = campaignsQuery.Where(c => request.Statuses.Contains(c.Status));
                }

                // filter campaigns by list of tags
                if (request.Tags != null && request.Tags.Count > 0)
                {
                    campaignsQuery = campaignsQuery.Where(c => c.CampaignTags.Any(ct => request.Tags.Contains(ct.TagId)));
                }

                // filter campaigns by list of platforms
                if (request.Platforms != null && request.Platforms.Count > 0)
                {
                    campaignsQuery = campaignsQuery.Where(c => c.CampaignPlatforms.Any(cp => request.Platforms.Contains(cp.PlatformId)));
                }

                var campaignResponsesQuery = campaignsQuery.Select(c => new AnalyticsItem
                {
                    Id = c.Id,
                    Name = c.Name,
                    Start = c.StartDate,
                    End = c.EndDate,
                    Budget = c.Budget,
                    NumberOfApplications = 0,
                    NumberOfParticipants = c.OpenPositions,
                    EngagementRate = 0,
                    ROI = 0,
                    Status = CampaignStatus.ToBaseStatus(c.Status)
                });

                // generate list number of applications
                var listNumberOfApplications = new List<int>();
                foreach (var campaign in campaignResponsesQuery)
                {
                    var numberOfApplications = await GetNumberApplicationsAsync(campaign.Id);
                    listNumberOfApplications.Add(numberOfApplications);
                }

                // get available tags and count finished campaigns
                var finishedCampaignsCount = 0;

                var availableTags = new List<DropdownItem>();
                foreach (var campaign in campaignResponsesQuery)
                {
                    if (campaign.Status.Value == CampaignStatus.Completed.Value ||
                        campaign.Status.Value == CampaignStatus.Archived.Value)
                    {
                        finishedCampaignsCount++;
                    }

                    var tags = await _context.CampaignTags
                        .Include(t => t.Tag)
                        .Where(ct => ct.CampaignId == campaign.Id)
                        .ToListAsync();

                    foreach (var tag in tags)
                    {
                        availableTags.Add(new DropdownItem
                        {
                            Id = tag.TagId,
                            Name = tag.Tag.TagName
                        });
                    }
                }

                var campaigns = await PagedList<AnalyticsItem>.CreateAsync(campaignResponsesQuery, request.Page, request.PageSize);

                foreach (var campaign in campaigns.Items)
                {
                    var numberOfApplications = await GetNumberApplicationsAsync(campaign.Id);
                    var numberOfParticipants = await GetNumberOfParticipantsAsync(campaign.Id);

                    campaign.NumberOfApplications = numberOfApplications;
                    campaign.NumberOfParticipants = numberOfParticipants;

                    if (campaign.NumberOfApplications > 0)
                    {
                        campaign.EngagementRate = (campaign.NumberOfParticipants / numberOfApplications) * 100;
                    }
                    else
                    {
                        campaign.EngagementRate = 0;
                    }

                    var cost = await GetCostOfCampaign(campaign.Id);
                    if (cost > 0)
                    {
                        campaign.ROI = 100.0 * (campaign.Budget / cost);
                    }
                    else
                    {
                        campaign.ROI = 0;
                    }
                }

                var campaignAnalytics = new AnalyticsResponse
                {
                    Total = campaignResponsesQuery.Count(),
                    ListNumberOfApplications = listNumberOfApplications,
                    CampaignsList = campaigns
                };

                // calculate Platform percentages
                var platformFull = new Dictionary<string, int>();
                foreach (var campaign in campaignsQuery)
                {
                    var campaignPlatforms = await _context.CampaignPlatforms
                        .Include(cp => cp.Platform)
                        .Where(cp => cp.CampaignId == campaign.Id)
                        .ToListAsync();

                    if(campaignPlatforms != null)
                    {
                        foreach(var campaignPlatform in campaignPlatforms)
                        {
                            if (platformFull.ContainsKey(campaignPlatform.Platform.Name))
                            {
                                platformFull[campaignPlatform.Platform.Name]++;
                            }
                            else
                            {
                                platformFull.Add(campaignPlatform.Platform.Name, 1);
                            }
                        }
                    }
                }

                campaignAnalytics.Platforms = new List<PlatformItem>();
                foreach (var platform in platformFull)
                {
                    double total = campaignAnalytics.Total;
                    if (total == 0)
                    {
                        total = 1;
                    }
                    campaignAnalytics.Platforms.Add(new PlatformItem
                    {
                        Name = platform.Key,
                        Percentage = (int)((platform.Value / total) * 100)
                    });
                }

                // get all platforms
                campaignAnalytics.AllPlatforms = new List<DropdownItem>();

                var platforms = await _context.Platforms.ToListAsync();
                if (platforms != null)
                {
                    foreach (var platform in platforms)
                    {
                        campaignAnalytics.AllPlatforms.Add(new DropdownItem
                        {
                            Id = platform.Id,
                            Name = platform.Name
                        });
                    }
                }

                // set available tags
                campaignAnalytics.AvailableTags = availableTags;

                // get all statuses from enumeration
                var statusList = CampaignStatus.GetAllCampaignStatuses();
                campaignAnalytics.AllStatuses = new List<DropdownItem>();
                foreach (var status in statusList)
                {
                    campaignAnalytics.AllStatuses.Add(new DropdownItem
                    {
                        Id = status.Key,
                        Name = status.Value
                    });
                }

                // set finished campaigns count
                campaignAnalytics.FinishedCampaignsCount = finishedCampaignsCount;

                return campaignAnalytics;

            }
            catch (Exception ex)
            {
                throw new BadRequestException(ex.Message);
            }
        }

        private async Task<int> GetNumberOfParticipantsAsync(int campaignId)
        {
            var numberOfInfluencers = 0;
            var influencers = await _context.CampaignUsers
                .Where(cu => cu.CampaignId == campaignId &&
                (cu.Status == CampaignUserStatus.Accepted.Value ||
                cu.Status == CampaignUserStatus.InProgress.Value ||
                cu.Status == CampaignUserStatus.Completed.Value ||
                cu.Status == CampaignUserStatus.PayedOut.Value))
                .ToListAsync();

            if (influencers != null)
            {
                numberOfInfluencers = influencers.Count;
            }
            return numberOfInfluencers;
        }

        private async Task<int> GetNumberApplicationsAsync(int campaignId)
        {
            var numberOfApplications = 0;
            var applications = await _context.CampaignUsers
                .Where(ca => ca.CampaignId == campaignId)
                .ToListAsync();
            if (applications != null)
            {
                numberOfApplications = applications.Count;
            }
            return numberOfApplications;
        }

        private async Task<double> GetCostOfCampaign(int campaignId)
        {
            var costList = await _context.UserCampaignAchievementPoints
                .Include(ucap => ucap.AchievementPoint)
                .ThenInclude(ap => ap.AchievementType)
                .Where(ucap => ucap.CampaignId == campaignId)
                .ToListAsync();

            double cost = 0.0;
            foreach (var item in costList)
            {
                cost += item.AchievementPoint.AchievementType.Value;
            }

            return cost;
        }
    }
}
