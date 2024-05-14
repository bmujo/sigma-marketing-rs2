import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/response/brand/campaign_details/campaign_details_brand.dart';
import '../../../data/repositories/repository_impl.dart';

part 'campaign_details_event.dart';
part 'campaign_details_state.dart';

class CampaignDetailsBloc
    extends Bloc<CampaignDetailsEvent, CampaignDetailsState> {
  final RepositoryImpl _repository = RepositoryImpl();

  CampaignDetailsBloc() : super(CampaignDetailsInitial()) {
    on<GetCampaignDetailsEvent>(
      _onGetCampaignDetailsEvent,
    );
  }

  Future<void> _onGetCampaignDetailsEvent(
      GetCampaignDetailsEvent event,
      Emitter<CampaignDetailsState> emit,
      ) async {
    try {
      final campaignDetails = await _repository.getCampaignByIdCompany(event.id);
      emit(CampaignDetailsLoaded(campaignDetails: campaignDetails));
    } catch (error) {
      emit(CampaignDetailsError(message: error.toString()));
    }
  }
}