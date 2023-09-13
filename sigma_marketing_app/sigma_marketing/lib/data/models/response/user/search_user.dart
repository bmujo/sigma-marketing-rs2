import 'package:json_annotation/json_annotation.dart';

part 'search_user.g.dart';

@JsonSerializable()
class SearchUser {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'imageUrl')
  String imageUrl = "";

  @JsonKey(name: 'firstName')
  String firstName = "";

  @JsonKey(name: 'lastName')
  String lastName = "";

  SearchUser(
      {required this.id,
        required this.imageUrl,
        required this.firstName,
        required this.lastName});

  factory SearchUser.fromJson(dynamic json) =>
      _$SearchUserFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserToJson(this);

  copyWith({required bool isLiked}) {
    return SearchUser(
        id: id,
        imageUrl: imageUrl,
        firstName: firstName,
        lastName: lastName);
  }
}