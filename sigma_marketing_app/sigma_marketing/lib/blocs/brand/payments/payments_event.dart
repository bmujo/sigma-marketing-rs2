part of '../../../../blocs/brand/payments/payments_bloc.dart';

abstract class PaymentsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PaymentsFetched extends PaymentsEvent {}

