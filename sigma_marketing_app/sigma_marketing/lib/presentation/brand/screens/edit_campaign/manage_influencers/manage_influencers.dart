import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/data/models/response/campaign/achievement_point.dart';
import 'package:sigma_marketing/presentation/brand/screens/edit_campaign/manage_achievement/manage_achievement.dart';
import 'package:sigma_marketing/presentation/common/dialogs/dialogs.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_button/custom_button.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_status/custom_status.dart';
import 'package:sigma_marketing/utils/enums/achievement_status.dart';
import 'package:sigma_marketing/utils/enums/campaign_user_status.dart';

import '../../../../../blocs/brand/edit_campaign/edit_campaign_bloc.dart';
import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/response/base/base_status.dart';
import '../../../../../data/models/response/brand/campaign_details/influencer.dart';
import '../../../../../utils/colors/colors.dart';
import '../../influencer_profile/influencer_profile.dart';
import '../invite_influencers/invite_influencers_dialog.dart';

class ManageUsers extends StatefulWidget {
  final List<Influencer> influencers;
  final campaignId;

  const ManageUsers(
      {Key? key, required this.influencers, required this.campaignId})
      : super(key: key);

  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  late EditCampaignBloc _editCampaignBloc;

  @override
  void initState() {
    _editCampaignBloc = context.read<EditCampaignBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Manage Influencers',
                style: CustomTextStyle.semiBoldText(14),
              ),
            ),
            CustomButton(
                text: "Invite",
                backgroundColor: SMColors.greenButton,
                onPressed: () {
                  _inviteInfluencers();
                }),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(
          color: SMColors.white,
          height: 1,
        ),
        const SizedBox(height: 8),
        widget.influencers.isEmpty
            ? Text(
                'Invite influencers, here will appear requests and the rest',
                style: CustomTextStyle.regularText(14),
              )
            : _buildUserList(),
      ],
    );
  }

  void _inviteInfluencers() async {
    final invitedUsers = await showDialog<List<Influencer>>(
      context: context,
      builder: (context) => InviteInfluencersDialog(
          alreadyInvitedInfluencers: widget.influencers,
          campaignId: widget.campaignId),
    );

    if (invitedUsers != null && invitedUsers.isNotEmpty) {
      setState(() {
        widget.influencers.addAll(invitedUsers);
      });
    }
  }

  Widget _buildUserList() {
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.only(top: 16, bottom: 48),
      decoration: BoxDecoration(
        color: SMColors.main,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.influencers.length,
        itemBuilder: (context, index) {
          final user = widget.influencers[index];
          return ExpansionTile(
            backgroundColor: SMColors.thirdMain,
            collapsedBackgroundColor: SMColors.secondMain,
            title: _buildInfluencerTile(user),
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: [
                      _buildPay(
                        user.currentEarningSigma,
                        user.currentEarningCash,
                        user.status,
                        user.id,
                      ),
                      const Spacer(),
                      if (user.status.value == CampaignUserStatus.requested.index)
                        _buildAcceptReject(user.id),
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
                  )),
              _buildAchievementsList(user.achievements)
            ],
          );
        },
      ),
    ));
  }

  Widget _buildPay(
    int currentEarningSigma,
    double currentEarningCash,
    BaseStatus userCampaignStatus,
    int influencerId,
  ) {
    final isPayEnabled =
        userCampaignStatus.value == CampaignUserStatus.completed.index;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SMColors.inputDarkColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            'Current earned:  $currentEarningSigma ',
            style: CustomTextStyle.boldText(16),
          ),
          const SizedBox(width: 2),
          const Image(
            image: AssetImage('assets/sigma_token.png'),
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 10),
          Text(
            ' ($currentEarningCash \$)',
            style: CustomTextStyle.boldText(16),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: isPayEnabled
                ? () {
                    showYesNoDialog(context, "Paying influencer",
                        "Are you sure to pay influencer?", () {
                      final editCampaignBloc = context.read<EditCampaignBloc>();
                      editCampaignBloc.add(OnPayInfluencer(
                          campaignId: widget.campaignId,
                          influencerId: influencerId));
                    });
                  }
                : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(70, 35),
              foregroundColor: Colors.white,
              backgroundColor: SMColors.primaryColor,
            ),
            child: Text(
              'Pay',
              style: CustomTextStyle.mediumText(14),
            ),
          ),
          const SizedBox(width: 30),
          Tooltip(
              message: "Once all achievements are done, pay influencer",
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: SMColors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.question_mark_rounded,
                  size: 12,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildAcceptReject(int userId) {
    return Row(
      children: [
        CustomButton(
            text: 'Accept',
            onPressed: () {
              showYesNoDialog(context, "Accepting user",
                  "Are you sure to accept user to campaign?", () {
                final editCampaignBloc = context.read<EditCampaignBloc>();
                editCampaignBloc.add(OnAcceptInfluencer(
                    campaignId: widget.campaignId, influencerId: userId));
              });
            }),
        const SizedBox(width: 8),
        CustomButton(
            text: 'Reject',
            onPressed: () {
              showYesNoDialog(context, "Rejecting user",
                  "Are you sure to reject user from campaign?", () {
                final editCampaignBloc = context.read<EditCampaignBloc>();
                editCampaignBloc.add(OnRejectInfluencer(
                    campaignId: widget.campaignId, influencerId: userId));
              });
            }),
        const SizedBox(width: 32),
      ],
    );
  }

  Widget _buildInfluencerTile(Influencer user) {
    return Row(
      children: [
        CircleAvatar(backgroundImage: NetworkImage(user.imageUrl)),
        const SizedBox(width: 8),
        Text('${user.firstName} ${user.lastName}'),
        const Spacer(),
        CustomStatus(status: user.status)
      ],
    );
  }

  Widget _buildAchievementsList(List<AchievementPoint> achievements) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, right: 8, left: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SMColors.inputDarkColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: [
        const CustomLabel(title: "Manage Achievements"),
        const SizedBox(height: 8),
        const Divider(color: SMColors.white, height: 1),
        const SizedBox(height: 24),
        ListView.builder(
          shrinkWrap: true,
          itemCount: achievements.length,
          itemBuilder: (context, index) {
            final achievement = achievements[index];
            return Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      achievement.name,
                      style: CustomTextStyle.mediumText(14),
                    ),
                    const SizedBox(width: 32),
                    Text(
                      achievement.description,
                      style: CustomTextStyle.regularText(14),
                    ),
                    const Spacer(),
                    CustomStatus(status: achievement.status),
                    const SizedBox(width: 32),
                    CustomButton(
                        text: 'Review',
                        onPressed: () async {
                          var back = await showDialog<BaseStatus>(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => ManageAchievement(
                              firstName: widget.influencers[index].firstName,
                              lastName: widget.influencers[index].lastName,
                              achievementId: achievement.id,
                            ),
                          );

                          if (back != null) {
                            setState(() {
                              achievements[index].status = back;
                            });

                            if (areAllAchievementsDone(achievements)) {
                              _editCampaignBloc.add(
                                GetCampaignDetailsEvent(
                                  id: widget.campaignId,
                                ),
                              );
                            }
                          }
                        })
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(color: SMColors.dividerColor, height: 1)
              ],
            );
          },
        )
      ]),
    );
  }

  bool areAllAchievementsDone(List<AchievementPoint> achievements) {
    for (var achievement in achievements) {
      if (achievement.status.value != AchievementStatus.done.index) {
        return false;
      }
    }
    return true;
  }
}
