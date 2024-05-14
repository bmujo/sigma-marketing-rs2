import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import 'my_campaign_item.dart';

part 'my_campaigns.g.dart';

@JsonSerializable()
class MyCampaigns {
  @JsonKey(name: 'finished')
  List<MyCampaignItem> finished = [];

  @JsonKey(name: 'inProgress')
  List<MyCampaignItem> inProgress = [];

  @JsonKey(name: 'requested')
  List<MyCampaignItem> requested = [];

  MyCampaigns(
      {required this.finished,
      required this.inProgress,
      required this.requested});

  factory MyCampaigns.fromJson(dynamic json) => _$MyCampaignsFromJson(json);

  Map<String, dynamic> toJson() => _$MyCampaignsToJson(this);
}
