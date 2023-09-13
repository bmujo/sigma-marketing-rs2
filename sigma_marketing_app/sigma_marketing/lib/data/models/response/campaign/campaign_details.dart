import 'package:json_annotation/json_annotation.dart';

import 'achievement_point.dart';

part 'campaign_details.g.dart';

@JsonSerializable()
class CampaignDetails {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'title')
  String title = "";

  @JsonKey(name: 'details')
  String details = "";

  @JsonKey(name: 'maxPositions')
  int maxPositions = 0;

  @JsonKey(name: 'start')
  DateTime start = DateTime.now();

  @JsonKey(name: 'end')
  DateTime end = DateTime.now();

  @JsonKey(name: 'photos')
  List<String> photos = [];

  @JsonKey(name: 'videoUrl')
  String videoUrl = "";

  @JsonKey(name: 'company')
  String company = "";

  @JsonKey(name: 'likes')
  int likes = 0;

  @JsonKey(name: 'liked')
  bool liked = false;

  @JsonKey(name: 'influencers')
  int influencers = 0;

  @JsonKey(name: 'campaignStatus')
  int campaignStatus = 0;

  @JsonKey(name: 'campaignUserStatus')
  int campaignUserStatus = 0;

  @JsonKey(name: 'tags')
  List<String> tags = [];

  @JsonKey(name: 'achievementPoints')
  List<AchievementPoint> achievementPoints = [];

  @JsonKey(name: 'companyBio')
  String companyBio = "";

  @JsonKey(name: 'companyImageUrl')
  String companyImageUrl = "";

  @JsonKey(name: 'campaignLocation')
  String campaignLocation = "";

  CampaignDetails(
      {required this.id,
      required this.title,
      required this.details,
      required this.maxPositions,
      required this.start,
      required this.end,
      required this.photos,
      required this.videoUrl,
      required this.company,
      required this.likes,
      required this.liked,
      required this.influencers,
      required this.campaignStatus,
      required this.campaignUserStatus,
      required this.tags,
      required this.achievementPoints,
      required this.companyBio,
      required this.companyImageUrl,
      required this.campaignLocation});

  factory CampaignDetails.fromJson(dynamic json) =>
      _$CampaignDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignDetailsToJson(this);

  copyWith({required bool isLiked}) {
    return CampaignDetails(
        id: id,
        title: title,
        details: details,
        maxPositions: maxPositions,
        start: start,
        end: end,
        photos: photos,
        videoUrl: videoUrl,
        company: company,
        likes: likes,
        influencers: influencers,
        campaignStatus: campaignStatus,
        campaignUserStatus: campaignUserStatus,
        tags: tags,
        achievementPoints: achievementPoints,
        liked: isLiked,
        companyBio: companyBio,
        companyImageUrl: companyImageUrl,
        campaignLocation: campaignLocation);
  }
}
