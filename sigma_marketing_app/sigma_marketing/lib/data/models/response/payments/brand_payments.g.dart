// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_payments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandPayments _$BrandPaymentsFromJson(Map<String, dynamic> json) =>
    BrandPayments(
      id: json['id'] as int,
      userFullName: json['userFullName'] as String,
      type: json['type'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      status: json['status'] as String,
      campaign: json['campaign'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
    );

Map<String, dynamic> _$BrandPaymentsToJson(BrandPayments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userFullName': instance.userFullName,
      'type': instance.type,
      'price': instance.price,
      'amount': instance.amount,
      'status': instance.status,
      'campaign': instance.campaign,
      'date': instance.date,
      'time': instance.time,
    };
