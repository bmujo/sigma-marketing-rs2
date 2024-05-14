import 'package:json_annotation/json_annotation.dart';

import '../../base/base_status.dart';
import '../../campaign/achievement_point.dart';

part 'influencer.g.dart';

@JsonSerializable()
class Influencer {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'imageUrl')
  String imageUrl = "";

  @JsonKey(name: 'firstName')
  String firstName = "";

  @JsonKey(name: 'lastName')
  String lastName = "";

  @JsonKey(name: 'status')
  BaseStatus status = BaseStatus(value: 0, name: '', color: '');

  @JsonKey(name: 'currentEarningSigma')
  int currentEarningSigma = 0;

  @JsonKey(name: 'currentEarningCash')
  double currentEarningCash = 0;

  @JsonKey(name: 'achievements')
  List<AchievementPoint> achievements = [];

  Influencer(
      {required this.id,
      required this.imageUrl,
      required this.firstName,
      required this.lastName,
      required this.status,
      required this.currentEarningSigma,
      required this.currentEarningCash,
      required this.achievements});

  factory Influencer.fromJson(dynamic json) => _$InfluencerFromJson(json);

  Map<String, dynamic> toJson() => _$InfluencerToJson(this);
}
