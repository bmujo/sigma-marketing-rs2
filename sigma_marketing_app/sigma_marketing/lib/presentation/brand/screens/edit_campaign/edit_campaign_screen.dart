import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/data/models/response/brand/campaign_details/campaign_details_brand.dart';
import 'package:sigma_marketing/presentation/brand/screens/edit_campaign/manage_influencers/manage_influencers.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_button/custom_button.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_status/custom_status.dart';

import '../../../../../utils/colors/colors.dart';
import '../../../../config/style/custom_text_style.dart';
import '../../../../data/models/request/brand/new_campaign/new_achievement.dart';
import '../../../../data/models/request/brand/new_campaign/new_campaign.dart';
import '../../../../data/models/response/new_campaign/platform_data.dart';
import '../../../../data/models/response/new_campaign/tag_data.dart';
import '../../../common/widgets/custom_text_input/custom_text_input.dart';
import '../../../common/widgets/date_picker/date_picker.dart';
import '../../../common/widgets/dropdown/dropdown_textfield.dart';
import '../../../common/widgets/dropdown/single/single_dropdown.dart';
import '../../../../blocs/brand/edit_campaign/edit_campaign_bloc.dart';
import '../new_campaign/achievements/achievements_create.dart';
import '../new_campaign/add_achievements/add_achievements_dialog.dart';
import '../new_campaign/add_photos/add_photos.dart';
import '../new_campaign/platforms/platforms_create.dart';
import '../new_campaign/tags/tags_create.dart';

class EditCampaignScreen extends StatefulWidget {
  final int campaignId;

  const EditCampaignScreen({Key? key, required this.campaignId})
      : super(key: key);

  @override
  _EditCampaignScreenState createState() => _EditCampaignScreenState();
}

class _EditCampaignScreenState extends State<EditCampaignScreen> {
  late EditCampaignBloc _editCampaignBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late SingleValueDropDownController _cntSinglePaymentTerm;

  bool isCampaignActive = false;
  List<TagData> selectedTags = [];
  List<Achievement> achievements = [];
  List<PlatformData> platforms = [];
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
    _editCampaignBloc = EditCampaignBloc();
    _editCampaignBloc.add(GetCampaignDetailsEvent(id: widget.campaignId));

    _cntSinglePaymentTerm = SingleValueDropDownController();
  }

  @override
  void dispose() {
    _editCampaignBloc.close();

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
    return BlocProvider(
        create: (context) => _editCampaignBloc,
        child: Scaffold(
          backgroundColor: SMColors.main,
          appBar: AppBar(
            backgroundColor: SMColors.main,
            title: Text(
              "Manage Campaign",
              style: CustomTextStyle.mediumText(20),
            ),
          ),
          body: Form(
              key: _formKey, // Attach the GlobalKey to the Form widget
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 16, bottom: 16),
                child: BlocBuilder<EditCampaignBloc, EditCampaignState>(
                    bloc: _editCampaignBloc,
                    builder: (context, state) {
                      if (state is CampaignDetailsError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }

                      if (state is CampaignDetailsLoaded) {
                        final campaign = state.campaignDetails;

                        _nameTextController.text = campaign.title;
                        _detailsTextController.text = campaign.details;
                        _budgetTextController.text = campaign.budget.toString();
                        _openPositionsTextController.text =
                            campaign.maxPositions.toString();
                        _videoUrlTextController.text = campaign.videoUrl;
                        _assetsTextController.text = campaign.assetsUrl;
                        _requirementsContentGuidelinesTextController.text =
                            campaign.requirementsAndContentGuidelines;

                        selectedStartDate = campaign.start;
                        selectedEndDate = campaign.end;
                        selectedDeadlineForApplications =
                            campaign.deadlineForApplications;

                        isCampaignActive = false;
                        selectedTags = campaign.tags;
                        final achievementsUI = campaign.achievementPoints
                            .map((e) => Achievement(
                                  type: e.type,
                                  title: e.description,
                                  description: e.description,
                                  id: e.id.toString(),
                                ))
                            .toList();
                        achievements = achievementsUI;
                        platforms = campaign.platforms
                            .map((e) => PlatformData(
                                  id: e.id,
                                  name: e.name,
                                ))
                            .toList();

                        return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  color: SMColors.thirdMain,
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text(
                                        'Current Status',
                                        style: CustomTextStyle.regularText(16),
                                      ),
                                      const SizedBox(width: 16),
                                      CustomStatus(
                                          status: state
                                              .campaignDetails.campaignStatus),
                                      const SizedBox(width: 32),
                                      (state.campaignDetails.campaignStatus ==
                                              0)
                                          ? CustomButton(
                                              text: "Activate Campaign",
                                              onPressed: () {},
                                            )
                                          : CustomButton(
                                              text: "Deactivate Campaign",
                                              onPressed: () {},
                                            )
                                    ],
                                  )),
                              const SizedBox(height: 24),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLeftColumn(state.campaignDetails),
                                  _buildRightColumn(state.campaignDetails)
                                ],
                              ),
                              ManageUsers(
                                influencers:
                                    state.campaignDetails.currentInfluencers,
                                campaignId: state.campaignDetails.id,
                              ),
                            ]);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              )),
        ));
  }

  Expanded _buildLeftColumn(CampaignDetailsBrand campaignDetails) {
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
                      dropDownList: campaignDetails
                          .campaignCreateData.paymentTerms
                          .map((e) =>
                              DropDownValueModel(value: e.id, name: e.name))
                          .toList(),
                      titleText: "Payment Term*",
                      hintText: "Select Payment Term",
                      cntSingle: _cntSinglePaymentTerm,
                      isValid: isPaymentTermSelected),
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
              tags: campaignDetails.campaignCreateData.tags,
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
              achievementTypes:
                  campaignDetails.campaignCreateData.achievementTypes,
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
        ),
      ),
    );
  }

  Expanded _buildRightColumn(CampaignDetailsBrand campaignDetails) {
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
                    platformsSource:
                        campaignDetails.campaignCreateData.platforms,
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
                  ),
                ),
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
            const SizedBox(height: 16),
            _buildButtons(),
          ],
        ),
      ),
    );
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
                  isActive: isCampaignActive,
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
                  invitedInfluencers: [],
                );

                Navigator.of(context).pop(newCampaign);
              }
            },
            child: const Text("Update Campaign")),
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
