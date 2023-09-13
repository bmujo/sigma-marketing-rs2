import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';
import 'dart:io';

WindowsNotification? _winNotifyPlugin;

void initializeDesktopPushNotifications() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    _winNotifyPlugin = WindowsNotification(
      applicationId: r"Sigma Marketing",
    );
    _winNotifyPlugin!.initNotificationCallBack(
      (notification, status, arguments) {
        print("args: $arguments");
      },
    );
  }
}

void sendDesktopNotification(String title, String content) {
  if (_winNotifyPlugin != null) {
    NotificationMessage message = NotificationMessage.fromPluginTemplate(
      title,
      title,
      content);
    _winNotifyPlugin!.showNotificationPluginTemplate(message);
  }
}
