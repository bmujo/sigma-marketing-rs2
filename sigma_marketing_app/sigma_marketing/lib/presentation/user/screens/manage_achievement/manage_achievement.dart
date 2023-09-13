import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/common/achievement/achievement_bloc.dart';
import '../../../../config/style/custom_text_style.dart';
import '../../../../data/models/response/base/base_status.dart';
import '../../../../data/models/response/campaign/achievement_point.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/enums/achievement_status.dart';
import '../../../../utils/utils.dart';
import '../../../common/widgets/custom_button/custom_button.dart';
import '../../../common/widgets/custom_label/custom_label.dart';
import '../../../common/widgets/custom_status/custom_status.dart';
import '../../../common/widgets/custom_text_input/custom_text_input.dart';

class ManageAchievement extends StatefulWidget {
  final int achievementId;

  ManageAchievement({required this.achievementId});

  @override
  _ManageAchievementState createState() => _ManageAchievementState();
}

class _ManageAchievementState extends State<ManageAchievement> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AchievementBloc _achievementBloc;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _achievementBloc = AchievementBloc();
    _achievementBloc.add(GetAchievementEvent(id: widget.achievementId));
  }

  @override
  void dispose() {
    _achievementBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: SMColors.main,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<AchievementBloc, AchievementState>(
                bloc: _achievementBloc,
                builder: (context, state) {
                  if (state is AchievementError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  if (state is AchievementLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildHeader(context, state.achievementPoint.status),
                        const SizedBox(height: 20),
                        _buildAchievement(
                          state.achievementPoint,
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: SMColors.white, height: 1),
                        const SizedBox(height: 30),
                        CustomLabel(title: "Proofs and Comments"),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.achievementPoint.trackNotes.length,
                          itemBuilder: (context, index) {
                            final trackNote =
                                state.achievementPoint.trackNotes[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: SMColors.secondMain.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(height: 2),
                                      Text(trackNote.type),
                                      const SizedBox(height: 10),
                                      Text(
                                        formatDateTime(trackNote.createdAt),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        constraints:
                                            const BoxConstraints(minHeight: 80),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: SMColors.thirdMain
                                              .withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          // Align the text to the top-left
                                          child: Text(trackNote.comment),
                                        ),
                                      )),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        _buildAddProof(state.achievementPoint.status),
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ));
  }

  Widget _buildAddProof(BaseStatus status) {
    final isVisible = status.value == AchievementStatus.done.index;

    if (isVisible) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextInput(
          labelText: "Data and demonstration",
          hintText: "Here you can provide proof, guide what is done, links",
          controller: _commentController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Proof is required';
            }
            return null;
          },
          isMultiline: true,
          customHeight: 90,
        ),
        const SizedBox(height: 16),
        CustomButton(
            text: 'Add Proof',
            onPressed: () {
              _achievementBloc.add(SubmitRevisionEvent(
                id: widget.achievementId,
                comment: _commentController.text,
              ));
              setState(() {
                _commentController.clear();
              });
            }),
        const SizedBox(height: 30),
      ],
    );
  }

  Column _buildAchievement(AchievementPoint achievement) {
    final value = achievement.type.value;
    final valueCash = achievement.type.valueCash;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(achievement.type.imageUrl),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.name,
                  style: CustomTextStyle.semiBoldText(14),
                ),
                const SizedBox(height: 20),
                Text("Worth $value Sigma Tokens / $valueCash \$"),
              ],
            ),
          ]),
      const Divider(color: SMColors.white, height: 1),
      const SizedBox(height: 10),
      Text(
        "Description:",
        style: CustomTextStyle.semiBoldText(14),
      ),
      const SizedBox(height: 10),
      Text(
        achievement.description,
        style: CustomTextStyle.regularText(14),
      ),
    ]);
  }

  Row _buildHeader(BuildContext context, BaseStatus status) {
    return Row(
      children: [
        CustomLabel(title: "Manage Achievement"),
        const Spacer(),
        Text(
          "Status:",
          style: CustomTextStyle.semiBoldText(14),
        ),
        const SizedBox(width: 10),
        CustomStatus(status: status),
        const Spacer(),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
      ],
    );
  }
}
