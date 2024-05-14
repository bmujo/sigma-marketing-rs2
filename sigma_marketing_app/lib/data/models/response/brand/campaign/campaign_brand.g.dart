// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignBrand _$CampaignBrandFromJson(Map<String, dynamic> json) =>
    CampaignBrand(
      id: json['id'] as int,
      title: json['title'] as String,
      likes: json['likes'] as int,
      influencers: json['influencers'] as int,
      imageUrl: json['image'] as String,
      status: BaseStatus.fromJson(json['status']),
    );

Map<String, dynamic> _$CampaignBrandToJson(CampaignBrand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'likes': instance.likes,
      'influencers': instance.influencers,
      'image': instance.imageUrl,
      'status': instance.status,
    };
