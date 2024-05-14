import 'package:json_annotation/json_annotation.dart';

part 'sigma_token.g.dart';

@JsonSerializable()
class SigmaToken {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'packageName')
  String packageName = "";

  @JsonKey(name: 'amount')
  int amount = 0;

  @JsonKey(name: 'price')
  double price = 0.0;

  SigmaToken(
      {required this.id,
        required this.packageName,
        required this.amount,
        required this.price});

  factory SigmaToken.fromJson(dynamic json) =>
      _$SigmaTokenFromJson(json);

  Map<String, dynamic> toJson() => _$SigmaTokenToJson(this);
}