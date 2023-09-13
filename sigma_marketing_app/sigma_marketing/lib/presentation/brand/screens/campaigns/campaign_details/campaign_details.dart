import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sigma_marketing/data/models/response/campaign/achievement_point.dart';
import 'package:sigma_marketing/blocs/brand/campaign_details/campaign_details_bloc.dart';
import 'package:sigma_marketing/presentation/brand/screens/campaigns/campaign_details/widgets/header.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_button/custom_button.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';

import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/response/brand/campaign_details/influencer.dart';
import '../../../../../data/models/response/new_campaign/tag_data.dart';
import '../../../../../utils/colors/colors.dart';
import '../../influencer_profile/influencer_profile.dart';

class CampaignDetails extends StatefulWidget {
  final int campaignId;
  final VoidCallback onDeselect;

  const CampaignDetails(
      {Key? key, required this.campaignId, required this.onDeselect})
      : super(key: key);

  @override
  _CampaignDetailsState createState() => _CampaignDetailsState();
}

class _CampaignDetailsState extends State<CampaignDetails> {
  late CampaignDetailsBloc _campaignDetailsBloc;

  @override
  void initState() {
    super.initState();
    _campaignDetailsBloc = CampaignDetailsBloc();
    _loadCampaignDetails();
  }

  @override
  void didUpdateWidget(covariant CampaignDetails oldWidget) {
    if (widget.campaignId != oldWidget.campaignId) {
      _loadCampaignDetails();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _loadCampaignDetails() {
    _campaignDetailsBloc.add(GetCampaignDetailsEvent(id: widget.campaignId));
  }

  @override
  void dispose() {
    _campaignDetailsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
        bloc: _campaignDetailsBloc,
        builder: (context, state) {
          if (state is CampaignDetailsError) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is CampaignDetailsLoaded) {
            return Scaffold(
                backgroundColor: SMColors.secondMain,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CampaignHeader(
                        title: state.campaignDetails.title,
                        campaignId: state.campaignDetails.id,
                        status: state.campaignDetails.campaignStatus,
                      ),
                      const SizedBox(height: 16),
                      _buildImage(state.campaignDetails.imageUrl),
                      const SizedBox(height: 16),
                      _buildDescription(state.campaignDetails.details),
                      const SizedBox(height: 16),
                      _buildDuration(state.campaignDetails.start,
                          state.campaignDetails.end),
                      const SizedBox(height: 16),
                      _buildTags(state.campaignDetails.tags),
                      const SizedBox(height: 16),
                      _buildAchievements(
                          state.campaignDetails.achievementPoints),
                      const SizedBox(height: 16),
                      _buildInfluencers(
                          state.campaignDetails.currentInfluencers),
                      const SizedBox(height: 16),
                    ],
                  ),
                ));
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildTags(List<TagData> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Tags',
            style: CustomTextStyle.semiBoldText(16),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: tags.map((tag) {
            return Chip(
              label: Text(tag.name, style: CustomTextStyle.regularText(12)),
              backgroundColor: SMColors.primaryColor,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildInfluencers(List<Influencer> influencers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Current Influencers',
            style: CustomTextStyle.semiBoldText(16),
          ),
        ),
        const SizedBox(height: 8),
        ...influencers.map((influencer) {
          return Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: _buildInfluencerCard(influencer),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildInfluencerCard(Influencer influencer) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(influencer.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            '${influencer.firstName} ${influencer.lastName}',
            style: CustomTextStyle.semiBoldText(14),
          ),
        ),
        Expanded(child: Container()),
        CustomButton(
            text: 'View Profile',
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return InfluencerProfile();
                },
              );
            }),
      ],
    );
  }

  Widget _buildAchievements(List<AchievementPoint> achievementPoints) {
    return Column(
      children: [
        const CustomLabel(title: 'Achievements'),
        const SizedBox(height: 8),
        ...achievementPoints.map((achievementPoint) {
          return Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: _buildAchievementTile(
              achievementPoint.type.imageUrl,
              achievementPoint.description,
              achievementPoint.description,
              achievementPoint.type.value,
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildAchievementTile(
    String imageUrl,
    String name,
    String description,
    int sigmaTokens,
  ) {
    return ExpansionTile(
      leading: Image.network(imageUrl, width: 24, height: 24),
      title: Text(name),
      children: [
        ListTile(
          leading: Image.network(imageUrl, width: 48, height: 48),
          title: Text(description),
          subtitle: Text('Worth: $sigmaTokens Sigma Tokens'),
        ),
      ],
    );
  }

  Widget _buildDuration(DateTime start, DateTime end) {
    return Column(children: [
      const CustomLabel(title: 'Duration'),
      const SizedBox(height: 8),
      const Divider(height: 1),
      const SizedBox(height: 8),
      Row(
        children: [
          Text(
            'Start Date',
            style: CustomTextStyle.regularText(14),
          ),
          const Expanded(child: Divider(height: 1, indent: 16, endIndent: 16)),
          Text(
            DateFormat('dd.MM.yyyy').format(start),
            style: CustomTextStyle.mediumText(14),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Text(
            'End Date',
            style: CustomTextStyle.regularText(14),
          ),
          const Expanded(child: Divider(height: 1, indent: 16, endIndent: 16)),
          Text(
            DateFormat('dd.MM.yyyy').format(end),
            style: CustomTextStyle.mediumText(14),
          ),
        ],
      ),
    ]);
  }

  Column _buildImage(String imageUrl) {
    return Column(children: [
      const CustomLabel(title: 'Image'),
      const SizedBox(height: 8),
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
      ),
    ]);
  }

  Widget _buildDescription(String details) {
    return Column(
      children: [
        const CustomLabel(title: 'Description'),
        const SizedBox(height: 8),
        Text(
          details,
          style: CustomTextStyle.regularText(14),
        ),
      ],
    );
  }
}
