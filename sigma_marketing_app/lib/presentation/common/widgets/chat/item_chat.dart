import 'package:flutter/material.dart';
import 'package:sigma_marketing/data/models/response/chat/conversation.dart';

import '../../../../config/style/custom_text_style.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/utils.dart';

class ItemChat extends StatefulWidget {
  final int? index;
  final int? selectedChatIndex;
  final Conversation conversationItem;
  final ValueSetter<int?> onSelect;

  const ItemChat({
    Key? key,
    required this.index,
    required this.selectedChatIndex,
    required this.conversationItem,
    required this.onSelect,
  }) : super(key: key);

  @override
  _ItemChatState createState() => _ItemChatState();
}

class _ItemChatState extends State<ItemChat> {

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.index == widget.selectedChatIndex;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
        onTap: () {
          if (isSelected) {
            widget.onSelect(null);
          } else {
            widget.onSelect(widget.index);
          }
        },
        child: Container(
          padding: const EdgeInsets.only(left: 12, top: 12),
          child: Column(
            children: [
              Row(
                children: [
                  _buildAvatar(),
                  const SizedBox(width: 16),
                  _buildNameAndMessage(),
                  _buildTimeAndUnread(),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 12),
                child: const Divider(
                  color: SMColors.dividerColor,
                  indent: 46,
                  endIndent: 0,
                  height: 1,
                ),
              ),
            ],
          ),
        ));
  }

  Expanded _buildTimeAndUnread() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              formatDateTime(widget.conversationItem.timeOfLastMessage),
              style: CustomTextStyle.regularText(12),
            ),
            const SizedBox(height: 9),
            widget.conversationItem.numberOfUnread > 0
                ? Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: SMColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        widget.conversationItem.numberOfUnread.toString(),
                        style: CustomTextStyle.regularText(12),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Expanded _buildNameAndMessage() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.conversationItem.name,
            style: CustomTextStyle.semiBoldText(14),
          ),
          const SizedBox(height: 9),
          Text(
            widget.conversationItem.lastMessage,
            style: CustomTextStyle.regularText(12),
          ),
        ],
      ),
    );
  }

  CircleAvatar _buildAvatar() {
    return CircleAvatar(
      radius: 16,
      child: Image.network(widget.conversationItem.imageOfSender),
    );
  }
}
