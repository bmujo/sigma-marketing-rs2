import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';

import '../../../../utils/utils.dart';

class UserStatus extends StatelessWidget {
  final int status;

  const UserStatus({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: getColorForUserStatus(status),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
          getLabelForUserStatus(status),
          style: CustomTextStyle.mediumText(14)
      ),
    );
  }
}