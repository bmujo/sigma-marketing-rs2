// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentBrand _$PaymentBrandFromJson(Map<String, dynamic> json) => PaymentBrand(
      balance: json['balance'] as int,
      payments: (json['payments'] as List<dynamic>)
          .map(BrandPayments.fromJson)
          .toList(),
    );

Map<String, dynamic> _$PaymentBrandToJson(PaymentBrand instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'payments': instance.payments,
    };
