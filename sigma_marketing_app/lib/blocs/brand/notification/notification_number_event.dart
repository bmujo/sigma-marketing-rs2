part of 'notification_number_bloc.dart';

abstract class NotificationNumberEvent extends Equatable {
  const NotificationNumberEvent();
}

class NotificationNumberFetched extends NotificationNumberEvent {
  @override
  List<Object> get props => [];
}
