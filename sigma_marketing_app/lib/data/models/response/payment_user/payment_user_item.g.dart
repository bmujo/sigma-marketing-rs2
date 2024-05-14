// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_user_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentUserItem _$PaymentUserItemFromJson(Map<String, dynamic> json) =>
    PaymentUserItem(
      type: json['type'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      status: json['status'] as String,
      campaign: json['campaign'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$PaymentUserItemToJson(PaymentUserItem instance) =>
    <String, dynamic>{
      'type': instance.type,
      'price': instance.price,
      'amount': instance.amount,
      'status': instance.status,
      'campaign': instance.campaign,
      'date': instance.date.toIso8601String(),
    };
