import 'package:json_annotation/json_annotation.dart';

part 'tag_data.g.dart';

@JsonSerializable()
class TagData {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'name')
  String name = "";

  TagData({required this.id, required this.name});

  factory TagData.fromJson(dynamic json) => _$TagDataFromJson(json);

  Map<String, dynamic> toJson() => _$TagDataToJson(this);
}