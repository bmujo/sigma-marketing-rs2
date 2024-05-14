import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';

import '../../../../data/models/response/notification/notification_sigma.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/utils.dart';

class ItemNotification extends StatefulWidget {
  final NotificationSigma notification;
  final void Function() onNotificationTap;

  const ItemNotification(
      {super.key, required this.notification, required this.onNotificationTap});

  @override
  _ItemNotificationState createState() => _ItemNotificationState();
}

class _ItemNotificationState extends State<ItemNotification> {
  String imageUrl = "";
  String formatedDateTime = "";

  @override
  void initState() {
    super.initState();
    imageUrl = getNotificationImage(widget.notification.type);
    formatedDateTime = formatDateTime(widget.notification.created);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onNotificationTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: SMColors.borderColor,
                width: 1.0,
              ),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Image(image: AssetImage(imageUrl)),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.notification.title,
                            style: CustomTextStyle.boldText(14)),
                        const SizedBox(height: 8),
                        Text(
                          formatedDateTime,
                          style: CustomTextStyle.regularText(12),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !widget.notification.isOpen,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: SMColors.notifNew,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "NEW",
                        style: CustomTextStyle.mediumText(12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.notification.message,
                style: CustomTextStyle.regularText(14),
              ),
            ],
          ),
        ));
  }
}
