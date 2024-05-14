import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sigma_marketing/data/models/request/campaign/campaign_state.dart';
import '../../../../data/models/request/campaign/complete_campaign.dart';
import '../../../../data/models/response/campaign/campaign_details.dart';
import '../../../../data/repositories/repository_impl.dart';

part 'campaign_details_event.dart';
part 'campaign_details_state.dart';

class CampaignDetailsBloc
    extends Bloc<CampaignDetailsEvent, CampaignDetailsState> {
  final RepositoryImpl _repository = RepositoryImpl();

  CampaignDetailsBloc() : super(CampaignDetailsInitial()) {
    on<GetCampaignDetailsEvent>(
      _onGetCampaignDetailsEvent,
    );

    on<OnCampaignUpdateEvent>(
      _onCampaignUpdateEvent,
    );
  }

  Future<void> _onGetCampaignDetailsEvent(
      GetCampaignDetailsEvent event,
      Emitter<CampaignDetailsState> emit,
      ) async {
    try {
      final campaignDetails = await _repository.getCampaignDetails(event.id);
      emit(CampaignDetailsLoaded(campaignDetails: campaignDetails));
    } catch (error) {
      emit(CampaignDetailsError(message: error.toString()));
    }
  }

  Future<void> _onCampaignUpdateEvent(
      OnCampaignUpdateEvent event,
      Emitter<CampaignDetailsState> emit,
      ) async {
    try {
      final campaignDetails = await _repository.updateCampaign(event.campaignState);
      emit(CampaignDetailsLoaded(campaignDetails: campaignDetails));
    } catch (error) {
      emit(CampaignDetailsError(message: error.toString()));
    }
  }
}
