import 'package:json_annotation/json_annotation.dart';

part 'payment_user_item.g.dart';

@JsonSerializable()
class PaymentUserItem {
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
  DateTime date = DateTime.now();

  PaymentUserItem(
      {required this.type,
        required this.price,
        required this.amount,
        required this.status,
        required this.campaign,
        required this.date});

  factory PaymentUserItem.fromJson(dynamic json) => _$PaymentUserItemFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentUserItemToJson(this);
}