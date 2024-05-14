part of 'payments_user_bloc.dart';

abstract class PaymentsUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PaymentsFetched extends PaymentsUserEvent {}

class WithdrawalRequested extends PaymentsUserEvent {
  final Withdraw withdraw;

  WithdrawalRequested(this.withdraw);

  @override
  List<Object> get props => [withdraw];
}

class PaypalEmailUpdateEvent extends PaymentsUserEvent {
  final PaypalEmail paypalEmail;

  PaypalEmailUpdateEvent(this.paypalEmail);

  @override
  List<Object> get props => [paypalEmail];
}