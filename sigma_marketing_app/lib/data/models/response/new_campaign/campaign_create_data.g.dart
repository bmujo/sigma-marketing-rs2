// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_create_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignCreateData _$CampaignCreateDataFromJson(Map<String, dynamic> json) =>
    CampaignCreateData(
      platforms: (json['platforms'] as List<dynamic>)
          .map(PlatformData.fromJson)
          .toList(),
      tags: (json['tags'] as List<dynamic>).map(TagData.fromJson).toList(),
      paymentTerms: (json['paymentTerms'] as List<dynamic>)
          .map(PaymentTermsData.fromJson)
          .toList(),
    )..achievementTypes = (json['achievementTypes'] as List<dynamic>)
        .map(AchievementType.fromJson)
        .toList();

Map<String, dynamic> _$CampaignCreateDataToJson(CampaignCreateData instance) =>
    <String, dynamic>{
      'platforms': instance.platforms,
      'tags': instance.tags,
      'paymentTerms': instance.paymentTerms,
      'achievementTypes': instance.achievementTypes,
    };
