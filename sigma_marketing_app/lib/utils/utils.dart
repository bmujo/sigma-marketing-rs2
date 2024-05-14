import 'dart:ui';
import 'package:intl/intl.dart';
import 'colors/colors.dart';

Color getColorForUserStatus(int state) {
  switch (state) {
    case 0:
      return SMColors.userStatusInitial;
    case 1:
      return SMColors.userStatusRequested;
    case 2:
      return SMColors.userStatusInReview;
    case 3:
      return SMColors.userStatusAccepted;
    case 4:
      return SMColors.userStatusInProgress;
    case 5:
      return SMColors.userStatusFinalReview;
    case 6:
      return SMColors.userStatusCompleted;
    case 7:
      return SMColors.userStatusDenied;
    case 8:
      return SMColors.userStatusInvited;
    default:
      return SMColors.userStatusInitial;
  }
}

String getLabelForUserStatus(int state) {
  switch (state) {
    case 0:
      return 'Initial';
    case 1:
      return 'Requested';
    case 2:
      return 'In Review';
    case 3:
      return 'Accepted';
    case 4:
      return 'In Progress';
    case 5:
      return 'Final Review';
    case 6:
      return 'Completed';
    case 7:
      return 'Denied';
    case 8:
      return 'Invited';
    default:
      return 'Initial';
  }
}

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

  if (aDate == DateTime(now.year, now.month, now.day)) {
    // Today: Show only hour and minute
    return DateFormat.Hm().format(dateTime);
  } else if (aDate == yesterday) {
    // Yesterday: Show "Yesterday"
    return 'Yesterday';
  } else {
    // Older: Show date with day and month
    return DateFormat('d MMM').format(dateTime);
  }
}

String getNotificationImage(int type) {
  switch (type) {
    case 0:
      return "assets/notif_message.png";
    case 1:
      return "assets/notif_status.png";
    case 2:
      return "assets/notif_done.png";
    case 3:
      return "assets/notif_finished.png";
    case 4:
      return "assets/notif_payment.png";
    default:
      return "assets/notif_status.png";
  }
}