part of '../../../../blocs/brand/sigma_tokens/sigma_tokens_bloc.dart';

abstract class SigmaTokensEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SigmaTokensFetched extends SigmaTokensEvent {}

class PurchaseTokensEvent extends SigmaTokensEvent {
  final Purchase purchase;

  PurchaseTokensEvent({required this.purchase});

  @override
  List<Object> get props => [purchase];
}