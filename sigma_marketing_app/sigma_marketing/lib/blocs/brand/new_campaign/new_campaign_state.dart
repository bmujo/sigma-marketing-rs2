part of '../../../../blocs/brand/new_campaign/new_campaign_bloc.dart';

enum NewCampaignStatus { initial, success, failure }

class NewCampaignState extends Equatable {
  const NewCampaignState({
    this.status = NewCampaignStatus.initial,
    this.campaignCreateData,
  });

  final NewCampaignStatus status;
  final CampaignCreateData? campaignCreateData;

  NewCampaignState copyWith({
    NewCampaignStatus? status,
    CampaignCreateData? campaignCreateData,
  }) {
    return NewCampaignState(
      status: status ?? this.status,
      campaignCreateData: campaignCreateData ?? this.campaignCreateData,
    );
  }

  @override
  List<Object> get props => [status, campaignCreateData ?? ""];
}