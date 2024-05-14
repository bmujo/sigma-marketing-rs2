import 'package:json_annotation/json_annotation.dart';

import 'brand_payments.dart';

part 'payment_brand.g.dart';

@JsonSerializable()
class PaymentBrand {
  @JsonKey(name: 'balance')
  int balance = 0;

  @JsonKey(name: 'payments')
  List<BrandPayments> payments = [];

  PaymentBrand({required this.balance, required this.payments});

  factory PaymentBrand.defaultBrand() {
    return PaymentBrand(balance: 0, payments: []);
  }

  factory PaymentBrand.fromJson(dynamic json) => _$PaymentBrandFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentBrandToJson(this);
}

