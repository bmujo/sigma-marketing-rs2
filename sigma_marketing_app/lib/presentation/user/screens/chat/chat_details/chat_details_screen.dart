import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:sigma_marketing/presentation/brand/model/message_model.dart';

import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/request/chat/new_message.dart';
import '../../../../../data/models/response/user/search_user.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../../blocs/common/chat/chat_details/chat_details_bloc.dart';

class ChatDetailsScreen extends StatefulWidget {
  final SearchUser user;

  const ChatDetailsScreen({super.key, required this.user});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController _textController = TextEditingController();
  final storage = const FlutterSecureStorage();
  String? myUserId;

  late ScrollController _scrollController;
  late ChatDetailsBloc _chatDetailsBloc;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _chatDetailsBloc = ChatDetailsBloc(receiverId: widget.user.id);
    _loadChatDetails();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadChatDetails();
      }
    });
    getUserId();
  }

  @override
  void dispose() {
    _chatDetailsBloc.close();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadChatDetails() {
    _chatDetailsBloc.add(ChatDetailsFetched(receiverId: widget.user.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _chatDetailsBloc
          ..add(ChatDetailsFetched(receiverId: widget.user.id)),
        child: BlocBuilder<ChatDetailsBloc, ChatDetailsState>(
            builder: (context, state) {
          switch (state.status) {
            case ChatDetailsStatus.failure:
              return _buildErrorState(context);
            case ChatDetailsStatus.success:
              if (state.messages.isEmpty) {
                return _buildInitialState(context);
              }

              return Scaffold(
                backgroundColor: SMColors.main,
                appBar: _chatDetailsAppBar(context),
                body: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                        itemCount: state.messages.length,
                        reverse: true,
                        controller: _scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          final message = state.messages[index];
                          return _buildMessage(message, myUserId);
                        },
                      )),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _buildChatInput(context),
                      ),
                    ],
                  ),
                ),
              );
            case ChatDetailsStatus.initial:
              return _buildLoadingState(context);
          }
        }));
  }

  SafeArea _buildInitialState(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SMColors.main,
        appBar: _chatDetailsAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                  child: Center(
                      child: Text('Start a conversation',
                          style: CustomTextStyle.semiBoldText(14)))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _buildChatInput(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: SMColors.main,
      appBar: _chatDetailsAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
            child: Text('Failed to fetch messages',
                style: CustomTextStyle.semiBoldText(14))),
      ),
    ));
  }

  Widget _buildLoadingState(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SMColors.main,
        appBar: _chatDetailsAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Expanded(child: Center(child: CircularProgressIndicator())),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _buildChatInput(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildChatInput(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textController,
            style: CustomTextStyle.regularText(14),
            decoration: InputDecoration(
              filled: true,
              fillColor: SMColors.secondMain,
              hintText: 'Type a message',
              hintStyle: CustomTextStyle.regularText(14, SMColors.hintColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        FloatingActionButton(
          onPressed: () {
            if (_textController.text.isNotEmpty) {
              NewMessage newMessage = NewMessage(
                  receiverId: widget.user.id,
                  messageText: _textController.text);

              context
                  .read<ChatDetailsBloc>()
                  .add(ChatDetailsSend(newMessage: newMessage));
              _textController.clear();
            }
          },
          backgroundColor: SMColors.primaryColor,
          mini: true,
          child: const Icon(Icons.send),
        ),
      ],
    );
  }

  AppBar _chatDetailsAppBar(BuildContext context) {
    final fullName = '${widget.user.firstName} ${widget.user.lastName}';
    return AppBar(
      backgroundColor: SMColors.secondMain,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.user.imageUrl),
          ),
          const SizedBox(width: 16),
          Text(fullName, style: CustomTextStyle.regularText(14)),
        ],
      ),
      leading: IconButton(
        icon: const IconTheme(
          data: IconThemeData(color: SMColors.white),
          child: BackButtonIcon(),
        ),
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  void getUserId() {
    storage.read(key: "userId").then((value) {
      myUserId = value;
    });
  }

  Widget _buildMessage(MessageModel message, String? myUserId) {
    final Row sentMessage = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: 25,
              right: 20,
            ),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: const BoxDecoration(
              color: SMColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(19),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(19),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.messageText,
                  style: CustomTextStyle.regularText(16),
                ),
                const SizedBox(height: 10),
                Text(
                  DateFormat.Hms().format(message.created),
                  style: CustomTextStyle.regularText(
                      10, SMColors.white.withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ),
        CustomPaint(painter: Triangle(SMColors.primaryColor)),
      ],
    );

    final Row receivedMessage = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: CustomPaint(
            painter: Triangle(Colors.grey.shade300),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: 20,
              right: 25,
            ),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(19),
                bottomLeft: Radius.circular(19),
                bottomRight: Radius.circular(19),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.messageText,
                  style: CustomTextStyle.regularText(16, SMColors.darkBlack),
                ),
                const SizedBox(height: 10),
                Text(
                  DateFormat.Hms().format(message.created),
                  style: CustomTextStyle.regularText(
                      10, SMColors.darkBlack.withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    if (message.messageOwnerId.toString() == myUserId) {
      return sentMessage;
    }

    return receivedMessage;
  }
}

// Create a custom triangle
class Triangle extends CustomPainter {
  final Color backgroundColor;

  Triangle(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = backgroundColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
