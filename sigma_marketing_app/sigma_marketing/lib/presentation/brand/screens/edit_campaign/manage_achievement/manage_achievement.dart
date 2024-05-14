import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/data/models/response/campaign/achievement_point.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_button/custom_button.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_status/custom_status.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_text_input/custom_text_input.dart';
import 'package:sigma_marketing/utils/enums/achievement_status.dart';
import 'package:sigma_marketing/utils/utils.dart';
import '../../../../../blocs/common/achievement/achievement_bloc.dart';
import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/response/base/base_status.dart';
import '../../../../../utils/colors/colors.dart';

class ManageAchievement extends StatefulWidget {
  final String firstName;
  final String lastName;
  final int achievementId;

  const ManageAchievement({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.achievementId,
  }) : super(key: key);

  @override
  _ManageAchievementState createState() => _ManageAchievementState();
}

class _ManageAchievementState extends State<ManageAchievement> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AchievementBloc _achievementBloc;
  late BaseStatus status;

  late TextEditingController _commentController;

  @override
  void initState() {
    _commentController = TextEditingController();
    super.initState();
    status = BaseStatus(
      value: 0,
      name: "",
      color: "#FFC107",
    );
    _achievementBloc = AchievementBloc();
    _achievementBloc.add(GetAchievementEvent(id: widget.achievementId));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: SMColors.secondMain,
      elevation: 10,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: SMColors.main.withOpacity(0.95),
            child: Form(
              key: _formKey, // Attach the GlobalKey to the Form widget
              child: SingleChildScrollView(
                child: BlocBuilder<AchievementBloc, AchievementState>(
                    bloc: _achievementBloc,
                    builder: (context, state) {
                      if (state is AchievementError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }

                      if (state is AchievementLoaded) {
                        status = state.achievementPoint.status;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildHeader(
                                context, state.achievementPoint.status),
                            const SizedBox(height: 20),
                            _buildAchievement(
                              state.achievementPoint,
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: SMColors.white, height: 1),
                            const SizedBox(height: 30),
                            const CustomLabel(title: "Proofs and Comments"),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  state.achievementPoint.trackNotes.length,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                            constraints: const BoxConstraints(
                                                minHeight: 80),
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
                            Visibility(
                                child: _buildInteractions(),
                                visible: [
                                  AchievementStatus.initial.index,
                                  AchievementStatus.revision.index,
                                  AchievementStatus.review.index,
                                ].contains(state.achievementPoint.status.value)),
                          ],
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInteractions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextInput(
          labelText: "Comment",
          hintText: "Enter comment here",
          controller: _commentController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Comment is required';
            }
            return null;
          },
          isMultiline: true,
          customHeight: 90,
        ),
        const SizedBox(height: 16),
        CustomButton(
            text: 'Add Comment',
            onPressed: () {
              _achievementBloc.add(SubmitReviewEvent(
                id: widget.achievementId,
                comment: _commentController.text,
              ));
              setState(() {
                _commentController.clear();
              });
            }),
        const SizedBox(height: 10),
        const Divider(color: SMColors.white, height: 1),
        const SizedBox(height: 30),
        CustomButton(
            text: "Finish",
            onPressed: () async {
              bool? shouldFinish = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: SMColors.thirdMain,
                    title: Text('Finish Achievement'),
                    content:
                        Text('Are you sure you want to finish achievement?'),
                    actions: <Widget>[
                      CustomButton(
                        backgroundColor: SMColors.dividerColor,
                          text: "Cancel",
                          onPressed: () => Navigator.of(context).pop(false)),
                      CustomButton(
                          text: "Yes",
                          onPressed: () => Navigator.of(context).pop(true)),
                    ],
                  );
                },
              );

              if (shouldFinish == null || !shouldFinish) {
                return;
              }

              _achievementBloc
                  .add(SubmitCompleteEvent(id: widget.achievementId));
            }),
      ],
    );
  }

  Column _buildAchievement(AchievementPoint achievement) {
    final value = achievement.type.value;
    final valueCash = achievement.type.valueCash;
    return Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(achievement.type.imageUrl),
            const SizedBox(width: 20),
            Text(
              achievement.name,
              style: CustomTextStyle.semiBoldText(14),
            ),
            const SizedBox(width: 20),
            Text("Worth $value Sigma Tokens / $valueCash \$"),
          ]),
      const Divider(color: SMColors.white, height: 1),
      const SizedBox(height: 10),
      Row(
        children: [
          Text(
            "Description:",
            style: CustomTextStyle.semiBoldText(14),
          ),
          const SizedBox(width: 10),
          Text(
            achievement.description,
            style: CustomTextStyle.regularText(14),
          ),
        ],
      )
    ]);
  }

  Row _buildHeader(BuildContext context, BaseStatus status) {
    return Row(
      children: [
        CustomLabel(
            title:
                "Manage Achievement For ${widget.firstName} ${widget.lastName}"),
        const Spacer(),
        Text(
          "Status:",
          style: CustomTextStyle.semiBoldText(14),
        ),
        const SizedBox(width: 10),
        CustomStatus(status: status),
        const SizedBox(width: 30),
        IconButton(
            onPressed: () {
              Navigator.of(context).pop(status);
            },
            icon: const Icon(Icons.close))
      ],
    );
  }
}
