import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {

  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'email')
  String email = "";

  @JsonKey(name: 'name')
  String name = "";

  ProfileResponse({required this.id, required this.email, required this.name});

  factory ProfileResponse.fromJson(dynamic json) => _$ProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}