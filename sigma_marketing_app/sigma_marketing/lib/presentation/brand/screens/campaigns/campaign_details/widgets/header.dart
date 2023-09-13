import 'package:flutter/material.dart';
import 'package:sigma_marketing/presentation/brand/screens/edit_campaign/edit_campaign_screen.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_button/custom_button.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_status/custom_status.dart';

import '../../../../../../config/style/custom_text_style.dart';
import '../../../../../../data/models/response/base/base_status.dart';

class CampaignHeader extends StatelessWidget {
  final String title;
  final int campaignId;
  final BaseStatus status;

  const CampaignHeader({
    required this.title,
    required this.campaignId,
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: CustomTextStyle.semiBoldText(18),
        ),
        const SizedBox(width: 32),
        CustomStatus(status: status),
        Expanded(child: Container()),
        CustomButton(text: 'Manage', onPressed: () {
          _navigateToManage(context);
        }),
      ],
    );
  }

  void _navigateToManage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            EditCampaignScreen(campaignId: campaignId,),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
              position: offsetAnimation, child: child);
        },
      ),
    );
  }
}
