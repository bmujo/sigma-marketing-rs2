// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignAnalytics _$CampaignAnalyticsFromJson(Map<String, dynamic> json) =>
    CampaignAnalytics(
      total: json['total'] as int,
      platforms: (json['platforms'] as List<dynamic>)
          .map(PlatformItem.fromJson)
          .toList(),
      listNumberOfApplications:
          (json['listNumberOfApplications'] as List<dynamic>)
              .map((e) => e as int)
              .toList(),
      campaignsList: PagedList<CampaignAnalyticsItem>.fromJson(
          json['campaignsList'] as Map<String, dynamic>,
          (value) => CampaignAnalyticsItem.fromJson(value)),
      availableTags: (json['availableTags'] as List<dynamic>)
          .map(DropdownItem.fromJson)
          .toList(),
      allPlatforms: (json['allPlatforms'] as List<dynamic>)
          .map(DropdownItem.fromJson)
          .toList(),
      allStatuses: (json['allStatuses'] as List<dynamic>)
          .map(DropdownItem.fromJson)
          .toList(),
    )..finishedCampaignsCount = json['finishedCampaignsCount'] as int;

Map<String, dynamic> _$CampaignAnalyticsToJson(CampaignAnalytics instance) =>
    <String, dynamic>{
      'total': instance.total,
      'platforms': instance.platforms,
      'listNumberOfApplications': instance.listNumberOfApplications,
      'finishedCampaignsCount': instance.finishedCampaignsCount,
      'campaignsList': instance.campaignsList.toJson(
        (value) => value,
      ),
      'availableTags': instance.availableTags,
      'allPlatforms': instance.allPlatforms,
      'allStatuses': instance.allStatuses,
    };
