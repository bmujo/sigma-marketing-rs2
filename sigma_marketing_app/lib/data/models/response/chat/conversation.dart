import 'package:json_annotation/json_annotation.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'name')
  String name = "";

  @JsonKey(name: 'lastMessage')
  String lastMessage = "";

  @JsonKey(name: 'timeOfLastMessage')
  DateTime timeOfLastMessage = DateTime.now();

  @JsonKey(name: 'imageOfSender')
  String imageOfSender = "";

  @JsonKey(name: 'senderId')
  int senderId = 0;

  @JsonKey(name: 'numberOfUnread')
  int numberOfUnread = 0;

  Conversation(
      {required this.id,
        required this.name,
        required this.lastMessage,
        required this.timeOfLastMessage,
        required this.imageOfSender,
        required this.senderId,
        required this.numberOfUnread});

  factory Conversation.fromJson(dynamic json) => _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}