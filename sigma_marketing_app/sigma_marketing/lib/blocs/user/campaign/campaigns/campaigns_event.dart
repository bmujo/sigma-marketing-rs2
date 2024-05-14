part of 'campaigns_bloc.dart';

abstract class CampaignsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CampaignsFetched extends CampaignsEvent {
  final String query;

  CampaignsFetched({required this.query});
}

class ToggleLikeCampaign extends CampaignsEvent {
  final int campaignId;
  final bool liked;

  ToggleLikeCampaign({required this.campaignId, required this.liked});
}
