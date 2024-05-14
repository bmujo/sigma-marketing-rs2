import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:sigma_marketing/data/models/request/brand/campaign_analytics/campaign_analytics_request.dart';
import 'package:sigma_marketing/data/models/response/brand/campaign_analytics/campaign_analytics.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../data/models/response/brand/campaign_analytics/campaign_analytics_item.dart';
import '../../../data/repositories/repository_impl.dart';

part 'campaign_analytics_event.dart';
part 'campaign_analytics_state.dart';

const _postLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CampaignAnalyticsBloc
    extends Bloc<CampaignAnalyticsEvent, CampaignAnalyticsState> {
  final RepositoryImpl _repository = RepositoryImpl();

  CampaignAnalyticsRequest campaignAnalyticsRequest = CampaignAnalyticsRequest(
    startDate: DateTime(2000, 1, 1),
    endDate: DateTime(2030, 1, 31),
    statuses: null,
    platforms: null,
    tags: null,
    page: 1,
    pageSize: 10,
  );

  bool filterApplied = false;

  CampaignAnalyticsBloc() : super(CampaignAnalyticsState()) {
    on<CampaignAnalyticsFetched>(
      _onCampaignAnalyticsFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onCampaignAnalyticsFetched(
    CampaignAnalyticsFetched event,
    Emitter<CampaignAnalyticsState> emit,
  ) async {
    if (state.hasReachedMax && !filterApplied) return;
    try {
      filterApplied = false;
      if (state.status == CampaignAnalyticsStatus.initial) {
        campaignAnalyticsRequest.page = 1;

        // Create a new list instead of clearing the existing one
        final campaignAnalytics =
            await _fetchCampaignAnalytics();

        campaignAnalyticsRequest.page++;
        final hasMoreData =
            campaignAnalytics.campaignsList.items.length == _postLimit;

        emit(
          state.copyWith(
            status: CampaignAnalyticsStatus.success,
            campaignAnalytics: campaignAnalytics,
            campaigns: campaignAnalytics.campaignsList.items,
            hasReachedMax: !hasMoreData,
          ),
        );
      } else {
        final campaignAnalytics =
            await _fetchCampaignAnalytics();

        campaignAnalyticsRequest.page++;
        final hasMoreData =
            campaignAnalytics.campaignsList.items.length == _postLimit;

        emit(
          state.copyWith(
            status: CampaignAnalyticsStatus.success,
            campaignAnalytics: campaignAnalytics,
            campaigns: state.campaigns + campaignAnalytics.campaignsList.items,
            hasReachedMax: !hasMoreData,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: CampaignAnalyticsStatus.failure));
    }
  }

  Future<CampaignAnalytics> _fetchCampaignAnalytics() async {
    try {
      final response =
          await _repository.getCampaignsAnalytics(campaignAnalyticsRequest);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    throw Exception('error fetching campaigns');
  }

  void clearFilters() {
    campaignAnalyticsRequest = CampaignAnalyticsRequest(
      startDate: DateTime(2000, 1, 1),
      endDate: DateTime(2030, 1, 31),
      statuses: null,
      platforms: null,
      tags: null,
      page: 1,
      pageSize: 10,
    );
    filterApplied = true;
  }

  void addStartDateFilter(DateTime startDate) {
    campaignAnalyticsRequest.startDate = startDate;
  }

  void addEndDateFilter(DateTime endDate) {
    campaignAnalyticsRequest.endDate = endDate;
  }

  void addStatusesFilter(List<int> statuses) {
    campaignAnalyticsRequest.statuses = statuses;
  }

  void addPlatformsFilter(List<int> platforms) {
    campaignAnalyticsRequest.platforms = platforms;
  }

  void addTagsFilter(List<int> tags) {
    campaignAnalyticsRequest.tags = tags;
  }

  void applyFilters() {
    filterApplied = true;
    campaignAnalyticsRequest.page = 1;
  }
}
