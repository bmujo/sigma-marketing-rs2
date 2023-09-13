part of '../../../../blocs/brand/campaign_analytics/campaign_analytics_bloc.dart';

enum CampaignAnalyticsStatus { initial, success, failure }

class CampaignAnalyticsState extends Equatable {
  const CampaignAnalyticsState({
    this.status = CampaignAnalyticsStatus.initial,
    this.campaignAnalytics,
    this.campaigns = const <CampaignAnalyticsItem>[],
    this.hasReachedMax = false,
  });

  final CampaignAnalyticsStatus status;
  final CampaignAnalytics? campaignAnalytics;
  final List<CampaignAnalyticsItem> campaigns;
  final bool hasReachedMax;

  CampaignAnalyticsState copyWith({
    CampaignAnalyticsStatus? status,
    CampaignAnalytics? campaignAnalytics,
    List<CampaignAnalyticsItem>? campaigns,
    bool? hasReachedMax,
  }) {
    return CampaignAnalyticsState(
      status: status ?? this.status,
      campaignAnalytics: campaignAnalytics ?? this.campaignAnalytics,
      campaigns: campaigns ?? this.campaigns,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props {
    List<Object> propsList = [status, hasReachedMax, campaigns];
    if (campaignAnalytics != null) {
      propsList.add(campaignAnalytics!);
    }
    return propsList;
  }
}
