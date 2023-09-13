part of 'campaigns_bloc.dart';

abstract class CampaignsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CampaignsFetched extends CampaignsEvent {
  final String query;

  CampaignsFetched({required this.query});
}

