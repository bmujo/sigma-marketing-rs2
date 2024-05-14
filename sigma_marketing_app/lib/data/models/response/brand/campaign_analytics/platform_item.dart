import 'package:json_annotation/json_annotation.dart';

part 'platform_item.g.dart';

@JsonSerializable()
class PlatformItem {

  @JsonKey(name: 'name')
  String name = "";

  @JsonKey(name: 'percentage')
  int percentage = 0;

  PlatformItem(
      {required this.name,
      required this.percentage});

  factory PlatformItem.fromJson(dynamic json) =>
      _$PlatformItemFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformItemToJson(this);
}