import 'package:json_annotation/json_annotation.dart';

part 'base_status.g.dart';

@JsonSerializable()
class BaseStatus {
  @JsonKey(name: 'value')
  int value = 0;

  @JsonKey(name: 'name')
  String name = "";

  @JsonKey(name: 'color')
  String color = "";

  BaseStatus(
      {required this.value,
        required this.name,
        required this.color});

  factory BaseStatus.fromJson(dynamic json) => _$BaseStatusFromJson(json);

  Map<String, dynamic> toJson() => _$BaseStatusToJson(this);
}