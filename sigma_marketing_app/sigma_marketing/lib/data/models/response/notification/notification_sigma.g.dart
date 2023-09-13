// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_sigma.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSigma _$NotificationSigmaFromJson(Map<String, dynamic> json) =>
    NotificationSigma(
      id: json['id'] as int,
      created: DateTime.parse(json['created'] as String),
      title: json['title'] as String,
      message: json['message'] as String,
      isOpen: json['isOpen'] as bool,
      type: json['type'] as int,
    );

Map<String, dynamic> _$NotificationSigmaToJson(NotificationSigma instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created.toIso8601String(),
      'title': instance.title,
      'message': instance.message,
      'isOpen': instance.isOpen,
      'type': instance.type,
    };
