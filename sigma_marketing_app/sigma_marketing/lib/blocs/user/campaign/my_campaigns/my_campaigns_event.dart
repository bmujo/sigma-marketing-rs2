part of 'my_campaigns_bloc.dart';

abstract class MyCampaignsEvent extends Equatable {
  const MyCampaignsEvent();
}

class GetMyCampaignsEvent extends MyCampaignsEvent {

  const GetMyCampaignsEvent();

  @override
  List<Object> get props => [];
}