part of '../../../../blocs/brand/new_campaign/new_campaign_bloc.dart';

abstract class NewCampaignEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateCampaign extends NewCampaignEvent {
  final NewCampaignRequest newCampaignRequest;

  CreateCampaign({required this.newCampaignRequest});
}

class GetCampaignCreateData extends NewCampaignEvent {

}
