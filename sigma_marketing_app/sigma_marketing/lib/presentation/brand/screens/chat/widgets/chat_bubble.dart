import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import '../../../model/message_model.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final double appWidth;

  const ChatBubble({required this.message, required this.appWidth});

  @override
  Widget build(BuildContext context) {
    final align = message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bgColor = message.isMe ? Colors.blue : Colors.grey;
    var maxBubbleWidth = appWidth * 0.4;
    if (maxBubbleWidth < 200) {
      maxBubbleWidth = 200;
    }

    final bubbleWidth = message.messageText.length > 20 ? maxBubbleWidth : null;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Container(
            width: bubbleWidth,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: message.isMe ? const Radius.circular(12) : Radius.zero,
                bottomRight: message.isMe ? Radius.zero : const Radius.circular(12),
              ),
            ),
            child: Text(
              message.messageText,
              style: CustomTextStyle.regularText(14),
            ),
          ),
        ],
      ),
    );
  }
}