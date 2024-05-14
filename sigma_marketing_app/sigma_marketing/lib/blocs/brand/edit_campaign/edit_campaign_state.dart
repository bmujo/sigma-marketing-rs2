part of 'edit_campaign_bloc.dart';

abstract class EditCampaignState extends Equatable {
  const EditCampaignState();
}

class CampaignDetailsInitial extends EditCampaignState {
  @override
  List<Object> get props => [];
}

class CampaignDetailsLoading extends EditCampaignState {
  @override
  List<Object> get props => [];
}

class CampaignDetailsLoaded extends EditCampaignState {
  final CampaignDetailsBrand campaignDetails;

  const CampaignDetailsLoaded({required this.campaignDetails});

  @override
  List<Object> get props => [campaignDetails];
}

class CampaignDetailsError extends EditCampaignState {
  final String message;

  const CampaignDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
