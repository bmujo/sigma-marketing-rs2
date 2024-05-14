import 'package:json_annotation/json_annotation.dart';

import '../../base/base_status.dart';

part 'campaign_brand.g.dart';

@JsonSerializable()
class CampaignBrand {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'title')
  String title = "";

  @JsonKey(name: 'likes')
  int likes = 0;

  @JsonKey(name: 'influencers')
  int influencers = 0;

  @JsonKey(name: 'image')
  String imageUrl = "";

  @JsonKey(name: 'status')
  BaseStatus status = BaseStatus(value: 0, name: '', color: '');

  CampaignBrand(
      {required this.id,
        required this.title,
        required this.likes,
        required this.influencers,
        required this.imageUrl,
        required this.status});

  factory CampaignBrand.fromJson(dynamic json) => _$CampaignBrandFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignBrandToJson(this);

  copyWith() {
    return CampaignBrand(
        id: id,
        title: title,
        likes: likes,
        influencers: influencers,
        imageUrl: imageUrl,
        status: status);
  }
}