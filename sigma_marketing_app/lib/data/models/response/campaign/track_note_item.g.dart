// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_note_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackNoteItem _$TrackNoteItemFromJson(Map<String, dynamic> json) =>
    TrackNoteItem(
      type: json['type'] as String,
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$TrackNoteItemToJson(TrackNoteItem instance) =>
    <String, dynamic>{
      'type': instance.type,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
    };
