part of '../../../../../blocs/common/chat/chat_details/chat_details_bloc.dart';

abstract class ChatDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatDetailsFetched extends ChatDetailsEvent {
  final int receiverId;

  ChatDetailsFetched({ required this.receiverId});
}

class ChatDetailsSend extends ChatDetailsEvent {
  final NewMessage newMessage;

  ChatDetailsSend({required this.newMessage});
}

class ChatDetailsRefresh extends ChatDetailsEvent {}