import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sigma_marketing/data/models/response/payments/payment_brand.dart';

import '../../../data/repositories/repository_impl.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final RepositoryImpl _repository = RepositoryImpl();

  PaymentsBloc() : super(PaymentsState()) {
    on<PaymentsFetched>(_onPaymentsFetched);
  }

  Future<void> _onPaymentsFetched(
      PaymentsFetched event,
      Emitter<PaymentsState> emit,
      ) async {
    try {
      emit(state.copyWith(status: PaymentsStatus.initial));

      final payments = await _fetchPayments();
      return emit(
        state.copyWith(
            status: PaymentsStatus.success,
            paymentBrand: payments
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PaymentsStatus.failure));
    }
  }


  Future<PaymentBrand?> _fetchPayments() async {
    try {
      final response = await _repository.getPaymentsBrand();
      if (response != null) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('error fetching sigma tokens');
    }
  }
}