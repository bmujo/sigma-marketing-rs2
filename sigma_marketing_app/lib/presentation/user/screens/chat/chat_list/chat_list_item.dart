import 'package:flutter/material.dart';

import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/response/chat/conversation.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../../utils/utils.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem(
      {super.key, required this.conversation, required this.onConversationTap});

  final Conversation conversation;
  final void Function() onConversationTap;

  @override
  Widget build(BuildContext context) {
    final lastMessageTextStyle = conversation.numberOfUnread > 0
        ? CustomTextStyle.semiBoldText(16, SMColors.white)
        : CustomTextStyle.regularText(16, SMColors.hintColor);

    return GestureDetector(
      onTap: onConversationTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: SMColors.secondMain,
          border: Border(
            bottom: BorderSide(
              color: SMColors.dividerColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(conversation.imageOfSender),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      conversation.name,
                      style: CustomTextStyle.semiBoldText(16),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        conversation.lastMessage,
                        style: lastMessageTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  formatDateTime(conversation.timeOfLastMessage),
                  style: lastMessageTextStyle,
                ),
                const SizedBox(height: 8),
                conversation.numberOfUnread > 0
                    ? Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: SMColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          conversation.numberOfUnread.toString(),
                          style: CustomTextStyle.semiBoldText(12),
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
