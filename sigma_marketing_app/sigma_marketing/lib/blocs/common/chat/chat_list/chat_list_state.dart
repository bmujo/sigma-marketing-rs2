part of '../../../../../blocs/common/chat/chat_list/chat_list_bloc.dart';

enum ChatListStatus { initial, empty, success, failure }

class ChatListState extends Equatable {
  const ChatListState({
    this.status = ChatListStatus.initial,
    this.chatList = const <Conversation>[],
    this.hasReachedMax = false,
  });

  final ChatListStatus status;
  final List<Conversation> chatList;
  final bool hasReachedMax;

  ChatListState copyWith({
    ChatListStatus? status,
    List<Conversation>? chatList,
    bool? hasReachedMax,
  }) {
    return ChatListState(
      status: status ?? this.status,
      chatList: chatList ?? this.chatList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${chatList.length} }''';
  }

  @override
  List<Object> get props => [status, chatList, hasReachedMax];
}
