import 'package:json_annotation/json_annotation.dart';

part 'brand_payments.g.dart';

@JsonSerializable()
class BrandPayments {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'userFullName')
  String userFullName = "";

  @JsonKey(name: 'type')
  String type = "";

  @JsonKey(name: 'price')
  double price = 0;

  @JsonKey(name: 'amount')
  int amount = 0;

  @JsonKey(name: 'status')
  String status = "";

  @JsonKey(name: 'campaign')
  String campaign = "";

  @JsonKey(name: 'date')
  String date = "";

  @JsonKey(name: 'time')
  String time = "";

  BrandPayments(
      {required this.id,
        required this.userFullName,
        required this.type,
        required this.price,
        required this.amount,
        required this.status,
        required this.campaign,
        required this.date,
        required this.time});

  factory BrandPayments.fromJson(dynamic json) => _$BrandPaymentsFromJson(json);

  Map<String, dynamic> toJson() => _$BrandPaymentsToJson(this);
}