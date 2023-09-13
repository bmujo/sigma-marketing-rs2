import 'package:json_annotation/json_annotation.dart';

part 'track_note_item.g.dart';

@JsonSerializable()
class TrackNoteItem {
  @JsonKey(name: 'type')
  String type = "";

  @JsonKey(name: 'comment')
  String comment = "";

  @JsonKey(name: 'createdAt')
  DateTime createdAt = DateTime.now();

  TrackNoteItem({
    required this.type,
    required this.comment,
    required this.createdAt,
  });

  factory TrackNoteItem.fromJson(dynamic json) =>
      _$TrackNoteItemFromJson(json);

  Map<String, dynamic> toJson() => _$TrackNoteItemToJson(this);
}