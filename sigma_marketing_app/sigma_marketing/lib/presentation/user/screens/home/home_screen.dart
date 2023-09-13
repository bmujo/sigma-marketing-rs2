import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';

import '../../../../utils/colors/colors.dart';
import '../../../../utils/constants/constants.dart';
import '../../../common/widgets/dropdown/dropdown_textfield.dart';
import '../../../../blocs/user/campaign/campaigns/campaigns_bloc.dart';
import 'campaigns_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchTextController = TextEditingController();

  late CampaignsBloc _campaignsBloc;

  final GlobalKey<FormState> _formKeyStatuses = GlobalKey<FormState>();
  late MultiValueDropDownController _cntMultiStatuses;

  bool showFilters = false;

  @override
  void initState() {
    super.initState();
    _campaignsBloc = CampaignsBloc();
    _cntMultiStatuses = MultiValueDropDownController();

    _searchTextController.addListener(() {
      if (kDebugMode) {
        print(_searchTextController.text);
      }

      _campaignsBloc.add(CampaignsFetched(query: _searchTextController.text));
    });
  }

  @override
  void dispose() {
    _campaignsBloc.close();
    _searchTextController.dispose();
    _cntMultiStatuses.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SMColors.main,
      body: BlocProvider(
        create: (_) => _campaignsBloc..add(CampaignsFetched(query: "")),
        child: Column(children: [
          _buildSearchBar(),
          const SizedBox(height: 16),
          const CampaignsList(),
        ],)
      ),
    );
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
                  decoration: const InputDecoration(
                    hintText: 'Search for campaigns',
                    prefixIcon: Icon(Icons.search, color: SMColors.dimGrey),
                    border: OutlineInputBorder(),
                    fillColor: SMColors.secondMain,
                    filled: true,
                    hintStyle: TextStyle(color: SMColors.dimGrey),
                  ),
                  style: CustomTextStyle.mediumText(14),
                  controller: _searchTextController,
                  onChanged: (value) {
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
                  child: const Text("Apply")),
              const SizedBox(width: 16),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: SMColors.primaryColor,
                  ),
                  onPressed: () {},
                  child: const Text("Reset")),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _buildChooseStatusesFilter(BuildContext context) {
    List<DropDownValueModel> selectedStatuses = [];
    List<DropDownValueModel> availableStatuses = const [
      DropDownValueModel(name: 'Status 1', value: "1"),
      DropDownValueModel(name: 'Status 2', value: "2"),
      DropDownValueModel(name: 'Status 3', value: "3"),
      DropDownValueModel(name: 'Status 4', value: "4"),
    ];

    return Expanded(
      child: Column(
        children: [
          _buildMultiSelectDropdown(availableStatuses, "Choose statuses",
              _formKeyStatuses, _cntMultiStatuses),
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
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
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
            icon: Icons.keyboard_arrow_down_rounded, color: SMColors.hintColor),
        checkBoxProperty: CheckBoxProperty(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
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
