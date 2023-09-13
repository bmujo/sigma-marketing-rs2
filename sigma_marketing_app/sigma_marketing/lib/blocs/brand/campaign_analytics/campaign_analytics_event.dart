part of '../../../../blocs/brand/campaign_analytics/campaign_analytics_bloc.dart';

abstract class CampaignAnalyticsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CampaignAnalyticsFetched extends CampaignAnalyticsEvent {

  CampaignAnalyticsFetched();
}