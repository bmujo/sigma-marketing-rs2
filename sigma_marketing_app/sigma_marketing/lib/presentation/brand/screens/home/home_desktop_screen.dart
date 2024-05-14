import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';

import '../../../../utils/colors/colors.dart';

class HomeDesktopScreen extends StatefulWidget {
  const HomeDesktopScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeDesktopScreen());
  }

  @override
  _HomeDesktopScreenState createState() => _HomeDesktopScreenState();
}

class _HomeDesktopScreenState extends State<HomeDesktopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SMColors.main,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(flex: 1, child: topLeft()),
                Expanded(flex: 1, child: bottomLeft()),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(flex: 1, child: topRight()),
                Expanded(flex: 1, child: bottomRight()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget topLeft() {
    return Container(
      margin: const EdgeInsets.all(16),
      color: SMColors.secondMain,
      child: Center(
        child: Text("Top Left"),
      ),
    );
  }

  Widget topRight() {
    return Container(
      margin: const EdgeInsets.all(16),
      color: SMColors.main,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            color: SMColors.main,
            child: Center(
              child: CustomLabel(title: "Measurements"),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: SMColors.thirdMain,
              ),
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Total Active Campaigns",
                    style: CustomTextStyle.semiBoldText(16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "0",
                    style: CustomTextStyle.boldText(24),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: SMColors.thirdMain,
              ),
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Total Campaigns",
                    style: CustomTextStyle.semiBoldText(16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "0",
                    style: CustomTextStyle.boldText(24),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomLeft() {
    return Container(
      margin: const EdgeInsets.all(16),
      color: SMColors.secondMain,
      child: Center(
        child: Text("Bottom Left"),
      ),
    );
  }

  Widget bottomRight() {
    return Container(
      margin: const EdgeInsets.all(16),
      color: SMColors.main,
      child: Container(),
    );
  }
}
