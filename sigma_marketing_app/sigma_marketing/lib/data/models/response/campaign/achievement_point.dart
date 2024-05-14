import 'package:json_annotation/json_annotation.dart';
import 'package:sigma_marketing/data/models/response/campaign/achievement_type.dart';
import 'package:sigma_marketing/data/models/response/campaign/track_note_item.dart';

import '../base/base_status.dart';

part 'achievement_point.g.dart';

@JsonSerializable()
class AchievementPoint {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'name')
  String name = "";

  @JsonKey(name: 'description')
  String description = "";

  @JsonKey(name: 'type')
  AchievementType type = AchievementType(
    id: 0,
    name: '',
    explanation: '',
    imageUrl: '',
    value: 0,
    valueCash: 0.0,
    type: 0,
  );

  @JsonKey(name: 'status')
  BaseStatus status = BaseStatus(value: 0, name: '', color: '');

  @JsonKey(name: 'trackNotes')
  List<TrackNoteItem> trackNotes = [];

  AchievementPoint({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.status,
  });

  factory AchievementPoint.fromJson(dynamic json) =>
      _$AchievementPointFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementPointToJson(this);
}
