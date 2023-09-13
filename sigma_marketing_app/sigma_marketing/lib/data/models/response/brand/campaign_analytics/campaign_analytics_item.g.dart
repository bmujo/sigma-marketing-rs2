// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_analytics_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignAnalyticsItem _$CampaignAnalyticsItemFromJson(
        Map<String, dynamic> json) =>
    CampaignAnalyticsItem(
      id: json['id'] as int,
      name: json['name'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      budget: json['budget'] as int,
      numberOfApplications: json['numberOfApplications'] as int,
      numberOfParticipants: json['numberOfParticipants'] as int,
      engagementRate: (json['engagementRate'] as num).toDouble(),
      ROI: (json['roi'] as num).toDouble(),
      status: BaseStatus.fromJson(json['status']),
    );

Map<String, dynamic> _$CampaignAnalyticsItemToJson(
        CampaignAnalyticsItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'budget': instance.budget,
      'numberOfApplications': instance.numberOfApplications,
      'numberOfParticipants': instance.numberOfParticipants,
      'engagementRate': instance.engagementRate,
      'roi': instance.ROI,
      'status': instance.status,
    };
