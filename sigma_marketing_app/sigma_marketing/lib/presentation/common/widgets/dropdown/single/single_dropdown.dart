import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';

import '../../../../../utils/colors/colors.dart';
import '../../../../../utils/constants/constants.dart';
import '../dropdown_textfield.dart';

class SingleDropdown extends StatefulWidget {
  final List<DropDownValueModel> dropDownList;
  final String titleText;
  final String hintText;
  final SingleValueDropDownController cntSingle;
  late bool isValid;

  SingleDropdown({
    required this.dropDownList,
    required this.titleText,
    required this.hintText,
    required this.cntSingle,
    required this.isValid,
    Key? key,
  }) : super(key: key);

  @override
  _SingleDropdownState createState() => _SingleDropdownState();
}

class _SingleDropdownState extends State<SingleDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomLabel(title: widget.titleText),
      SizedBox(height: 8),
      DropDownTextField(
        dropdownRadius: 4,
        textFieldDecoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          hintStyle: GoogleFonts.getFont(
            UtilConstants.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: SMColors.white,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          fillColor: SMColors.secondMain,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: SMColors.secondMain,
              width: 0.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: SMColors.secondMain,
              width: 0.0,
            ),
          ),
          filled: true,
        ),
        dropDownIconProperty: IconProperty(
            icon: Icons.keyboard_arrow_down_rounded, color: SMColors.hintColor),
        dropDownItemCount: 6,
        dropDownList: widget.dropDownList,
        clearOption: false,
        onChanged: (val) {
          setState(() {
            widget.cntSingle.dropDownValue = val;
            widget.isValid = true;
          });
        },
      ),
      Visibility(
          visible: !widget.isValid,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Please select a value",
                style: GoogleFonts.getFont(
                  UtilConstants.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: SMColors.red,
                ),
              )))
    ]);
  }
}
