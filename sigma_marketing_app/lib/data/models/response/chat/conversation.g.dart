// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
      id: json['id'] as int,
      name: json['name'] as String,
      lastMessage: json['lastMessage'] as String,
      timeOfLastMessage: DateTime.parse(json['timeOfLastMessage'] as String),
      imageOfSender: json['imageOfSender'] as String,
      senderId: json['senderId'] as int,
      numberOfUnread: json['numberOfUnread'] as int,
    );

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastMessage': instance.lastMessage,
      'timeOfLastMessage': instance.timeOfLastMessage.toIso8601String(),
      'imageOfSender': instance.imageOfSender,
      'senderId': instance.senderId,
      'numberOfUnread': instance.numberOfUnread,
    };
