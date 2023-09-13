part of 'chat_details_bloc.dart';

enum ChatDetailsStatus { initial, success, failure }

class ChatDetailsState extends Equatable {
  const ChatDetailsState({
    this.status = ChatDetailsStatus.initial,
    this.messages = const <MessageModel>[],
    this.hasReachedMax = false,
  });

  final ChatDetailsStatus status;
  final List<MessageModel> messages;
  final bool hasReachedMax;

  ChatDetailsState copyWith({
    ChatDetailsStatus? status,
    List<MessageModel>? messages,
    bool? hasReachedMax,
  }) {
    return ChatDetailsState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${messages.length} }''';
  }

  @override
  List<Object> get props => [status, messages, hasReachedMax];
}
