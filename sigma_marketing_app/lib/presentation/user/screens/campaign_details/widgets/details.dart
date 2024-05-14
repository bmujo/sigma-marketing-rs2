import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';

import '../../../../../data/models/response/campaign/campaign_details.dart';
import '../../../../../utils/colors/colors.dart';

class Details extends StatefulWidget {
  const Details({
    Key? key,
    required this.campaignDetails,
  }) : super(key: key);

  final CampaignDetails campaignDetails;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: SMColors.secondMain,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomLabel(title: "DETAILS"),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          Text(widget.campaignDetails.details, style: CustomTextStyle.regularText(14)),
        ],
      ),
    );
  }
}