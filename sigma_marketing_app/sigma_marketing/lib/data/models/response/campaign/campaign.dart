import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

@JsonSerializable()
class Campaign {
  @JsonKey(name: 'id')
  int id = 0;

  @JsonKey(name: 'title')
  String title = "";

  @JsonKey(name: 'imageUrl')
  String imageUrl = "";

  @JsonKey(name: 'company')
  String company = "";

  @JsonKey(name: 'likes')
  int likes = 0;

  @JsonKey(name: 'liked')
  bool liked = false;

  Campaign(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.company,
      required this.likes,
      required this.liked});

  factory Campaign.fromJson(dynamic json) => _$CampaignFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignToJson(this);

  copyWith({required bool isLiked}) {
    return Campaign(
        id: id,
        title: title,
        imageUrl: imageUrl,
        company: company,
        likes: likes,
        liked: isLiked);
  }
}
