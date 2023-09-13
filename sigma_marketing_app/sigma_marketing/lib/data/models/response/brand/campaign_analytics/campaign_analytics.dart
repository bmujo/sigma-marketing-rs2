import 'package:json_annotation/json_annotation.dart';
import 'package:sigma_marketing/data/models/response/brand/campaign_analytics/campaign_analytics_item.dart';
import 'package:sigma_marketing/data/models/response/brand/campaign_analytics/dropdown_item.dart';
import 'package:sigma_marketing/data/models/response/brand/campaign_analytics/platform_item.dart';

import '../../../paged_list/paged_list.dart';

part 'campaign_analytics.g.dart';

@JsonSerializable()
class CampaignAnalytics {
  @JsonKey(name: 'total')
  int total = 0;

  @JsonKey(name: 'platforms')
  List<PlatformItem> platforms = [];

  @JsonKey(name: 'listNumberOfApplications')
  List<int> listNumberOfApplications = [];

  @JsonKey(name: 'finishedCampaignsCount')
  int finishedCampaignsCount = 0;

  @JsonKey(name: 'campaignsList')
  PagedList<CampaignAnalyticsItem> campaignsList =
      PagedList<CampaignAnalyticsItem>(
          items: [],
          page: 0,
          pageSize: 0,
          totalCount: 0,
          hasNextPage: false,
          hasPreviousPage: false);

  @JsonKey(name: 'availableTags')
  List<DropdownItem> availableTags = [];

  @JsonKey(name: 'allPlatforms')
  List<DropdownItem> allPlatforms = [];

  @JsonKey(name: 'allStatuses')
  List<DropdownItem> allStatuses = [];

  CampaignAnalytics({
    required this.total,
    required this.platforms,
    required this.listNumberOfApplications,
    required this.campaignsList,
    required this.availableTags,
    required this.allPlatforms,
    required this.allStatuses,
  });

  factory CampaignAnalytics.fromJson(dynamic json) =>
      _$CampaignAnalyticsFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignAnalyticsToJson(this);
}
