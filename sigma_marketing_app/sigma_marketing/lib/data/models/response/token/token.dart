import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'token')
  String token = "";

  @JsonKey(name: 'userId')
  int userId = 0;

  Token({required this.token});

  factory Token.fromJson(dynamic json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
