part of 'edit_campaign_bloc.dart';

abstract class EditCampaignEvent extends Equatable {
  const EditCampaignEvent();
}

class GetCampaignDetailsEvent extends EditCampaignEvent {
  final int id;

  const GetCampaignDetailsEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class OnAcceptInfluencer extends EditCampaignEvent {
  final int campaignId;
  final int influencerId;

  const OnAcceptInfluencer(
      {required this.campaignId, required this.influencerId});

  @override
  List<Object> get props => [campaignId, influencerId];
}

class OnRejectInfluencer extends EditCampaignEvent {
  final int campaignId;
  final int influencerId;

  const OnRejectInfluencer(
      {required this.campaignId, required this.influencerId});

  @override
  List<Object> get props => [campaignId, influencerId];
}

class OnPayInfluencer extends EditCampaignEvent {
  final int campaignId;
  final int influencerId;

  const OnPayInfluencer(
      {required this.campaignId, required this.influencerId});

  @override
  List<Object> get props => [campaignId, influencerId];
}
