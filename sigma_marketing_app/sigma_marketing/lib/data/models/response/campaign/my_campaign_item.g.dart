// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_campaign_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCampaignItem _$MyCampaignItemFromJson(Map<String, dynamic> json) =>
    MyCampaignItem(
      campaignId: json['campaignId'] as int,
      image: json['image'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      stars: json['stars'] as int,
      days: json['days'] as int,
      daysPassed: json['daysPassed'] as int,
      status: json['status'] as String,
    );

Map<String, dynamic> _$MyCampaignItemToJson(MyCampaignItem instance) =>
    <String, dynamic>{
      'campaignId': instance.campaignId,
      'image': instance.image,
      'name': instance.name,
      'location': instance.location,
      'stars': instance.stars,
      'days': instance.days,
      'daysPassed': instance.daysPassed,
      'status': instance.status,
    };
