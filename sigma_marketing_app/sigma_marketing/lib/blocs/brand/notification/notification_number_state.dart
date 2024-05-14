part of '../../../../blocs/brand/notification/notification_number_bloc.dart';

abstract class NotificationNumberState extends Equatable {
  const NotificationNumberState();
}

class NotificationNumberInitial extends NotificationNumberState {
  @override
  List<Object> get props => [];
}

class NotificationNumberLoaded extends NotificationNumberState {
  final int numberNotifications;

  const NotificationNumberLoaded({
    required this.numberNotifications,
  });

  @override
  List<Object> get props => [numberNotifications];
}
