import 'package:json_annotation/json_annotation.dart';

part 'profile_details.g.dart';

@JsonSerializable()
class ProfileDetails {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'email')
  String email = "";

  @JsonKey(name: 'firstName')
  String firstName = "";

  @JsonKey(name: 'lastName')
  String lastName = "";

  @JsonKey(name: 'instagram')
  String instagram = "";

  @JsonKey(name: 'tikTok')
  String tikTok = "";

  @JsonKey(name: 'facebook')
  String facebook = "";

  @JsonKey(name: 'linkedIn')
  String linkedIn = "";

  @JsonKey(name: 'bio')
  String bio = "";

  @JsonKey(name: 'profileImageUrl')
  String profileImageUrl = "";

  ProfileDetails(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.instagram,
      required this.tikTok,
      required this.facebook,
      required this.linkedIn,
      required this.bio,
      required this.profileImageUrl});

  factory ProfileDetails.fromJson(dynamic json) =>
      _$ProfileDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDetailsToJson(this);
}
