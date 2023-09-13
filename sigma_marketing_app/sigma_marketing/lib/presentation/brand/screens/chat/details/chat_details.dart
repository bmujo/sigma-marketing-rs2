import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/data/models/response/chat/conversation.dart';

import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/request/chat/new_message.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../../blocs/common/chat/chat_details/chat_details_bloc.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_header.dart';

class ChatDetails extends StatefulWidget {
  final Conversation conversation;
  final VoidCallback onDeselect;

  ChatDetails({Key? key, required this.conversation, required this.onDeselect})
      : super(key: key);

  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  late ChatDetailsBloc _chatDetailsBloc;
  final _textController = TextEditingController();
  final _textFocusNode = FocusNode();

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _chatDetailsBloc =
        ChatDetailsBloc(receiverId: widget.conversation.senderId);
    _loadChatDetails();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadChatDetails();
      }
    });
  }

  @override
  void didUpdateWidget(covariant ChatDetails oldWidget) {
    if (widget.conversation.senderId != oldWidget.conversation.senderId) {
      _chatDetailsBloc.close();
      _chatDetailsBloc =
          ChatDetailsBloc(receiverId: widget.conversation.senderId);
      _loadChatDetails();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _chatDetailsBloc.close();
    _textController.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  void _loadChatDetails() {
    _chatDetailsBloc
        .add(ChatDetailsFetched(receiverId: widget.conversation.senderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SMColors.main,
      body: Column(
        children: [
          ChatHeader(conversation: widget.conversation),
          Expanded(
            child: BlocBuilder<ChatDetailsBloc, ChatDetailsState>(
              bloc: _chatDetailsBloc,
              builder: (context, state) {
                if (state.status == ChatDetailsStatus.success) {
                  final appWidth = MediaQuery.of(context).size.width;
                  return ListView.builder(
                    itemCount: state.messages.length,
                    reverse: true,
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      final message = state.messages[index];
                      return ChatBubble(message: message, appWidth: appWidth);
                    },
                  );
                } else if (state.status == ChatDetailsStatus.failure) {
                  return Center(
                    child: Text('Error loading chat details',
                        style: CustomTextStyle.semiBoldText(14)),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Container _buildChatInput() {
    return Container(
        decoration: const BoxDecoration(
          color: SMColors.main, // Background color
          border: Border(
            top: BorderSide(
              color: SMColors.borderColor,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 24),
              child: Image(
                image: AssetImage('assets/ic_emoji.png'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 12, bottom: 12, left: 12, right: 12),
                child: TextField(
                  controller: _textController,
                  onSubmitted: (value) => sendMessage(),
                  focusNode: _textFocusNode,
                  style: CustomTextStyle.regularText(14),
                  decoration: InputDecoration(
                    fillColor: SMColors.inputDarkColor,
                    filled: true,
                    hintText: 'Type a message',
                    hintStyle: CustomTextStyle.regularText(14, SMColors.hintColor),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 50,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 24),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SMColors.main,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () => {sendMessage()},
                    child: const Image(
                      image: AssetImage('assets/ic_send.png'),
                    ))),
          ],
        ));
  }

  void sendMessage() {
    if (_textController.text.isNotEmpty) {
      NewMessage newMessage = NewMessage(
          receiverId: widget.conversation.senderId,
          messageText: _textController.text);

      _chatDetailsBloc.add(ChatDetailsSend(newMessage: newMessage));
      _textController.clear();
      _textFocusNode.requestFocus();
    }
  }
}
