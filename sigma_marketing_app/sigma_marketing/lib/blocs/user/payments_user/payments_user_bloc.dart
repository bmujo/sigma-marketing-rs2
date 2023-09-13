import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/request/payment/paypal_email.dart';
import '../../../data/models/request/payment/withdraw.dart';
import '../../../data/models/response/payment_user/payment_user.dart';
import '../../../data/repositories/repository_impl.dart';

part 'payments_user_event.dart';
part 'payments_user_state.dart';

class PaymentsUserBloc extends Bloc<PaymentsUserEvent, PaymentsUserState> {
  final RepositoryImpl _repository = RepositoryImpl();

  PaymentsUserBloc() : super(PaymentsUserState()) {
    on<PaymentsFetched>(_onPaymentsFetched);
    on<WithdrawalRequested>(_onWithdrawalRequested);
    on<PaypalEmailUpdateEvent>(_onPaypalEmailUpdateEvent);
  }

  Future<void> _onPaymentsFetched(
      PaymentsFetched event,
      Emitter<PaymentsUserState> emit,
      ) async {
    try {
      emit(state.copyWith(status: PaymentsUserStatus.initial));

      final payments = await _fetchPayments();
      return emit(
        state.copyWith(
            status: PaymentsUserStatus.success,
            paymentUser: payments
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PaymentsUserStatus.failure));
    }
  }

  Future<void> _onWithdrawalRequested(
      WithdrawalRequested event,
      Emitter<PaymentsUserState> emit,
      ) async {
    try {
      emit(state.copyWith(status: PaymentsUserStatus.withdrawal));

      final payments = await _repository.withdraw(event.withdraw);
      return emit(
        state.copyWith(
            status: PaymentsUserStatus.withdrawalSuccess,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PaymentsUserStatus.withdrawalFailure));
    }
  }

  Future<void> _onPaypalEmailUpdateEvent(
      PaypalEmailUpdateEvent event,
      Emitter<PaymentsUserState> emit,
      ) async {
    try {
      emit(state.copyWith(status: PaymentsUserStatus.initial));

      final payments = await _repository.updatePaypalEmail(event.paypalEmail);
      return emit(
        state.copyWith(
          status: PaymentsUserStatus.success,
          paymentUser: payments,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PaymentsUserStatus.failure));
    }
  }

  Future<PaymentUser?> _fetchPayments() async {
    try {
      final response = await _repository.getPaymentsUser();
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
