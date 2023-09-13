import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/presentation/brand/screens/new_campaign/add_achievements/add_achievements_dialog.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_button/custom_button.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_text_input/custom_text_input.dart';
import 'package:sigma_marketing/presentation/user/screens/manage_achievement/manage_achievement.dart';

import '../../../../../data/models/response/campaign/achievement_point.dart';
import '../../../../../data/models/response/campaign/campaign_details.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../../utils/enums/campaign_user_status.dart';

class Achievements extends StatefulWidget {
  const Achievements({
    Key? key,
    required this.campaignDetails,
  }) : super(key: key);

  final CampaignDetails campaignDetails;

  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: SMColors.secondMain,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomLabel(title: "ACHIEVEMENTS"),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          _buildAchievements(widget.campaignDetails.achievementPoints),
        ],
      ),
    );
  }

  Widget _buildAchievements(List<AchievementPoint> achievementPoints) {
    final List<Achievement> achievements = [];
    for (var achievementPoint in achievementPoints) {
      achievements.add(Achievement(
        id: achievementPoint.id.toString(),
        title: achievementPoint.name,
        description: achievementPoint.description,
        type: achievementPoint.type,
      ));
    }

    return Column(
      children: [
        const SizedBox(height: 8),
        ...achievements.map((achievementPoint) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildAchievementTile(
              achievement: achievementPoint,
              image: achievementPoint.type.imageUrl,
              sigmaTokens: achievementPoint.type.value.toString(),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildAchievementTile({
    required Achievement achievement,
    required String image,
    required String sigmaTokens,
  }) {
    return ExpansionTile(
      backgroundColor: SMColors.thirdMain,
      collapsedBackgroundColor: SMColors.secondMain,
      iconColor: SMColors.white,
      collapsedIconColor: SMColors.white,
      leading: Image.network(image, width: 24, height: 24),
      title: Text(achievement.title, style: CustomTextStyle.mediumText(14)),
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(left: 16, right: 0, bottom: 16),
          leading: Image.network(image, width: 48, height: 48),
          subtitle: Text('Worth: $sigmaTokens Sigma Tokens',
              style: CustomTextStyle.regularText(12)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  foregroundColor: Colors.white,
                  backgroundColor: SMColors.primaryColor,
                ),
                onPressed: () => _editAchievement(achievement),
                child: const Icon(Icons.arrow_circle_right, size: 24),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _editAchievement(Achievement achievement) async {
    if (widget.campaignDetails.campaignUserStatus ==
        CampaignUserStatus.inProgress.index) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) =>
              ManageAchievement(achievementId: int.parse(achievement.id)));
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: SMColors.main,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Row(
                  children: [
                    const CustomLabel(title: "ACHIEVEMENT DETAILS"),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close, color: SMColors.white),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    achievement.title,
                    style: CustomTextStyle.boldText(16),
                  ),
                ),
                const SizedBox(height: 16),
                Row(children: [
                  Image.network(achievement.type.imageUrl,
                      width: 48, height: 48),
                  const SizedBox(width: 16),
                  Text(
                    'Worth: ${achievement.type.value}',
                    style: CustomTextStyle.regularText(12),
                  ),
                ]),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(achievement.description,
                      style: CustomTextStyle.regularText(16)),
                ),
                const SizedBox(height: 32),
                Visibility(
                    visible: widget.campaignDetails.campaignUserStatus ==
                        CampaignUserStatus.requested.index,
                    child: Column(children: [
                      CustomTextInput(
                          labelText: "Data and demonstration",
                          hintText:
                              "Here you can provide proof, guide what is done, links",
                          customHeight: 120,
                          isMultiline: true),
                      const SizedBox(height: 16),
                      CustomButton(text: "SUBMIT", onPressed: () {}),
                    ])),
              ],
            )),
          );
        },
      );
    }
  }
}
