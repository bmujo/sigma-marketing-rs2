import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sigma_marketing/data/models/response/brand/campaign/campaign_brand.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../data/repositories/repository_impl.dart';

part 'campaigns_event.dart';
part 'campaigns_state.dart';

const _campaignsLimit = 10;
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

  CampaignsBloc() : super(CampaignsState()) {
    on<CampaignsFetched>(
      _onCampaignsFetched,
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
        final hasMoreData = campaigns.length == _campaignsLimit;

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
        final hasMoreData = campaigns.length == _campaignsLimit;

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

  Future<List<CampaignBrand>> _fetchCampaigns(String query, int page) async {
    try {
      var queryNullable = query.isEmpty ? null : query;
      final response =
          await _repository.getBrandCampaigns(queryNullable, page, _campaignsLimit);
      return response.items;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    throw Exception('error fetching campaigns');
  }
}
