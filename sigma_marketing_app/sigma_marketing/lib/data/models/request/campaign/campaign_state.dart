import 'dart:core';

class CampaignState {
  int campaignId;
  int campaignUserStatus;
  bool isUpdateStatus;
  bool liked;

  CampaignState({
    required this.campaignId,
    required this.campaignUserStatus,
    required this.isUpdateStatus,
    required this.liked,
  });

  Map<String, dynamic> toJson() {
    return {
      'campaignId': campaignId,
      'campaignUserStatus': campaignUserStatus,
      'isUpdateStatus': isUpdateStatus,
      'liked': liked,
    };
  }
}