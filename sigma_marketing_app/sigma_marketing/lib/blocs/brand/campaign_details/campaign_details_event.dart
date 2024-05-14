part of '../../../../blocs/brand/campaign_details/campaign_details_bloc.dart';

abstract class CampaignDetailsEvent extends Equatable {
  const CampaignDetailsEvent();
}

class GetCampaignDetailsEvent extends CampaignDetailsEvent {
  final int id;

  const GetCampaignDetailsEvent({required this.id});

  @override
  List<Object> get props => [id];
}