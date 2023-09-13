part of '../../../../blocs/user/notification/notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NotificationFetched extends NotificationEvent {}

class SetNotificationOpen extends NotificationEvent {
  final int notificationId;

  SetNotificationOpen({required this.notificationId});

  @override
  List<Object> get props => [notificationId];
}