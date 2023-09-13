import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';

import '../../../../utils/colors/colors.dart';

class CustomTextInput extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final double customHeight;
  final bool isMultiline;
  final String? Function(String?)? validator;

  const CustomTextInput({
    required this.labelText,
    required this.hintText,
    this.controller,
    this.customHeight = 44.0,
    this.isMultiline = false,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(title: widget.labelText),
        const SizedBox(height: 8),
        Container(
          height: widget.validator != null ? widget.customHeight + 24 : widget.customHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            style: CustomTextStyle.regularText(14),
            expands: widget.isMultiline,
            minLines: widget.isMultiline ? null : 1,
            maxLines: widget.isMultiline ? null : 1,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: SMColors.hintColor,
                fontSize: 14,
              ),
              fillColor: SMColors.secondMain,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            ),
            textAlignVertical: TextAlignVertical.top,
            controller: widget.controller,
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}

