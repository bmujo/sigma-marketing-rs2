part of 'campaigns_bloc.dart';

enum CampaignsStatus { initial, success, failure }

class CampaignsState extends Equatable {
  CampaignsState({
    this.status = CampaignsStatus.initial,
    this.campaigns = const <CampaignBrand>[],
    this.hasReachedMax = false,
  });

  final CampaignsStatus status;
  late final List<CampaignBrand> campaigns;
  final bool hasReachedMax;

  CampaignsState copyWith({
    CampaignsStatus? status,
    List<CampaignBrand>? campaigns,
    bool? hasReachedMax,
  }) {
    return CampaignsState(
      status: status ?? this.status,
      campaigns: campaigns ?? this.campaigns,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${campaigns.length} }''';
  }

  @override
  List<Object> get props => [status, campaigns, hasReachedMax];
}
