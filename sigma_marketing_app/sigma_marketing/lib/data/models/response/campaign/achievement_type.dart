import 'package:json_annotation/json_annotation.dart';

part 'achievement_type.g.dart';

@JsonSerializable()
class AchievementType {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'name')
  String name = "";

  @JsonKey(name: 'explanation')
  String explanation = "";

  @JsonKey(name: 'imageUrl')
  String imageUrl = "";

  @JsonKey(name: 'value')
  int value = 0;

  @JsonKey(name: 'valueCash')
  double valueCash = 0.0;

  @JsonKey(name: 'type')
  int type = 0;

  AchievementType({
    required this.id,
    required this.name,
    required this.explanation,
    required this.imageUrl,
    required this.value,
    required this.valueCash,
    required this.type,
  });

  factory AchievementType.fromJson(dynamic json) =>
      _$AchievementTypeFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementTypeToJson(this);
}