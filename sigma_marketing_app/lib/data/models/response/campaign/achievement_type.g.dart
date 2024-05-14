// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementType _$AchievementTypeFromJson(Map<String, dynamic> json) =>
    AchievementType(
      id: json['id'] as int,
      name: json['name'] as String,
      explanation: json['explanation'] as String,
      imageUrl: json['imageUrl'] as String,
      value: json['value'] as int,
      valueCash: (json['valueCash'] as num).toDouble(),
      type: json['type'] as int,
    );

Map<String, dynamic> _$AchievementTypeToJson(AchievementType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'explanation': instance.explanation,
      'imageUrl': instance.imageUrl,
      'value': instance.value,
      'valueCash': instance.valueCash,
      'type': instance.type,
    };
