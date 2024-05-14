import 'package:json_annotation/json_annotation.dart';
import 'package:sigma_marketing/data/models/response/campaign/achievement_type.dart';
import 'package:sigma_marketing/data/models/response/new_campaign/payment_terms_data.dart';
import 'package:sigma_marketing/data/models/response/new_campaign/platform_data.dart';
import 'package:sigma_marketing/data/models/response/new_campaign/tag_data.dart';

part 'campaign_create_data.g.dart';

@JsonSerializable()
class CampaignCreateData {
  @JsonKey(name: 'platforms')
  List<PlatformData> platforms = [];

  @JsonKey(name: 'tags')
  List<TagData> tags = [];

  @JsonKey(name: 'paymentTerms')
  List<PaymentTermsData> paymentTerms = [];

  @JsonKey(name: 'achievementTypes')
  List<AchievementType> achievementTypes = [];

  CampaignCreateData(
      {required this.platforms, required this.tags, required this.paymentTerms});

  factory CampaignCreateData.fromJson(dynamic json) => _$CampaignCreateDataFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignCreateDataToJson(this);
}