import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'created')
  DateTime created = DateTime.now();

  @JsonKey(name: 'messageText')
  String messageText = "";

  @JsonKey(name: 'senderId')
  int senderId = 0;

  @JsonKey(name: 'receiverId')
  int receiverId = 0;

  @JsonKey(name: 'messageOwnerId')
  int messageOwnerId = 0;

  @JsonKey(name: 'isRead')
  bool isRead = false;

  @JsonKey(name: 'senderImage')
  String senderImage = "";

  @JsonKey(name: 'receiverImage')
  String receiverImage = "";

  Message(
      {required this.id,
      required this.created,
      required this.messageText,
      required this.senderId,
      required this.receiverId,
      required this.messageOwnerId,
      required this.isRead,
      required this.senderImage,
      required this.receiverImage});

  factory Message.fromJson(dynamic json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}