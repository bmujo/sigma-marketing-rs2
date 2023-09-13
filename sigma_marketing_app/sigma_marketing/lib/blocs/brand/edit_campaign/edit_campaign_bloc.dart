import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/request/payment/transfer.dart';
import '../../../data/models/response/brand/campaign_details/campaign_details_brand.dart';
import '../../../data/repositories/repository_impl.dart';

part 'edit_campaign_event.dart';
part 'edit_campaign_state.dart';

class EditCampaignBloc
    extends Bloc<EditCampaignEvent, EditCampaignState> {
  final RepositoryImpl _repository = RepositoryImpl();

  EditCampaignBloc() : super(CampaignDetailsInitial()) {
    on<GetCampaignDetailsEvent>(
      _onGetCampaignDetailsEvent,
    );

    on<OnAcceptInfluencer>(
      _onAcceptInfluencer,
    );

    on<OnRejectInfluencer>(
      _onRejectInfluencer,
    );

    on<OnPayInfluencer>(
      _onPayInfluencer,
    );
  }

  Future<void> _onGetCampaignDetailsEvent(
      GetCampaignDetailsEvent event,
      Emitter<EditCampaignState> emit,
      ) async {
    try {
      final campaignDetails = await _repository.getCampaignByIdCompany(event.id);
      emit(CampaignDetailsLoaded(campaignDetails: campaignDetails));
    } catch (error) {
      emit(CampaignDetailsError(message: error.toString()));
    }
  }

  Future<void> _onAcceptInfluencer(
      OnAcceptInfluencer event,
      Emitter<EditCampaignState> emit,
      ) async {
    try {
      final campaignDetails = await _repository.acceptUser(event.campaignId, event.influencerId);
      emit(CampaignDetailsLoaded(campaignDetails: campaignDetails));
    } catch (error) {
      emit(CampaignDetailsError(message: error.toString()));
    }
  }

  Future<void> _onRejectInfluencer(
      OnRejectInfluencer event,
      Emitter<EditCampaignState> emit,
      ) async {
    try {
      final campaignDetails = await _repository.declineUser(event.campaignId, event.influencerId);
      emit(CampaignDetailsLoaded(campaignDetails: campaignDetails));
    } catch (error) {
      emit(CampaignDetailsError(message: error.toString()));
    }
  }

  Future<void> _onPayInfluencer(
      OnPayInfluencer event,
      Emitter<EditCampaignState> emit,
      ) async {
    try {
      final transfer = Transfer(
        campaignId: event.campaignId,
        influencerId: event.influencerId,
      );

      final campaignDetails = await _repository.payout(transfer);
      emit(CampaignDetailsLoaded(campaignDetails: campaignDetails));
    } catch (error) {
      emit(CampaignDetailsError(message: error.toString()));
    }
  }
}
