part of 'my_campaigns_bloc.dart';

abstract class MyCampaignsState extends Equatable {
  const MyCampaignsState();
}

class MyCampaignsInitial extends MyCampaignsState {
  @override
  List<Object> get props => [];
}

class MyCampaignsLoaded extends MyCampaignsState {
  final MyCampaigns myCampaigns;

  const MyCampaignsLoaded({required this.myCampaigns});

  @override
  List<Object> get props => [myCampaigns];
}

class MyCampaignsError extends MyCampaignsState {
  final String message;

  const MyCampaignsError({required this.message});

  @override
  List<Object> get props => [message];
}
