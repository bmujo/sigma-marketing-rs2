part of 'sigma_tokens_bloc.dart';

enum SigmaTokensStatus { initial, success, failure, purchasing, purchased, purchasedFailure }

class SigmaTokensState extends Equatable {
  const SigmaTokensState({
    this.status = SigmaTokensStatus.initial,
    this.sigmaTokens = const <SigmaTokenModel>[],
  });

  final SigmaTokensStatus status;
  final List<SigmaTokenModel> sigmaTokens;

  SigmaTokensState copyWith({
    SigmaTokensStatus? status,
    List<SigmaTokenModel>? sigmaTokens,
  }) {
    return SigmaTokensState(
      status: status ?? this.status,
      sigmaTokens: sigmaTokens ?? this.sigmaTokens,
    );
  }

  @override
  List<Object> get props => [status, sigmaTokens];
}
