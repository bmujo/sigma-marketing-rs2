import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/presentation/brand/screens/chat/widgets/search_users.dart';
import 'package:sigma_marketing/blocs/common/chat/search_users/search_users_bloc.dart';
import 'package:sigma_marketing/presentation/common/widgets/chat/item_chat.dart';

import '../../../../config/style/custom_text_style.dart';
import '../../../../data/models/response/chat/conversation.dart';
import '../../../../data/models/response/user/search_user.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../blocs/common/chat/chat_list/chat_list_bloc.dart';
import 'details/chat_details.dart';

class ChatDesktopScreen extends StatefulWidget {
  const ChatDesktopScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ChatDesktopScreen());
  }

  @override
  _ChatDesktopScreenState createState() => _ChatDesktopScreenState();
}

class _ChatDesktopScreenState extends State<ChatDesktopScreen> {
  Conversation? selectedConversation;
  late ChatListBloc chatListBloc;
  late SearchUsersBloc searchUsersBloc;

  @override
  void initState() {
    super.initState();
    chatListBloc = ChatListBloc();
    searchUsersBloc = SearchUsersBloc();

    chatListBloc.add(ChatListFetched());
  }

  @override
  void dispose() {
    chatListBloc.close();
    searchUsersBloc.close();
    super.dispose();
  }

  void onUserSelected(SearchUser selectedUser) {
    chatListBloc.add(OnStartNewChat(user: selectedUser));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: SMColors.secondMain, // Background color
                border: Border(
                  top: BorderSide(
                    color: SMColors.borderColor,
                    width: 1.0,
                  ),
                  left: BorderSide(
                    color: SMColors.borderColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                children: [
                  BlocProvider<SearchUsersBloc>.value(
                    value: searchUsersBloc,
                    child: SearchBarUsers(onUserSelected: onUserSelected),
                  ),
                  Expanded(
                    child: BlocProvider<ChatListBloc>.value(
                      value: chatListBloc,
                      child: ChatList(
                        onSelect: (index, conversation) {
                          setState(() {
                            selectedConversation = conversation;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              decoration: const BoxDecoration(
                color: SMColors.main, // Background color
                border: Border(
                  top: BorderSide(
                    color: SMColors.borderColor,
                    width: 1.0,
                  ),
                  left: BorderSide(
                    color: SMColors.borderColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: selectedConversation != null
                  ? ChatDetails(
                      conversation: selectedConversation!,
                      onDeselect: () {
                        setState(() {
                          selectedConversation = null;
                        });
                      },
                    )
                  : const Center(
                      child: Text(
                        'Select chat or start new chat',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatList extends StatefulWidget {
  final Conversation? selectedConversation;
  final void Function(int?, Conversation?)? onSelect;

  const ChatList({
    Key? key,
    this.selectedConversation,
    this.onSelect,
  }) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  int? selectedChatIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatListBloc, ChatListState>(
      builder: (context, state) {
        if (state.status == ChatListStatus.success) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.chatList.length,
            itemBuilder: (context, index) {
              final conversationItem = state.chatList[index];
              final isSelected = index == selectedChatIndex;

              return Container(
                padding: EdgeInsets.zero,
                color: isSelected ? SMColors.primaryColor : null,
                child: ItemChat(
                  index: index,
                  selectedChatIndex: selectedChatIndex,
                  conversationItem: conversationItem,
                  onSelect: (selectedIndex) {
                    setState(() {
                      selectedChatIndex = selectedIndex;
                    });
                    if (widget.onSelect != null) {
                      var index = selectedIndex != null
                          ? state.chatList[selectedIndex].id
                          : null;
                      var conversation = selectedIndex != null
                          ? state.chatList[selectedIndex]
                          : null;
                      widget.onSelect!(index, conversation);
                    }
                  },
                ),
              );
            },
          );
        } else if (state.status == ChatListStatus.failure) {
          return Center(
            child: Text('Error loading chat list',
                style: CustomTextStyle.semiBoldText(14)),
          );
        } else if (state.status == ChatListStatus.empty) {
          return Center(
            child: Text('No Conversations',
                style: CustomTextStyle.semiBoldText(14)),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
