// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_details_brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignDetailsBrand _$CampaignDetailsBrandFromJson(
        Map<String, dynamic> json) =>
    CampaignDetailsBrand(
      id: json['id'] as int,
      title: json['title'] as String,
      details: json['details'] as String,
      budget: json['budget'] as int,
      maxPositions: json['maxPositions'] as int,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      imageUrl: json['imageUrl'] as String,
      videoUrl: json['videoUrl'] as String,
      assetsUrl: json['assetsUrl'] as String,
      requirementsAndContentGuidelines:
          json['requirementsAndContentGuidelines'] as String,
      likes: json['likes'] as int,
      influencers: json['influencers'] as int,
      campaignStatus: BaseStatus.fromJson(json['campaignStatus']),
      isActive: json['isActive'] as bool,
      tags: (json['tags'] as List<dynamic>).map(TagData.fromJson).toList(),
      achievementPoints: (json['achievementPoints'] as List<dynamic>)
          .map(AchievementPoint.fromJson)
          .toList(),
      platforms: (json['platforms'] as List<dynamic>)
          .map(PlatformData.fromJson)
          .toList(),
      paymentTerms: PaymentTermsData.fromJson(json['paymentTerms']),
      currentInfluencers: (json['currentInfluencers'] as List<dynamic>)
          .map(Influencer.fromJson)
          .toList(),
      campaignCreateData:
          CampaignCreateData.fromJson(json['campaignCreateData']),
    )..deadlineForApplications =
        DateTime.parse(json['deadlineForApplications'] as String);

Map<String, dynamic> _$CampaignDetailsBrandToJson(
        CampaignDetailsBrand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'details': instance.details,
      'budget': instance.budget,
      'maxPositions': instance.maxPositions,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'deadlineForApplications':
          instance.deadlineForApplications.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'videoUrl': instance.videoUrl,
      'assetsUrl': instance.assetsUrl,
      'requirementsAndContentGuidelines':
          instance.requirementsAndContentGuidelines,
      'likes': instance.likes,
      'influencers': instance.influencers,
      'campaignStatus': instance.campaignStatus,
      'isActive': instance.isActive,
      'tags': instance.tags,
      'achievementPoints': instance.achievementPoints,
      'platforms': instance.platforms,
      'paymentTerms': instance.paymentTerms,
      'currentInfluencers': instance.currentInfluencers,
      'campaignCreateData': instance.campaignCreateData,
    };
