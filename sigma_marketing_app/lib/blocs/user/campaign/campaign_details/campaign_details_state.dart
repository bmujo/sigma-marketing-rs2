part of '../../../../../blocs/user/campaign/campaign_details/campaign_details_bloc.dart';

abstract class CampaignDetailsState extends Equatable {
  const CampaignDetailsState();
}

class CampaignDetailsInitial extends CampaignDetailsState {
  @override
  List<Object> get props => [];
}

class CampaignDetailsLoading extends CampaignDetailsState {
  @override
  List<Object> get props => [];
}

class CampaignDetailsLoaded extends CampaignDetailsState {
  final CampaignDetails campaignDetails;

  const CampaignDetailsLoaded({required this.campaignDetails});

  @override
  List<Object> get props => [campaignDetails];
}

class CampaignDetailsError extends CampaignDetailsState {
  final String message;

  const CampaignDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
