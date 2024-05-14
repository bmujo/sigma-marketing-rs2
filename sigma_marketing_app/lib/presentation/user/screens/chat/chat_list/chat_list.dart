import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import '../../../../../data/models/response/user/search_user.dart';
import '../../../../../blocs/common/chat/chat_list/chat_list_bloc.dart';
import '../../../../common/widgets/bottom_loader/bottom_loader.dart';
import '../chat_details/chat_details_screen.dart';
import 'chat_list_item.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final infoStyle = CustomTextStyle.semiBoldText(14);

    return BlocBuilder<ChatListBloc, ChatListState>(
      builder: (context, state) {
        switch (state.status) {
          case ChatListStatus.failure:
            return Center(
                child: Text('Failed to fetch conversations', style: infoStyle));
          case ChatListStatus.empty:
            return Center(
                child:
                    Text('No conversations, start new chat', style: infoStyle));
          case ChatListStatus.success:
            if (state.chatList.isEmpty) {
              return Center(
                  child: Text('No Conversations, start new chat',
                      style: infoStyle));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (!state.hasReachedMax &&
                    index >= state.chatList.length - 1) {
                  return const BottomLoader();
                }
                return ChatListItem(
                    conversation: state.chatList[index],
                    onConversationTap: () {
                      _navigateToChatDetails(state, index, context);
                    });
              },
              itemCount: state.hasReachedMax
                  ? state.chatList.length
                  : state.chatList.length + 1,
              controller: _scrollController,
            );
          case ChatListStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _navigateToChatDetails(
      ChatListState state, int index, BuildContext context) {
    SearchUser user = SearchUser(
      id: state.chatList[index].senderId,
      imageUrl: state.chatList[index].imageOfSender,
      firstName: state.chatList[index].name,
      lastName: "",
    );
    // navigate with animation to chat screen
    Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ChatDetailsScreen(
                user: user,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = const Offset(1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ))
        .then((value) => {context.read<ChatListBloc>().add(ChatListRefresh())});
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ChatListBloc>().add(ChatListFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
