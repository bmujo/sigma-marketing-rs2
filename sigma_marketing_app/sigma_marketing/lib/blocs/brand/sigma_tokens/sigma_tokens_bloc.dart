import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sigma_marketing/data/models/request/payment/purchase.dart';
import 'package:sigma_marketing/data/models/response/sigma_token/sigma_token.dart';
import 'package:uuid/uuid.dart';

import '../../../data/repositories/repository_impl.dart';
import '../../../services/paypal_service.dart';
import '../../../presentation/brand/model/sigma_token_model.dart';

part 'sigma_tokens_event.dart';
part 'sigma_tokens_state.dart';

class SigmaTokensBloc extends Bloc<SigmaTokensEvent, SigmaTokensState> {
  final RepositoryImpl _repository = RepositoryImpl();
  final PaypalService services = PaypalService();

  SigmaTokensBloc() : super(const SigmaTokensState()) {
    on<SigmaTokensFetched>(_onSigmaTokensFetched);
    on<PurchaseTokensEvent>(_onPurchaseTokens);
  }

  Future<void> _onSigmaTokensFetched(
    SigmaTokensFetched event,
    Emitter<SigmaTokensState> emit,
  ) async {
    try {
      if (state.status == SigmaTokensStatus.initial) {
        final sigmaTokens = await _fetchSigmaTokens();
        return emit(
          state.copyWith(
            status: SigmaTokensStatus.success,
            sigmaTokens: sigmaTokens,
          ),
        );
      }
      final sigmaTokens = await _fetchSigmaTokens();
      sigmaTokens.isEmpty
          ? emit(state.copyWith())
          : emit(
              state.copyWith(
                status: SigmaTokensStatus.success,
                sigmaTokens: List.of(state.sigmaTokens)..addAll(sigmaTokens),
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: SigmaTokensStatus.failure));
    }
  }

  Future<void> _onPurchaseTokens(
      PurchaseTokensEvent event,
      Emitter<SigmaTokensState> emit,
      ) async {
    try {
      emit(state.copyWith(status: SigmaTokensStatus.purchasing));

      final response = await _repository.purchaseTokens(event.purchase);
      if (response) {
        emit(state.copyWith(status: SigmaTokensStatus.purchased));
      } else {
        emit(state.copyWith(status: SigmaTokensStatus.purchasedFailure));
      }
    } catch (_) {
      emit(state.copyWith(status: SigmaTokensStatus.purchasedFailure));
    }
  }

  Future<List<SigmaTokenModel>> _fetchSigmaTokens() async {
    try {
      final response = await _repository.getSigmaTokensPackages();
      if (response.isNotEmpty) {
        final List<SigmaTokenModel> sigmaTokensModel = [];

        final accessToken = (await services.getAccessToken())!;

        for (final e in response) {
          final transactions = getOrderParams(e);
          final res =
              await services.createPaypalOrder(transactions, accessToken);

          final sigmaToken = SigmaTokenModel(
            id: e.id,
            packageName: e.packageName,
            price: e.price,
            amount: e.amount,
            isSelected: false,
            checkoutUrl: res?["executeUrl"] ?? '',
            executeUrl: res?["approvalUrl"] ?? '',
            accessToken: accessToken,
            package: transactions
          );

          sigmaTokensModel.add(sigmaToken);
        }

        if (sigmaTokensModel.isNotEmpty) {
          sigmaTokensModel[0].isSelected = true;
        }

        return sigmaTokensModel;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('error fetching sigma tokens');
    }
  }

  Map<String, dynamic> getOrderParams(SigmaToken sigmaToken) {
    final price = sigmaToken.price.toStringAsFixed(1);
    final name = sigmaToken.packageName;
    final referenceId = generateReferenceId();

    Map<String, dynamic> temp = {
      "intent": "CAPTURE",
      "application_context": {
        "user_action": "PAY_NOW",
        "return_url": "https://youtube.com",
        "cancel_url": "https://www.youtube.com/watch?v=w3HC1dkkqnY"
      },
      "purchase_units": [
        {
          "reference_id": referenceId,
          "amount": {
            "currency_code": "USD",
            "value": price,
            "breakdown": {
              "item_total": {"currency_code": "USD", "value": price},
              "tax_total": {"value": "0.0", "currency_code": "USD"}
            }
          },
          "items": [
            {
              "name": name,
              "description": name,
              "unit_amount": {"currency_code": "USD", "value": price},
              "tax": {"value": "0.0", "currency_code": "USD"},
              "quantity": "1"
            }
          ]
        }
      ],
    };
    return temp;
  }

  String generateReferenceId() {
    final Uuid uuid = Uuid();
    return uuid.v4(); // Generates a version 4 (random) UUID
  }
}
