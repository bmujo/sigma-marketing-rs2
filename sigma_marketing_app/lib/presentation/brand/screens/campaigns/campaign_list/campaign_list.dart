import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigma_marketing/blocs/brand/campaign/campaigns_bloc.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';

import '../../../../../utils/colors/colors.dart';
import '../../../../../utils/constants/constants.dart';
import '../../../../common/widgets/bottom_loader/bottom_loader.dart';
import '../../../../common/widgets/dropdown/dropdown_textfield.dart';
import '../campaign_item/campaign_item.dart';

class CampaignList extends StatefulWidget {
  final void Function(int?)? onSelect;

  const CampaignList({Key? key, this.onSelect}) : super(key: key);

  @override
  _CampaignListState createState() => _CampaignListState();
}

class _CampaignListState extends State<CampaignList> {
  late CampaignsBloc _campaignsBloc;
  int? selectedCampaignIndex;

  final _scrollController = ScrollController();
  final _searchTextController = TextEditingController();

  final GlobalKey<FormState> _formKeyStatuses = GlobalKey<FormState>();
  late MultiValueDropDownController _cntMultiStatuses;

  bool showFilters = false;

  @override
  void initState() {
    super.initState();
    _campaignsBloc = CampaignsBloc();
    _cntMultiStatuses = MultiValueDropDownController();

    _campaignsBloc.add(CampaignsFetched(query: ""));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _campaignsBloc.close();
    _cntMultiStatuses.dispose();
    _scrollController.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        const SizedBox(height: 16),
        Expanded(
          child: BlocBuilder<CampaignsBloc, CampaignsState>(
            bloc: _campaignsBloc,
            builder: (context, state) {
              if (state.status == CampaignsStatus.success) {
                if (state.campaigns.isEmpty) {
                  return Center(
                      child: Text(
                    'No campaigns',
                    style: CustomTextStyle.semiBoldText(16),
                  ));
                }
                return ListView.builder(
                  itemCount: state.campaigns.length,
                  itemBuilder: (context, index) {
                    if (!state.hasReachedMax &&
                        index >= state.campaigns.length - 1) {
                      return const BottomLoader();
                    }
                    return CampaignItem(
                      index: index,
                      selectedCampaignIndex: selectedCampaignIndex,
                      campaign: state.campaigns[index],
                      onSelect: (selectedIndex) {
                        setState(() {
                          selectedCampaignIndex = selectedIndex;
                        });
                        if (widget.onSelect != null) {
                          widget.onSelect!(selectedIndex != null
                              ? state.campaigns[selectedIndex].id
                              : null);
                        }
                      },
                    );
                  },
                  controller: _scrollController,
                );
              } else if (state.status == CampaignsStatus.failure) {
                return Center(
                  child: Text('Error loading campaigns',
                      style: CustomTextStyle.semiBoldText(16)),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void _onScroll() {
    if (_isBottom) _campaignsBloc.add(CampaignsFetched(query: ""));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Padding _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: CustomTextStyle.regularText(14),
                  decoration: InputDecoration(
                    hintText: 'Search for campaigns',
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                    fillColor: SMColors.secondMain,
                    hintStyle:
                        CustomTextStyle.regularText(14, SMColors.hintColor),
                    prefixIconColor: SMColors.hintColor,
                    filled: true,
                  ),
                  controller: _searchTextController,
                  onChanged: (value) {
                    if (widget.onSelect != null) {
                      widget.onSelect!(null);
                    }
                    setState(() {
                      selectedCampaignIndex = null;
                    });
                    _campaignsBloc.add(CampaignsFetched(query: value));
                  },
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: SMColors.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    showFilters = !showFilters;
                  });
                },
                child: Icon(showFilters ? Icons.close : Icons.filter_list),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (showFilters) ...[
            _buildFilters(),
          ]
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 3.0, color: SMColors.borderColor),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildChooseStatusesFilter(context),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: SMColors.primaryColor,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Apply",
                    style: CustomTextStyle.mediumText(14),
                  )),
              const SizedBox(width: 16),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: SMColors.primaryColor,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Reset",
                    style: CustomTextStyle.mediumText(14),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _buildChooseStatusesFilter(BuildContext context) {
    List<DropDownValueModel> selectedStatuses = [];
    List<DropDownValueModel> availableStatuses = [
      DropDownValueModel(name: 'Status 1', value: "1"),
      DropDownValueModel(name: 'Status 2', value: "2"),
      DropDownValueModel(name: 'Status 3', value: "3"),
      DropDownValueModel(name: 'Status 4', value: "4"),
    ];

    return Expanded(
      child: Column(
        children: [
          _buildMultiSelectDropdown(
            availableStatuses,
            "Choose statuses",
            _formKeyStatuses,
            _cntMultiStatuses,
          ),
        ],
      ),
    );
  }

  Form _buildMultiSelectDropdown(
      List<DropDownValueModel> dropDownList,
      String hintText,
      GlobalKey<FormState> _formKey,
      MultiValueDropDownController _cntMulti) {
    return Form(
      key: _formKey,
      child: DropDownTextField.multiSelection(
        dropdownRadius: 4,
        textFieldDecoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: GoogleFonts.getFont(
            UtilConstants.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: SMColors.white,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          fillColor: SMColors.secondMain,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: SMColors.secondMain,
              width: 0.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: SMColors.secondMain,
              width: 0.0,
            ),
          ),
          filled: true,
        ),
        submitButtonColor: SMColors.primaryColor,
        submitButtonText: "Select",
        dropDownIconProperty: IconProperty(
          icon: Icons.keyboard_arrow_down_rounded,
          color: SMColors.hintColor,
        ),
        checkBoxProperty: CheckBoxProperty(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          side: const BorderSide(
            color: SMColors.hintColor,
            width: 1,
          ),
          activeColor: SMColors.primaryColor,
          checkColor: SMColors.white,
        ),
        dropDownItemCount: 6,
        dropDownList: dropDownList,
        onChanged: (val) {
          setState(() {
            _cntMulti.dropDownValueList = val;
          });
        },
      ),
    );
  }
}
