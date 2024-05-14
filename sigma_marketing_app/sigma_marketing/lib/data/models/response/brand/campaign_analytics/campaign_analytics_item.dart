import 'package:json_annotation/json_annotation.dart';

import '../../base/base_status.dart';

part 'campaign_analytics_item.g.dart';

@JsonSerializable()
class CampaignAnalyticsItem {

@JsonKey(name: 'id')
int id = 0;

@JsonKey(name: 'name')
String name = "";

@JsonKey(name: 'start')
DateTime start = DateTime.now();

@JsonKey(name: 'end')
DateTime end = DateTime.now();

@JsonKey(name: 'budget')
int budget = 0;

@JsonKey(name: 'numberOfApplications')
int numberOfApplications = 0;

@JsonKey(name: 'numberOfParticipants')
int numberOfParticipants = 0;

@JsonKey(name: 'engagementRate')
double engagementRate = 0;

@JsonKey(name: 'roi')
double ROI = 0;

@JsonKey(name: 'status')
BaseStatus status = BaseStatus(value: 0, name: '', color: '');

CampaignAnalyticsItem(
    {required this.id,
        required this.name,
        required this.start,
        required this.end,
        required this.budget,
        required this.numberOfApplications,
        required this.numberOfParticipants,
        required this.engagementRate,
        required this.ROI,
        required this.status});

  factory CampaignAnalyticsItem.fromJson(dynamic json) =>
      _$CampaignAnalyticsItemFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignAnalyticsItemToJson(this);
}