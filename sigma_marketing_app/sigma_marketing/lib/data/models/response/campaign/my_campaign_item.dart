import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'my_campaign_item.g.dart';

@JsonSerializable()
class MyCampaignItem {
  @JsonKey(name: 'campaignId')
  int campaignId = 0;

  @JsonKey(name: 'image')
  String image = "";

  @JsonKey(name: 'name')
  String name = "";

  @JsonKey(name: 'location')
  String location = "";

  @JsonKey(name: 'stars')
  int stars = 0;

  @JsonKey(name: 'days')
  int days = 0;

  @JsonKey(name: 'daysPassed')
  int daysPassed = 0;

  @JsonKey(name: 'status')
  String status = "";

  MyCampaignItem(
      {required this.campaignId,
      required this.image,
      required this.name,
      required this.location,
      required this.stars,
      required this.days,
      required this.daysPassed,
      required this.status});

  factory MyCampaignItem.fromJson(dynamic json) =>
      _$MyCampaignItemFromJson(json);

  Map<String, dynamic> toJson() => _$MyCampaignItemToJson(this);
}
