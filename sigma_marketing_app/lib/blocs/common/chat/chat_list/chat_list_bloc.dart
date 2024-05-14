import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sigma_marketing/data/models/response/user/search_user.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../config/constants.dart';
import '../../../../data/models/response/chat/conversation.dart';
import '../../../../data/repositories/repository_impl.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

const _conversationsLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final RepositoryImpl _repository = RepositoryImpl();
  HubConnection? hubConnection;
  int currentPage = 1;

  ChatListBloc() : super(const ChatListState()) {
    on<ChatListFetched>(
      _onChatListFetched,
      transformer: throttleDroppable(throttleDuration),
    );

    on<ChatListRefresh>(
      _onChatListRefresh,
      transformer: throttleDroppable(throttleDuration),
    );

    on<OnStartNewChat>(
      _onStartNewChat,
      transformer: throttleDroppable(throttleDuration),
    );

    setupHubConnection();
  }

  Future<void> setupHubConnection() async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: "token") ?? "";

      hubConnection = HubConnectionBuilder()
          .withUrl(AppConstants.chatUrl,
              options: HttpConnectionOptions(
                accessTokenFactory: () => Future.value("Bearer $token"),
              ))
          .build();

      hubConnection?.on("ReceiveConversations", (args) async {
        if (hubConnection?.state == HubConnectionState.Connected) {
          add(ChatListRefresh());
        }
      });

      await hubConnection?.start();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onChatListFetched(
    ChatListFetched event,
    Emitter<ChatListState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == ChatListStatus.initial) {
        currentPage = 1;
        final chatList = await _fetchChatList();
        currentPage++;
        var hasMoreData = chatList.length == _conversationsLimit;

        if (chatList.isEmpty) {
          return emit(
            state.copyWith(
              status: ChatListStatus.empty,
              hasReachedMax: true,
            ),
          );
        }

        return emit(
          state.copyWith(
            status: ChatListStatus.success,
            chatList: chatList,
            hasReachedMax: !hasMoreData,
          ),
        );
      }

      final chatList = await _fetchChatList();
      currentPage++;
      final hasMoreData = chatList.length == _conversationsLimit;

      chatList.isEmpty
          ? emit(state.copyWith(
              status: ChatListStatus.success, hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ChatListStatus.success,
                chatList: List.of(state.chatList)..addAll(chatList),
                hasReachedMax: !hasMoreData,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: ChatListStatus.failure));
    }
  }

  Future<void> _onChatListRefresh(
    ChatListRefresh event,
    Emitter<ChatListState> emit,
  ) async {
    try {
      currentPage = 1;
      final chatList = await _fetchChatList();
      currentPage++;

      if (chatList.isEmpty) {
        return emit(
          state.copyWith(
            status: ChatListStatus.empty,
            hasReachedMax: true,
          ),
        );
      }
      final hasMoreData = chatList.length == _conversationsLimit;

      return emit(
        state.copyWith(
          status: ChatListStatus.success,
          chatList: chatList,
          hasReachedMax: !hasMoreData,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: ChatListStatus.failure));
    }
  }

  Future<void> _onStartNewChat(
    OnStartNewChat event,
    Emitter<ChatListState> emit,
  ) async {
    try {
      final chatList = await _fetchChatList();

      // Convert SearchUser to Conversation
      final newConversation = Conversation(
        id: event.user.id,
        name: "${event.user.firstName} ${event.user.lastName}",
        lastMessage: "Start chatting",
        // You can set an initial message if needed
        timeOfLastMessage: DateTime.now(),
        imageOfSender: event.user.imageUrl,
        senderId: event.user.id,
        numberOfUnread: 0,
      );

      // Add the newConversation to the top of the chatList
      chatList.insert(0, newConversation);

      var hasReachedMaxInternal = false;
      if (chatList.length < 10) {
        hasReachedMaxInternal = true;
      }
      return emit(
        state.copyWith(
          status: ChatListStatus.success,
          chatList: chatList,
          hasReachedMax: hasReachedMaxInternal,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: ChatListStatus.failure));
    }
  }

  Future<List<Conversation>> _fetchChatList() async {
    final response = await _repository.getConversations(currentPage, _conversationsLimit);
    if (response.items.isNotEmpty) {
      return response.items;
    } else {
      return [];
    }
    throw Exception('error fetching posts');
  }

  @override
  Future<void> close() {
    hubConnection?.stop();
    return super.close();
  }
}
