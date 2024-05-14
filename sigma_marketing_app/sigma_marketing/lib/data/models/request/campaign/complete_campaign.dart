import 'dart:core';

import 'achievement_complete.dart';

class CompleteCampaign {
  int campaignId;
  List<AchievementComplete> achievements;

  CompleteCampaign({
    required this.campaignId,
    required this.achievements,
  });

  Map<String, dynamic> toJson() {
    return {
      'campaignId': campaignId,
      'achievements': achievements,
    };
  }
}