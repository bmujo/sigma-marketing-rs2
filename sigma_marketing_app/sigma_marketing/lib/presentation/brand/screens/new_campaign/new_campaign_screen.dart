import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/blocs/brand/new_campaign/new_campaign_bloc.dart';
import 'package:sigma_marketing/presentation/brand/screens/new_campaign/add_achievements/add_achievements_dialog.dart';
import 'package:sigma_marketing/presentation/brand/screens/new_campaign/platforms/platforms_create.dart';
import 'package:sigma_marketing/presentation/brand/screens/new_campaign/tags/tags_create.dart';
import 'package:sigma_marketing/presentation/common/widgets/date_picker/date_picker.dart';
import 'package:sigma_marketing/presentation/common/widgets/dropdown/single/single_dropdown.dart';
import '../../../../data/models/request/brand/new_campaign/new_achievement.dart';
import '../../../../data/models/request/brand/new_campaign/new_campaign.dart';
import '../../../../data/models/response/new_campaign/platform_data.dart';
import '../../../../data/models/response/new_campaign/tag_data.dart';
import '../../../../data/models/response/user/search_user.dart';
import '../../../../utils/colors/colors.dart';
import '../../../common/widgets/custom_text_input/custom_text_input.dart';
import '../../../common/widgets/dropdown/dropdown_textfield.dart';
import 'achievements/achievements_create.dart';
import 'add_photos/add_photos.dart';

class NewCampaignScreen extends StatefulWidget {
  const NewCampaignScreen({Key? key}) : super(key: key);

  @override
  _NewCampaignScreenState createState() => _NewCampaignScreenState();
}

class _NewCampaignScreenState extends State<NewCampaignScreen> {
  late NewCampaignBloc _newCampaignBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late SingleValueDropDownController _cntSinglePaymentTerm;

  List<TagData> selectedTags = [];
  List<Achievement> achievements = [];
  List<PlatformData> platforms = [];
  List<SearchUser> influencers = [];
  List<String> photos = [];

  final _nameTextController = TextEditingController();
  final _detailsTextController = TextEditingController();
  final _budgetTextController = TextEditingController();
  final _openPositionsTextController = TextEditingController();

  final _videoUrlTextController = TextEditingController();
  final _assetsTextController = TextEditingController();
  final _requirementsContentGuidelinesTextController = TextEditingController();

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  DateTime? selectedDeadlineForApplications;

  var isValidStartDate = true;
  var isValidEndDate = true;
  var isValidDeadlineForApplications = true;
  var isPaymentTermSelected = true;

  var isTagsAdded = true;
  var isAchievementsAdded = true;
  var isPlatformsAdded = true;
  var isPhotosAdded = true;

  @override
  void initState() {
    super.initState();
    _newCampaignBloc = NewCampaignBloc();
    _newCampaignBloc.add(GetCampaignCreateData());

    _cntSinglePaymentTerm = SingleValueDropDownController();
  }

