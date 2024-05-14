import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/colors/colors.dart';
import '../../../../utils/constants/constants.dart';

class CustomLabel extends StatelessWidget {
  final String title;

  const CustomLabel({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Text(
        title,
        style: GoogleFonts.getFont(
          UtilConstants.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          color: SMColors.white,
        ),
      ),
    );
  }
}
