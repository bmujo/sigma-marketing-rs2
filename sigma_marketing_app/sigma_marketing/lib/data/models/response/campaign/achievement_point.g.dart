// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementPoint _$AchievementPointFromJson(Map<String, dynamic> json) =>
    AchievementPoint(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      type: AchievementType.fromJson(json['type']),
      status: BaseStatus.fromJson(json['status']),
    )..trackNotes = (json['trackNotes'] as List<dynamic>)
        .map(TrackNoteItem.fromJson)
        .toList();

Map<String, dynamic> _$AchievementPointToJson(AchievementPoint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'status': instance.status,
      'trackNotes': instance.trackNotes,
    };
