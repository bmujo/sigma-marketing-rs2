// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseStatus _$BaseStatusFromJson(Map<String, dynamic> json) => BaseStatus(
      value: json['value'] as int,
      name: json['name'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$BaseStatusToJson(BaseStatus instance) =>
    <String, dynamic>{
      'value': instance.value,
      'name': instance.name,
      'color': instance.color,
    };
