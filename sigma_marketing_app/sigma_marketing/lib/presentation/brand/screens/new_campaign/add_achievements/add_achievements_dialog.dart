import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_text_input/custom_text_input.dart';
import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/response/campaign/achievement_type.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../common/widgets/custom_button/custom_button.dart';
import 'achievement_selection.dart';

class AddAchievementsDialog extends StatefulWidget {
  final Achievement? initialAchievement;
  final List<AchievementType> achievementTypes;

  const AddAchievementsDialog({
    Key? key,
    this.initialAchievement,
    required this.achievementTypes,
  }) : super(key: key);

  @override
  _AddAchievementsDialogState createState() => _AddAchievementsDialogState();
}

class _AddAchievementsDialogState extends State<AddAchievementsDialog> {
  final _nameTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();

  late AchievementType? selectedType = null;
  bool? isAchievementSelected;

  final _formKey = GlobalKey<FormState>();

  String actionButton = 'Add Achievement';

  @override
  void initState() {
    super.initState();
    if (widget.initialAchievement != null) {
      _nameTextController.text = widget.initialAchievement!.title;
      _descriptionTextController.text = widget.initialAchievement!.description;
      selectedType = widget.initialAchievement!.type;
      isAchievementSelected = true;
      actionButton = 'Save';
    }
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 1200,
            padding: const EdgeInsets.all(20),
            color: SMColors.secondMain.withOpacity(0.8),
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Create New Achievement',
                        style: CustomTextStyle.semiBoldText(20),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: SMColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                isAchievementSelected == null
                    ? const SizedBox()
                    : !isAchievementSelected!
                        ? Text(
                            'Achievement type is required, select achievement type!',
                            style: CustomTextStyle.mediumText(16, Colors.red),
                          )
                        : const SizedBox(),
                AchievementSelection(
                  achievementTypes: widget.achievementTypes,
                  initialType: selectedType,
                  onSelect: (type) {
                    setState(() {
                      selectedType = type;
                      isAchievementSelected = type == null ? null : true;
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Divider(color: SMColors.white, height: 1),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextInput(
                        labelText: 'Achievement Title*',
                        hintText: 'Enter Achievement Title',
                        controller: _nameTextController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter an achievement title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextInput(
                        labelText: 'Achievement Description*',
                        hintText: 'Enter Achievement Description',
                        controller: _descriptionTextController,
                        customHeight: 100,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter an achievement description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                              text: actionButton,
                              onPressed: () {
                                addSaveAchievement();
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void addSaveAchievement() {
    if (_formKey.currentState!.validate()) {
      if (isAchievementSelected == null || !isAchievementSelected!) {
        setState(() {
          isAchievementSelected = false;
        });
        return;
      }

      final createdAchievement = Achievement(
        id: DateTime.now().toString(),
        type: selectedType!,
        title: _nameTextController.text,
        description: _descriptionTextController.text,
      );
      Navigator.of(context).pop(createdAchievement);
    }
  }
}

class Achievement {
  final String id;
  final AchievementType type;
  final String title;
  final String description;

  Achievement({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
  });
}
