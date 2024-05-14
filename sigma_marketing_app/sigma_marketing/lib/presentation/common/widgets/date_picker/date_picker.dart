import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';

import '../../../../utils/colors/colors.dart';
import '../../../../utils/constants/constants.dart';

class DatePicker extends StatelessWidget {
  final String title;
  final String hintText;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final String errorMessage;
  final bool showError;

  const DatePicker({
    required this.title,
    required this.hintText,
    required this.selectedDate,
    required this.onDateSelected,
    required this.errorMessage,
    required this.showError,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomLabel(title: title),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: Container(
                  height: 50, // Set the desired height here
                  decoration: BoxDecoration(
                    color: SMColors.secondMain,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    style: GoogleFonts.getFont(
                      UtilConstants.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: SMColors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      suffixIcon: const Icon(Icons.date_range),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                    ),
                    textAlignVertical: TextAlignVertical.top,
                    controller: TextEditingController(
                      text: selectedDate != null
                          ? DateFormat.yMMMd().format(selectedDate!)
                          : '',
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Visibility(
              visible: showError,
              child: const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                'Please select start date',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ))),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
    }
  }
}
