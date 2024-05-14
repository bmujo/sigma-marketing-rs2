part of '../../../../../blocs/common/chat/chat_list/chat_list_bloc.dart';

abstract class ChatListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatListFetched extends ChatListEvent {}

class ChatListRefresh extends ChatListEvent {}

class OnStartNewChat extends ChatListEvent {
  final SearchUser user;

  OnStartNewChat({required this.user});

  @override
  List<Object> get props => [user];
}