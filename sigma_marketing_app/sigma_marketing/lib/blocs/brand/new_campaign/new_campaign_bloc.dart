import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sigma_marketing/data/models/request/brand/new_campaign/new_campaign.dart';

import '../../../data/models/response/new_campaign/campaign_create_data.dart';
import '../../../data/repositories/repository_impl.dart';

part 'new_campaign_event.dart';
part 'new_campaign_state.dart';

class NewCampaignBloc extends Bloc<NewCampaignEvent, NewCampaignState> {
  final RepositoryImpl _repository = RepositoryImpl();

  NewCampaignBloc() : super(const NewCampaignState()) {
    on<CreateCampaign>(_onCreateCampaign);
    on<GetCampaignCreateData>(_onGetCampaignCreateData);
  }

  Future<void> _onGetCampaignCreateData(
      GetCampaignCreateData event, Emitter<NewCampaignState> emit) async {
    try {
      final campaignCreateData = await _repository.getCampaignCreateData();

      emit(state.copyWith(
          status: NewCampaignStatus.success,
          campaignCreateData: campaignCreateData));
    } catch (_) {
      emit(state.copyWith(status: NewCampaignStatus.failure));
    }
  }

  Future<void> _onCreateCampaign(
      CreateCampaign event, Emitter<NewCampaignState> emit) async {
    try {
      final isCreated =
          await _repository.createCampaign(event.newCampaignRequest);

      if (isCreated == "") {
        emit(state.copyWith(status: NewCampaignStatus.success));
      } else {
        emit(state.copyWith(status: NewCampaignStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(status: NewCampaignStatus.failure));
    }
  }
}
