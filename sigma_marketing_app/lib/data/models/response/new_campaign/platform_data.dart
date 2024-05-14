import 'package:json_annotation/json_annotation.dart';

part 'platform_data.g.dart';

@JsonSerializable()
class PlatformData {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'name')
  String name = "";

  PlatformData({required this.id, required this.name});

  factory PlatformData.fromJson(dynamic json) => _$PlatformDataFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformDataToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PlatformData && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
