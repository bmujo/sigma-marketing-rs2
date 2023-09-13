import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';

import '../../../../data/models/response/base/base_status.dart';
import '../../../../utils/colors/colors.dart';

class CustomStatus extends StatelessWidget {
  final BaseStatus status;

  const CustomStatus({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = SMColors.primaryColor;
    try {
      color = Color(int.parse("0xFF${status.color}"));
    } catch (e) {}

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: CustomTextStyle.mediumText(14, color)
      ),
    );
  }
}
