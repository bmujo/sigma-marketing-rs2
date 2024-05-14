// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_campaigns.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCampaigns _$MyCampaignsFromJson(Map<String, dynamic> json) => MyCampaigns(
      finished: (json['finished'] as List<dynamic>)
          .map(MyCampaignItem.fromJson)
          .toList(),
      inProgress: (json['inProgress'] as List<dynamic>)
          .map(MyCampaignItem.fromJson)
          .toList(),
      requested: (json['requested'] as List<dynamic>)
          .map(MyCampaignItem.fromJson)
          .toList(),
    );

Map<String, dynamic> _$MyCampaignsToJson(MyCampaigns instance) =>
    <String, dynamic>{
      'finished': instance.finished,
      'inProgress': instance.inProgress,
      'requested': instance.requested,
    };
