// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentUser _$PaymentUserFromJson(Map<String, dynamic> json) => PaymentUser(
      balance: json['balance'] as int,
      payments: (json['payments'] as List<dynamic>)
          .map(PaymentUserItem.fromJson)
          .toList(),
      paypalEmail: json['paypalEmail'] as String,
    );

Map<String, dynamic> _$PaymentUserToJson(PaymentUser instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'paypalEmail': instance.paypalEmail,
      'payments': instance.payments,
    };
