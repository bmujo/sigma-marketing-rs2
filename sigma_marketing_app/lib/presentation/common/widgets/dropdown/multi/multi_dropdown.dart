import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';

import '../../../../../utils/colors/colors.dart';
import '../dropdown_textfield.dart';

class MultiDropdown extends StatefulWidget {
  final List<DropDownValueModel> dropDownList;
  final String hintText;
  final GlobalKey<FormState> formKey;
  final MultiValueDropDownController controller;

  MultiDropdown({
    required this.dropDownList,
    required this.hintText,
    required this.formKey,
    required this.controller,
  });

  @override
  _MultiDropdownState createState() => _MultiDropdownState();
}

class _MultiDropdownState extends State<MultiDropdown> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: DropDownTextField.multiSelection(
        dropdownRadius: 4,
        textFieldDecoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          hintStyle: CustomTextStyle.regularText(14),
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
          icon: Icons.keyboard_arrow_down_rounded,
          color: SMColors.hintColor,
        ),
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
        dropDownList: widget.dropDownList,
        controller: widget.controller,
        onChanged: (val) {
          setState(() {
            widget.controller.dropDownValueList = val;
          });
        },
      ),
    );
  }
}
