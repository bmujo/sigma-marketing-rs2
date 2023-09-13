import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:sigma_marketing/presentation/brand/model/message_model.dart';
import 'package:sigma_marketing/push_notifications/desktop_push_notifications.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../config/constants.dart';
import '../../../../data/models/request/chat/new_message.dart';
import '../../../../data/repositories/repository_impl.dart';

part 'chat_details_event.dart';
part 'chat_details_state.dart';

const _messagesLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ChatDetailsBloc extends Bloc<ChatDetailsEvent, ChatDetailsState> {
  final int receiverId;
  final RepositoryImpl _repository = RepositoryImpl();
  int currentPage = 1;

  ChatDetailsBloc({required this.receiverId})
      : super(const ChatDetailsState()) {
    on<ChatDetailsFetched>(
      _onChatDetailsFetched,
      transformer: throttleDroppable(throttleDuration),
    );

    on<ChatDetailsSend>(
      _onChatDetailsSend,
      transformer: throttleDroppable(throttleDuration),
    );

    on<ChatDetailsRefresh>(
      _onChatDetailsRefresh,
      transformer: throttleDroppable(throttleDuration),
    );

    setupHubConnection();
  }

  Future<void> setupHubConnection() async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: "token") ?? "";

      final connection = HubConnectionBuilder()
          .withUrl(AppConstants.chatUrl,
              options: HttpConnectionOptions(
                accessTokenFactory: () => Future.value("Bearer $token"),
              ))
          .build();

      connection.on("ReceiveMessage", (args) async {
        if (args != null) {
          var sender = "New Message";
          var message = "You have received a new message.";
          try {
            sender = args[0] as String;
            message = args[1] as String;
          } catch (e) {
            Logger().e(e);
          }
          sendDesktopNotification(sender, message);
          add(ChatDetailsRefresh());
        }
      });

      await connection.start();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<void> _onChatDetailsRefresh(
      ChatDetailsRefresh event, Emitter<ChatDetailsState> emit) async {
    try {
      currentPage = 1;
      final messages = await _fetchMessages(receiverId, currentPage);
      currentPage++;
      final hasMoreData = messages.length == _messagesLimit;
      messages.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
            status: ChatDetailsStatus.success,
            messages: messages,
            hasReachedMax: !hasMoreData),
      );
    } catch (_) {
      emit(state.copyWith(status: ChatDetailsStatus.failure));
    }
  }

  Future<void> _onChatDetailsFetched(
    ChatDetailsFetched event,
    Emitter<ChatDetailsState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ChatDetailsStatus.initial) {
        currentPage = 1;
        final messages = await _fetchMessages(event.receiverId, currentPage);
        currentPage++;
        var hasMoreData = messages.length == _messagesLimit;

        return emit(
          state.copyWith(
              status: ChatDetailsStatus.success,
              messages: messages,
              hasReachedMax: !hasMoreData),
        );
      } else {
        final messages = await _fetchMessages(event.receiverId, currentPage);
        currentPage++;
        final hasMoreData = messages.length == _messagesLimit;
        messages.isEmpty
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(
          state.copyWith(
              status: ChatDetailsStatus.success,
              messages: state.messages + messages,
              hasReachedMax: !hasMoreData),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: ChatDetailsStatus.failure));
    }
  }

  Future<List<MessageModel>> _fetchMessages(int receiverId, int page) async {
    try {
      const storage = FlutterSecureStorage();
      String userId = await storage.read(key: "userId") ?? "";

      await _repository.readMessages(receiverId);
      final response =
          await _repository.getConversationChat(receiverId, page, _messagesLimit);

      // Convert messages to UI model MessageModel
      final messagesModel = <MessageModel>[];
      for (final e in response.items) {
        final isMe = e.senderId == int.parse(userId);

        final messageModel = MessageModel(
          id: e.id,
          created: e.created,
          messageText: e.messageText,
          senderId: e.senderId,
          receiverId: e.receiverId,
          messageOwnerId: e.messageOwnerId,
          isRead: e.isRead,
          senderImage: e.senderImage,
          receiverImage: e.receiverImage,
          isMe: isMe,
        );

        messagesModel.add(messageModel);
      }

      if (messagesModel.isNotEmpty) {
        return messagesModel;
      } else {
        return [];
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }

    throw Exception('error fetching posts');
  }

  Future<void> _onChatDetailsSend(
      ChatDetailsSend event, Emitter<ChatDetailsState> emit) async {
    try {
      final message = await _repository.sendMessage(event.newMessage);

      // Convert message to UI model MessageModel
      const isMe = true;
      final messageToAdd = MessageModel(
        id: message.id,
        created: message.created,
        messageText: message.messageText,
        senderId: message.senderId,
        receiverId: message.receiverId,
        messageOwnerId: message.messageOwnerId,
        isRead: message.isRead,
        senderImage: message.senderImage,
        receiverImage: message.receiverImage,
        isMe: isMe,
      );

      final newMessages = List<MessageModel>.of(state.messages)..insert(0, messageToAdd);
      emit(state.copyWith(
          status: ChatDetailsStatus.success,
          messages: newMessages,
          hasReachedMax: true));
    } catch (_) {
      //add(ChatDetailsFetched());
    }
  }
}
