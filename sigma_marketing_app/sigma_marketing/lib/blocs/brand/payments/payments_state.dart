part of '../../../../blocs/brand/payments/payments_bloc.dart';

enum PaymentsStatus { initial, success, failure}

class PaymentsState extends Equatable {
  PaymentsState({
    this.status = PaymentsStatus.initial,
    PaymentBrand? paymentBrand,
  }) : paymentBrand = paymentBrand ?? PaymentBrand.defaultBrand();

  final PaymentsStatus status;
  final PaymentBrand paymentBrand;

  PaymentsState copyWith({
    PaymentsStatus? status,
    PaymentBrand? paymentBrand,
  }) {
    return PaymentsState(
      status: status ?? this.status,
      paymentBrand: paymentBrand ?? this.paymentBrand,
    );
  }

  @override
  List<Object> get props => [status, paymentBrand];
}
