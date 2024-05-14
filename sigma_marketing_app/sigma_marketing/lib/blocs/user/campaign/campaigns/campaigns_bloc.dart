import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../data/models/response/campaign/campaign.dart';
import '../../../../data/repositories/repository_impl.dart';

part 'campaigns_event.dart';
part 'campaigns_state.dart';

const _pageSize = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CampaignsBloc extends Bloc<CampaignsEvent, CampaignsState> {
  final RepositoryImpl _repository = RepositoryImpl();
  late String localQuery;
  int currentPage = 1;

  CampaignsBloc() : super(const CampaignsState()) {
    on<CampaignsFetched>(
      _onCampaignsFetched,
      transformer: throttleDroppable(throttleDuration),
    );

    on<ToggleLikeCampaign>(
      _onToggleLikeCampaign,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onCampaignsFetched(
      CampaignsFetched event,
      Emitter<CampaignsState> emit,
      ) async {
    if (state.hasReachedMax && event.query == localQuery) return;
    try {

      if (state.status == CampaignsStatus.initial ||
          localQuery != event.query) {
        localQuery = event.query;
        currentPage = 1;

        // Create a new list instead of clearing the existing one
        final campaigns = await _fetchCampaigns(localQuery, currentPage);

        currentPage++;
        final hasMoreData = campaigns.length == _pageSize;

        emit(
          state.copyWith(
            status: CampaignsStatus.success,
            campaigns: campaigns,
            hasReachedMax: !hasMoreData,
          ),
        );
      } else {
        final campaigns = await _fetchCampaigns(localQuery, currentPage);

        currentPage++;
        final hasMoreData = campaigns.length == _pageSize;

        emit(
          state.copyWith(
            status: CampaignsStatus.success,
            campaigns: state.campaigns + campaigns,
            hasReachedMax: !hasMoreData,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: CampaignsStatus.failure));
    }
  }

  Future<List<Campaign>> _fetchCampaigns(String query, int page) async {
    try {
      var queryNullable = query.isEmpty ? null : query;
      final response = await _repository.getAll(queryNullable, page, _pageSize);

      if (response.items.isNotEmpty) {
        return response.items;
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    throw Exception('error fetching posts');
  }

  Future<void> _onToggleLikeCampaign(
      ToggleLikeCampaign event, Emitter<CampaignsState> emit) async {
    try {
      final updatedCampaign = await _repository.toggleLikeCampaign(event.campaignId, event.liked);
      // find the index of the updated campaign in the state
      final index = state.campaigns
          .indexWhere((campaign) => campaign.id == updatedCampaign.id);
      if (index != -1) {
        final newCampaigns = List<Campaign>.of(state.campaigns);
        newCampaigns[index] = updatedCampaign;
        emit(state.copyWith(campaigns: newCampaigns));
      }
    } catch (_) {
      add(CampaignsFetched(query: localQuery));
    }
  }
}
