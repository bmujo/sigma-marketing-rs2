import 'package:json_annotation/json_annotation.dart';
import 'package:sigma_marketing/data/models/response/brand/campaign_details/influencer.dart';
import 'package:sigma_marketing/data/models/response/new_campaign/tag_data.dart';

import '../../base/base_status.dart';
import '../../campaign/achievement_point.dart';
import '../../new_campaign/campaign_create_data.dart';
import '../../new_campaign/payment_terms_data.dart';
import '../../new_campaign/platform_data.dart';

part 'campaign_details_brand.g.dart';

@JsonSerializable()
class CampaignDetailsBrand {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'title')
  String title = "";

  @JsonKey(name: 'details')
  String details = "";

  @JsonKey(name: 'budget')
  int budget = 0;

  @JsonKey(name: 'maxPositions')
  int maxPositions = 0;

  @JsonKey(name: 'start')
  DateTime start = DateTime.now();

  @JsonKey(name: 'end')
  DateTime end = DateTime.now();

  @JsonKey(name: 'deadlineForApplications')
  DateTime deadlineForApplications = DateTime.now();

  @JsonKey(name: 'imageUrl')
  String imageUrl = "";

  @JsonKey(name: 'videoUrl')
  String videoUrl = "";

  @JsonKey(name: 'assetsUrl')
  String assetsUrl = "";

  @JsonKey(name: 'requirementsAndContentGuidelines')
  String requirementsAndContentGuidelines = "";

  @JsonKey(name: 'likes')
  int likes = 0;

  @JsonKey(name: 'influencers')
  int influencers = 0;

  @JsonKey(name: 'campaignStatus')
  BaseStatus campaignStatus = BaseStatus(value: 0, name: '', color: '');

  @JsonKey(name: 'isActive')
  bool isActive = false;

  @JsonKey(name: 'tags')
  List<TagData> tags = [];

  @JsonKey(name: 'achievementPoints')
  List<AchievementPoint> achievementPoints = [];

  @JsonKey(name: 'platforms')
  List<PlatformData> platforms = [];

  @JsonKey(name: 'paymentTerms')
  PaymentTermsData paymentTerms = PaymentTermsData(id: 0, name: '');

  @JsonKey(name: 'currentInfluencers')
  List<Influencer> currentInfluencers = [];

  @JsonKey(name: 'campaignCreateData')
  CampaignCreateData campaignCreateData;

  CampaignDetailsBrand(
      {required this.id,
      required this.title,
      required this.details,
      required this.budget,
      required this.maxPositions,
      required this.start,
      required this.end,
      required this.imageUrl,
      required this.videoUrl,
      required this.assetsUrl,
      required this.requirementsAndContentGuidelines,
      required this.likes,
      required this.influencers,
      required this.campaignStatus,
      required this.isActive,
      required this.tags,
      required this.achievementPoints,
      required this.platforms,
      required this.paymentTerms,
      required this.currentInfluencers,
      required this.campaignCreateData});

  factory CampaignDetailsBrand.fromJson(dynamic json) =>
      _$CampaignDetailsBrandFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignDetailsBrandToJson(this);
}