import 'new_achievement.dart';

class NewCampaignRequest {
  bool isActive;
  String name;
  DateTime startDate;
  DateTime endDate;
  DateTime deadlineForApplications;
  int paymentTermId;

  String details;
  int budget;
  int openPositions;
  int status;

  List<int> tags;
  List<NewAchievement> achievements;

  List<String> photos;

  List<int> platforms;
  String videoUrl;
  String assetsUrl;
  String requirementsAndContentGuidelines;

  List<int> invitedInfluencers;

  NewCampaignRequest({
    required this.isActive,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.deadlineForApplications,
    required this.paymentTermId,
    required this.details,
    required this.budget,
    required this.openPositions,
    required this.status,
    required this.tags,
    required this.achievements,
    required this.photos,
    required this.platforms,
    required this.videoUrl,
    required this.assetsUrl,
    required this.requirementsAndContentGuidelines,
    required this.invitedInfluencers,
  });

  Map<String, dynamic> toJson() {
    return {
      'isActive': isActive,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'deadlineForApplications': deadlineForApplications.toIso8601String(),
      'paymentTermId': paymentTermId,
      'details': details,
      'budget': budget,
      'openPositions': openPositions,
      'status': status,
      'tags': tags,
      'achievements': achievements.map((e) => e.toJson()).toList(),
      'photos': photos,
      'platforms': platforms,
      'videoUrl': videoUrl,
      'assetsUrl': assetsUrl,
      'requirementsAndContentGuidelines': requirementsAndContentGuidelines,
      'invitedInfluencers': invitedInfluencers,
    };
  }
}