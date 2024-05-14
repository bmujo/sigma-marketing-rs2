// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignDetails _$CampaignDetailsFromJson(Map<String, dynamic> json) =>
    CampaignDetails(
      id: json['id'] as int,
      title: json['title'] as String,
      details: json['details'] as String,
      maxPositions: json['maxPositions'] as int,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
      videoUrl: json['videoUrl'] as String,
      company: json['company'] as String,
      likes: json['likes'] as int,
      liked: json['liked'] as bool,
      influencers: json['influencers'] as int,
      campaignStatus: json['campaignStatus'] as int,
      campaignUserStatus: json['campaignUserStatus'] as int,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      achievementPoints: (json['achievementPoints'] as List<dynamic>)
          .map(AchievementPoint.fromJson)
          .toList(),
      companyBio: json['companyBio'] as String,
      companyImageUrl: json['companyImageUrl'] as String,
      campaignLocation: json['campaignLocation'] as String,
    );

Map<String, dynamic> _$CampaignDetailsToJson(CampaignDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'details': instance.details,
      'maxPositions': instance.maxPositions,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'photos': instance.photos,
      'videoUrl': instance.videoUrl,
      'company': instance.company,
      'likes': instance.likes,
      'liked': instance.liked,
      'influencers': instance.influencers,
      'campaignStatus': instance.campaignStatus,
      'campaignUserStatus': instance.campaignUserStatus,
      'tags': instance.tags,
      'achievementPoints': instance.achievementPoints,
      'companyBio': instance.companyBio,
      'companyImageUrl': instance.companyImageUrl,
      'campaignLocation': instance.campaignLocation,
    };