  @override
  void dispose() {
    _newCampaignBloc.close();

    _cntSinglePaymentTerm.dispose();

    _nameTextController.dispose();
    _detailsTextController.dispose();
    _budgetTextController.dispose();
    _openPositionsTextController.dispose();
    _videoUrlTextController.dispose();
    _assetsTextController.dispose();
    _requirementsContentGuidelinesTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 10,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: SMColors.main.withOpacity(0.8),
            child: Form(
                key: _formKey, // Attach the GlobalKey to the Form widget
                child: SingleChildScrollView(
                  child: BlocBuilder<NewCampaignBloc, NewCampaignState>(
                      bloc: _newCampaignBloc,
                      builder: (context, state) {
                        if (state.status == NewCampaignStatus.failure) {
                          return const Center(
                            child: Text("Error loading data"),
                          );
                        }

                        if (state.status == NewCampaignStatus.success) {
                          return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'New Campaign',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: SMColors.white,
                                  height: 1,
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLeftColumn(),
                                    _buildRightColumn()
                                  ],
                                )
                              ]);
                        };
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                )),
          ),
        ),
      ),
    );
  }

  Expanded _buildLeftColumn() {
    return Expanded(
        flex: 1,
        child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                CustomTextInput(
                  labelText: 'Name*',
                  hintText: 'Enter campaign name',
                  controller: _nameTextController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter campaign name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    DatePicker(
                      title: 'Start date*',
                      hintText: 'Select start date',
                      selectedDate: selectedStartDate,
                      onDateSelected: (date) {
                        setState(() {
                          selectedStartDate = date;
                          isValidStartDate = true;
                        });
                      },
                      errorMessage: 'Please select start date',
                      showError: !isValidStartDate,
                    ),
                    const SizedBox(width: 16),
                    DatePicker(
                      title: 'End date*',
                      hintText: 'Select end date',
                      selectedDate: selectedEndDate,
                      onDateSelected: (date) {
                        setState(() {
                          selectedEndDate = date;
                          isValidEndDate = true;
                        });
                      },
                      errorMessage: 'Please select end date',
                      showError: !isValidEndDate,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    DatePicker(
                      title: 'Deadline for applications*',
                      hintText: 'Select date',
                      selectedDate: selectedDeadlineForApplications,
                      onDateSelected: (date) {
                        setState(() {
                          selectedDeadlineForApplications = date;
                          isValidDeadlineForApplications = true;
                        });
                      },
                      errorMessage: 'Please select deadline for applications',
                      showError: !isValidDeadlineForApplications,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: SingleDropdown(
                          dropDownList: _newCampaignBloc
                              .state.campaignCreateData!.paymentTerms
                              .map((e) =>
                                  DropDownValueModel(value: e.id, name: e.name))
                              .toList(),
                          titleText: "Payment Term*",
                          hintText: "Select Payment Term",
                          cntSingle: _cntSinglePaymentTerm,
                          isValid: isPaymentTermSelected
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextInput(
                  labelText: 'Details*',
                  hintText: 'Enter campaign details',
                  controller: _detailsTextController,
                  customHeight: 100.0,
                  isMultiline: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter campaign details';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextInput(
                        labelText: 'Budget*',
                        hintText: 'Enter campaign budget',
                        controller: _budgetTextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter campaign budget';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: CustomTextInput(
                        labelText: 'Open positions*',
                        hintText: 'Enter open positions',
                        controller: _openPositionsTextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter open positions';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TagsCreate(
                  tags: _newCampaignBloc.state.campaignCreateData!.tags,
                  selectedTags: selectedTags,
                  isValid: isTagsAdded,
                  onUpdateTags: (newTags) {
                    setState(() {
                      selectedTags = newTags;
                      if (selectedTags.isEmpty) {
                        isTagsAdded = false;
                      } else {
                        isTagsAdded = true;
                      }
                    });
                  },
                ),
                const SizedBox(height: 32),
                AchievementsCreate(
                  achievementTypes: _newCampaignBloc
                      .state.campaignCreateData!.achievementTypes,
                  achievements: achievements,
                  isValid: isAchievementsAdded,
                  onAddAchievement: (achievement) {
                    setState(() {
                      achievements.add(achievement);
                      if (achievements.isEmpty) {
                        isAchievementsAdded = false;
                      } else {
                        isAchievementsAdded = true;
                      }
                    });
                  },
                ),
              ],
            )));
  }

  Expanded _buildRightColumn() {
    return Expanded(
        flex: 1,
        child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: [
                AddPhotos(
                  isValid: isPhotosAdded,
                  onPhotosUpdated: (updatedPhotos) {
                    setState(() {
                      photos = updatedPhotos;
                      if (photos.isEmpty) {
                        isPhotosAdded = false;
                      } else {
                        isPhotosAdded = true;
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: PlatformsCreate(
                          platformsSource: _newCampaignBloc
                              .state.campaignCreateData!.platforms,
                          selectedPlatforms: platforms,
                          isValid: isPlatformsAdded,
                          onUpdatePlatforms: (newPlatforms) {
                            setState(() {
                              platforms = newPlatforms;
                              if (platforms.isEmpty) {
                                isPlatformsAdded = false;
                              } else {
                                isPlatformsAdded = true;
                              }
                            });
                          },
                        )),
                    const SizedBox(width: 16),
                    Expanded(flex: 1, child: _buildUrlsInput()),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextInput(
                  labelText: 'Requirements & Content Guidelines',
                  hintText: 'Enter requirements & content guidelines',
                  controller: _requirementsContentGuidelinesTextController,
                  customHeight: 70.0,
                  isMultiline: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter requirements & content guidelines';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                _buildButtons(),
              ],
            )));
  }

  Row _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: SMColors.dimGrey,
            ),
            onPressed: () {
              // Add are you sure you want to cancel dialog
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")),
        const SizedBox(width: 16),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: SMColors.primaryColor,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Validate date pickers
                if (selectedStartDate == null) {
                  setState(() {
                    isValidStartDate = false;
                  });
                  return;
                }

                if (selectedEndDate == null) {
                  setState(() {
                    isValidEndDate = false;
                  });
                  return;
                }

                if (selectedDeadlineForApplications == null) {
                  setState(() {
                    isValidDeadlineForApplications = false;
                  });
                  return;
                }

                // validate is tags added
                if (selectedTags.isEmpty) {
                  setState(() {
                    isTagsAdded = false;
                  });
                  return;
                }

                // validate is achievements added
                if (achievements.isEmpty) {
                  setState(() {
                    isAchievementsAdded = false;
                  });
                  return;
                }

                // validate is platforms added
                if (platforms.isEmpty) {
                  setState(() {
                    isPlatformsAdded = false;
                  });
                  return;
                }

                // validate is photos added
                if (photos.isEmpty) {
                  setState(() {
                    isPhotosAdded = false;
                  });
                  return;
                }

                // validate is payment term selected
                if (_cntSinglePaymentTerm.dropDownValue == null) {
                  setState(() {
                    isPaymentTermSelected = false;
                  });
                  return;
                }

                int budget = 0;
                try {
                  budget = int.parse(_budgetTextController.text);
                } catch (e) {
                  print(e);
                }

                int openPositions = 0;
                try {
                  openPositions = int.parse(_openPositionsTextController.text);
                } catch (e) {
                  print(e);
                }

                // Convert achievements to NewAchievement
                final achievementsToAdd = achievements
                    .map((e) => NewAchievement(
                          type: e.type.type,
                          title: e.title,
                          description: e.description,
                          achievementTypeId: e.type.id,
                        ))
                    .toList();

                final newCampaign = NewCampaignRequest(
                  isActive: false,
                  name: _nameTextController.text,
                  startDate: selectedStartDate!,
                  endDate: selectedEndDate!,
                  deadlineForApplications: selectedDeadlineForApplications!,
                  paymentTermId: _cntSinglePaymentTerm.dropDownValue!.value,
                  details: _detailsTextController.text,
                  budget: budget,
                  openPositions: openPositions,
                  status: 0,
                  tags: selectedTags.map((e) => e.id).toList(),
                  achievements: achievementsToAdd,
                  photos: photos,
                  platforms: platforms.map((e) => e.id).toList(),
                  videoUrl: _videoUrlTextController.text,
                  assetsUrl: _assetsTextController.text,
                  requirementsAndContentGuidelines:
                      _requirementsContentGuidelinesTextController.text,
                  invitedInfluencers: influencers.map((e) => e.id).toList(),
                );

                _newCampaignBloc.add(CreateCampaign(newCampaignRequest: newCampaign));

                Navigator.of(context).pop(newCampaign);
              }
            },
            child: const Text("Create Campaign")),
      ],
    );
  }

  Column _buildUrlsInput() {
    return Column(
      children: [
        CustomTextInput(
          labelText: 'Video URL',
          hintText: 'Enter video URL',
          controller: _videoUrlTextController,
        ),
        const SizedBox(height: 16),
        CustomTextInput(
          labelText: 'Assets URL',
          hintText: 'Enter assets URL',
          controller: _assetsTextController,
        ),
      ],
    );
  }
}
