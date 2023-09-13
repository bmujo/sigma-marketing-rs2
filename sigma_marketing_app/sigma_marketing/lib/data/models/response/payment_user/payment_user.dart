import 'package:json_annotation/json_annotation.dart';
import 'package:sigma_marketing/data/models/response/payment_user/payment_user_item.dart';

part 'payment_user.g.dart';

@JsonSerializable()
class PaymentUser {
  @JsonKey(name: 'balance')
  int balance = 0;

  @JsonKey(name: 'paypalEmail')
  String paypalEmail = "";

  @JsonKey(name: 'payments')
  List<PaymentUserItem> payments = [];

  PaymentUser({
    required this.balance,
    required this.payments,
    required this.paypalEmail,
  });

  factory PaymentUser.defaultPaymentUser() {
    return PaymentUser(
      balance: 0,
      paypalEmail: "",
      payments: [],
    );
  }

  factory PaymentUser.fromJson(dynamic json) => _$PaymentUserFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentUserToJson(this);
}
