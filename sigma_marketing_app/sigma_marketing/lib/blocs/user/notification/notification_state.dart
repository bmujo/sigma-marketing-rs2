part of 'notification_bloc.dart';

enum NotificationStatus { initial, success, failure }

class NotificationState extends Equatable {
  const NotificationState({
    this.status = NotificationStatus.initial,
    this.notifications = const <NotificationSigma>[],
    this.hasReachedMax = false,
  });

  final NotificationStatus status;
  final List<NotificationSigma> notifications;
  final bool hasReachedMax;

  NotificationState copyWith({
    NotificationStatus? status,
    List<NotificationSigma>? notifications,
    bool? hasReachedMax,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, notifications, hasReachedMax];
}
