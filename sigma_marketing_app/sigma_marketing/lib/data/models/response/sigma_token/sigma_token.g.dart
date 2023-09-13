// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sigma_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigmaToken _$SigmaTokenFromJson(Map<String, dynamic> json) => SigmaToken(
      id: json['id'] as int,
      packageName: json['packageName'] as String,
      amount: json['amount'] as int,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$SigmaTokenToJson(SigmaToken instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageName': instance.packageName,
      'amount': instance.amount,
      'price': instance.price,
    };
