part of 'payments_user_bloc.dart';

enum PaymentsUserStatus { initial, success, failure, withdrawal, withdrawalSuccess, withdrawalFailure }

class PaymentsUserState extends Equatable {
  PaymentsUserState({
    this.status = PaymentsUserStatus.initial,
    PaymentUser? paymentUser,
  }) : paymentUser = paymentUser ?? PaymentUser.defaultPaymentUser();

  final PaymentsUserStatus status;
  final PaymentUser paymentUser;

  PaymentsUserState copyWith({
    PaymentsUserStatus? status,
    PaymentUser? paymentUser,
  }) {
    return PaymentsUserState(
      status: status ?? this.status,
      paymentUser: paymentUser ?? this.paymentUser,
    );
  }

  @override
  List<Object> get props => [status, paymentUser];
}
