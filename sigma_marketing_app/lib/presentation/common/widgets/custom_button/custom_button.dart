import 'package:flutter/material.dart';

import '../../../../utils/colors/colors.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Color backgroundColor;
  final bool disabled;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    this.text = 'Click',
    this.backgroundColor = SMColors.primaryColor,
    this.disabled = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late String buttonText;
  late Color buttonColor;
  bool isDisabled = false;

  @override
  void initState() {
    super.initState();
    buttonText = widget.text;
    buttonColor = widget.backgroundColor;
    isDisabled = widget.disabled;
  }

  void updateButton(String text, Color color, bool disabled) {
    setState(() {
      buttonText = text;
      buttonColor = color;
      isDisabled = disabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: isDisabled ? null : widget.onPressed,
      child: Text(buttonText),
    );
  }
}
