import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';

import '../../../../../data/models/response/campaign/achievement_type.dart';
import '../../../../../utils/colors/colors.dart';
import '../add_achievements/add_achievements_dialog.dart';

class AchievementsCreate extends StatefulWidget {
  final List<AchievementType> achievementTypes;
  final List<Achievement> achievements;
  final bool isValid;
  final Function(Achievement) onAddAchievement;

  const AchievementsCreate({
    Key? key,
    required this.achievementTypes,
    required this.achievements,
    required this.isValid,
    required this.onAddAchievement,
  }) : super(key: key);

  @override
  _AchievementsCreateState createState() => _AchievementsCreateState();
}

class _AchievementsCreateState extends State<AchievementsCreate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: CustomLabel(
                title: 'Achievements*',
              ),
            ),
            Visibility(
                visible: !widget.isValid,
                child: Text(
                  'Add at least one achievement',
                  style: CustomTextStyle.regularText(14, SMColors.red),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                minimumSize: const Size(50, 50),
                foregroundColor: Colors.white,
                backgroundColor: SMColors.greenButton,
              ),
              onPressed: _addAchievement,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(color: SMColors.white, height: 1),
        const SizedBox(height: 8),
        widget.achievements.isEmpty
            ? Text(
                'Add achievements',
                style: CustomTextStyle.regularText(14),
              )
            : _buildAchievementList(),
      ],
    );
  }

  void _addAchievement() async {
    final achievementToAdd = await showDialog<Achievement>(
      context: context,
      builder: (context) => AddAchievementsDialog(
        achievementTypes: widget.achievementTypes,
      ),
    );

    if (achievementToAdd != null) {
      setState(() {
        widget.onAddAchievement(achievementToAdd);
      });
    }
  }

  Widget _buildAchievementList() {
    return Column(
      children: [
        const SizedBox(height: 8),
        ...widget.achievements.map((achievementPoint) {
          final achievementType = achievementPoint.type;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildAchievementTile(
              achievement: achievementPoint,
              image: achievementType.imageUrl,
              sigmaTokens: achievementType.value.toString(),
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
      leading: Image.network(image, width: 24, height: 24),
      title: Text(achievement.title),
      children: [
        ListTile(
          leading: Image.network(image, width: 48, height: 48),
          title: Text(achievement.description),
          subtitle: Text('Worth: $sigmaTokens Sigma Tokens'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  foregroundColor: Colors.white,
                  backgroundColor: SMColors.blue,
                ),
                onPressed: () => _editAchievement(achievement),
                child: const Icon(Icons.edit, size: 16),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  foregroundColor: Colors.white,
                  backgroundColor: SMColors.red,
                ),
                onPressed: () => _deleteAchievement(achievement),
                child: const Icon(Icons.delete, size: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _editAchievement(Achievement achievement) async {
    final achievementToAdd = await showDialog<Achievement>(
      context: context,
      builder: (context) => AddAchievementsDialog(
        initialAchievement: achievement,
        achievementTypes: widget.achievementTypes,
      ),
    );

    if (achievementToAdd != null) {
      setState(() {
        final index = widget.achievements.indexOf(achievement);
        widget.achievements[index] = achievementToAdd;
      });
    }
  }

  void _deleteAchievement(Achievement achievement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Achievement"),
          content: Text("Are you sure you want to delete this achievement?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.achievements.remove(achievement);
                });
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
