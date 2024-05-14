// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int,
      created: DateTime.parse(json['created'] as String),
      messageText: json['messageText'] as String,
      senderId: json['senderId'] as int,
      receiverId: json['receiverId'] as int,
      messageOwnerId: json['messageOwnerId'] as int,
      isRead: json['isRead'] as bool,
      senderImage: json['senderImage'] as String,
      receiverImage: json['receiverImage'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'created': instance.created.toIso8601String(),
      'messageText': instance.messageText,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'messageOwnerId': instance.messageOwnerId,
      'isRead': instance.isRead,
      'senderImage': instance.senderImage,
      'receiverImage': instance.receiverImage,
    };
