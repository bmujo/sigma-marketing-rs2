part of '../../../../../blocs/user/campaign/campaign_details/campaign_details_bloc.dart';

abstract class CampaignDetailsEvent extends Equatable {
  const CampaignDetailsEvent();
}

class GetCampaignDetailsEvent extends CampaignDetailsEvent {
  final int id;

  const GetCampaignDetailsEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class OnCampaignUpdateEvent extends CampaignDetailsEvent {
  final CampaignState campaignState;

  const OnCampaignUpdateEvent({required this.campaignState});

  @override
  List<Object> get props => [campaignState];
}

class CompleteCampaignEvent extends CampaignDetailsEvent {
  final CompleteCampaign completeCampaign;

  const CompleteCampaignEvent({required this.completeCampaign});

  @override
  List<Object> get props => [completeCampaign];
}
