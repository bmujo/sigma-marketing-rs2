import 'package:flutter/material.dart';

import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/response/chat/conversation.dart';
import '../../../../../utils/colors/colors.dart';

class ChatHeader extends StatelessWidget {
  final Conversation conversation;

  const ChatHeader({Key? key, required this.conversation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: SMColors.secondMain,
        border: Border(
          left: BorderSide(
            color: SMColors.white,
            width: 2.0,
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            child: Image.network(conversation.imageOfSender),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(conversation.name, style: CustomTextStyle.semiBoldText(18)),
              const SizedBox(height: 4),
              Text(
                'online',
                style: CustomTextStyle.regularText(14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
