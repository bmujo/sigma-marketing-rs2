import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_button/custom_button.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';
import 'package:sigma_marketing/presentation/common/widgets/date_picker/date_picker.dart';
import 'package:sigma_marketing/presentation/common/widgets/dropdown/multi/multi_dropdown.dart';

import '../../../../../blocs/brand/campaign_analytics/campaign_analytics_bloc.dart';
import '../../../../../data/models/response/brand/campaign_analytics/dropdown_item.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../common/widgets/dropdown/dropdown_textfield.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  final GlobalKey<FormState> _formKeyTags = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPlatforms = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyStatuses = GlobalKey<FormState>();

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  late MultiValueDropDownController _cntMultiTags;
  late MultiValueDropDownController _cntMultiPlatforms;
  late MultiValueDropDownController _cntMultiStatuses;

  late CampaignAnalyticsBloc campaignAnalyticsBloc;

  @override
  void initState() {
    _cntMultiTags = MultiValueDropDownController();
    _cntMultiPlatforms = MultiValueDropDownController();
    _cntMultiStatuses = MultiValueDropDownController();
    super.initState();
  }

  @override
  void dispose() {
    _cntMultiTags.dispose();
    _cntMultiPlatforms.dispose();
    _cntMultiStatuses.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignAnalyticsBloc, CampaignAnalyticsState>(
        builder: (context, state) {
      campaignAnalyticsBloc = BlocProvider.of<CampaignAnalyticsBloc>(context);
      if (state.status == CampaignAnalyticsStatus.success) {
        return Stack(children: [
          Container(
            decoration: const BoxDecoration(
              color: SMColors.main, // Background color
              border: Border(
                bottom: BorderSide(
                  color: SMColors.borderColor,
                  width: 1.0,
                ),
                left: BorderSide(
                  color: SMColors.borderColor,
                  width: 1.0,
                ),
              ),
            ),
            height: 150, // Set a fixed height for the FiltersCard
            child: Card(
              color: SMColors.main,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DatePicker(
                        title: "Start date",
                        hintText: "Select start date",
                        selectedDate: selectedStartDate,
                        onDateSelected: (date) {
                          setState(() {
                            selectedStartDate = date;
                          });
                        },
                        errorMessage: "",
                        showError: false),
                    DatePicker(
                        title: "End date",
                        hintText: "Select end date",
                        selectedDate: selectedEndDate,
                        onDateSelected: (date) {
                          setState(() {
                            selectedEndDate = date;
                          });
                        },
                        errorMessage: "",
                        showError: false),
                    _buildChooseTagsFilter(
                        context, state.campaignAnalytics!.availableTags),
                    const SizedBox(width: 16),
                    _buildChoosePlatformsFilter(
                        context, state.campaignAnalytics!.allPlatforms),
                    const SizedBox(width: 16),
                    _buildChooseStatusesFilter(
                        context, state.campaignAnalytics!.allStatuses),
                    const SizedBox(width: 16),
                    _buildFilterButtons(context),
                  ],
                ),
              ),
            ),
          )
        ]);
      } else if (state.status == CampaignAnalyticsStatus.failure) {
        return Text('Error loading data');
      } else {
        return CircularProgressIndicator();
      }
    });
  }

  Column _buildFilterButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          text: "Apply Filters",
          onPressed: () {
            _applyFilters(context);
          },
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: "Clear Filters",
          onPressed: () {
            _clearFilters(context);
          },
        ),
      ],
    );
  }

  void _clearFilters(BuildContext context) {
    setState(() {
      selectedStartDate = null;
      selectedEndDate = null;
      _cntMultiTags.clearDropDown();
      _cntMultiPlatforms.clearDropDown();
      _cntMultiStatuses.clearDropDown();
    });
    campaignAnalyticsBloc.clearFilters();
    campaignAnalyticsBloc.add(CampaignAnalyticsFetched());
  }

  void _applyFilters(BuildContext context) {
    // Apply start date filter
    if (selectedStartDate != null) {
      campaignAnalyticsBloc.addStartDateFilter(selectedStartDate!);
    }

    // Apply end date filter
    if (selectedEndDate != null) {
      campaignAnalyticsBloc.addEndDateFilter(selectedEndDate!);
    }

    // Apply tags filter
    if (_cntMultiTags.dropDownValueList != null &&
        _cntMultiTags.dropDownValueList!.isNotEmpty) {
      final tags = _cntMultiTags.dropDownValueList!
          .map((e) => int.parse(e.value))
          .toList();
      campaignAnalyticsBloc.addTagsFilter(tags);
    }

    // Apply platforms filter
    if (_cntMultiPlatforms.dropDownValueList != null &&
        _cntMultiPlatforms.dropDownValueList!.isNotEmpty) {
      final platforms = _cntMultiPlatforms.dropDownValueList!
          .map((e) => int.parse(e.value))
          .toList();
      campaignAnalyticsBloc.addPlatformsFilter(platforms);
    }

    // Apply statuses filter
    if (_cntMultiStatuses.dropDownValueList != null &&
        _cntMultiStatuses.dropDownValueList!.isNotEmpty) {
      final statuses = _cntMultiStatuses.dropDownValueList!
          .map((e) => int.parse(e.value))
          .toList();
      campaignAnalyticsBloc.addStatusesFilter(statuses);
    }

    // Fetch filtered data
    campaignAnalyticsBloc.applyFilters();
    campaignAnalyticsBloc.add(CampaignAnalyticsFetched());
  }

  Expanded _buildChooseTagsFilter(
    BuildContext context,
    List<DropdownItem> tags,
  ) {
    List<DropDownValueModel> availableTags = [];
    for (var element in tags) {
      availableTags.add(
          DropDownValueModel(name: element.name, value: element.id.toString()));
    }

    return Expanded(
      child: Column(
        children: [
          const CustomLabel(title: "Tags"),
          const SizedBox(height: 8),
          MultiDropdown(
            dropDownList: availableTags,
            hintText: "Choose tags",
            formKey: _formKeyTags,
            controller: _cntMultiTags,
          ),
        ],
      ),
    );
  }

  Expanded _buildChoosePlatformsFilter(
    BuildContext context,
    List<DropdownItem> platforms,
  ) {
    List<DropDownValueModel> availablePlatforms = [];

    for (var element in platforms) {
      availablePlatforms.add(
          DropDownValueModel(name: element.name, value: element.id.toString()));
    }

    return Expanded(
      child: Column(
        children: [
          const CustomLabel(title: "Platforms"),
          const SizedBox(height: 8),
          MultiDropdown(
            dropDownList: availablePlatforms,
            hintText: "Choose platforms",
            formKey: _formKeyPlatforms,
            controller: _cntMultiPlatforms,
          ),
        ],
      ),
    );
  }

  Expanded _buildChooseStatusesFilter(
    BuildContext context,
    List<DropdownItem> platforms,
  ) {
    List<DropDownValueModel> availableStatuses = [];

    for (var element in platforms) {
      availableStatuses.add(
          DropDownValueModel(name: element.name, value: element.id.toString()));
    }

    return Expanded(
      child: Column(
        children: [
          const CustomLabel(title: "Statuses"),
          const SizedBox(height: 8),
          MultiDropdown(
            dropDownList: availableStatuses,
            hintText: "Choose statuses",
            formKey: _formKeyStatuses,
            controller: _cntMultiStatuses,
          ),
        ],
      ),
    );
  }
}
