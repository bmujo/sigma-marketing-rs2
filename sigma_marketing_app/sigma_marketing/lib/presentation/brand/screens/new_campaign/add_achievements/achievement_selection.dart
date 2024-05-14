import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';

import '../../../../../data/models/response/campaign/achievement_type.dart';
import '../../../../../utils/colors/colors.dart';

class AchievementSelection extends StatefulWidget {
  final ValueSetter<AchievementType?> onSelect;
  final AchievementType? initialType;
  final List<AchievementType> achievementTypes;

  AchievementSelection({
    required this.onSelect,
    Key? key,
    this.initialType,
    required this.achievementTypes,
  }) : super(key: key);

  @override
  _AchievementSelectionState createState() => _AchievementSelectionState();
}

class _AchievementSelectionState extends State<AchievementSelection> {
  AchievementType? selectedAchievement;

  @override
  void initState() {
    super.initState();
    if (widget.initialType != null) {
      selectedAchievement = widget.initialType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: SMColors.secondMain,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Select achievement type*',
              style: CustomTextStyle.semiBoldText(16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...widget.achievementTypes.map((achievement) {
                return _buildAchievementCard(achievement);
              }).toList(),
            ],
          ),
          selectedAchievement == null
              ? const SizedBox()
              : _buildAchievementDescription(),
        ],
      ),
    );
  }

  Container _buildAchievementDescription() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: SMColors.thirdMain,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            selectedAchievement!.explanation,
            style: CustomTextStyle.semiBoldText(16),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(AchievementType achievement) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedAchievement == achievement) {
            selectedAchievement = null;
            widget.onSelect(null);
            return;
          }

          selectedAchievement = achievement;
          widget.onSelect(achievement);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selectedAchievement == achievement
              ? SMColors.thirdMain
              : SMColors.secondMain,
          borderRadius: selectedAchievement != null
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                )
              : BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.network(
              achievement.imageUrl,
              width: 50,
              height: 50,
            ),
            Text(
              achievement.name,
              style: CustomTextStyle.semiBoldText(16),
            ),
            const SizedBox(height: 8),
            Text(
              '${achievement.value} Sigma tokens',
              style: CustomTextStyle.regularText(14),
            ),
          ],
        ),
      ),
    );
  }
}
