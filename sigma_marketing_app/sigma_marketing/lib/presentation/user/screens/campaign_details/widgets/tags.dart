import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';

import '../../../../../data/models/response/campaign/campaign_details.dart';
import '../../../../../utils/colors/colors.dart';

class Tags extends StatefulWidget {
  const Tags({
    Key? key,
    required this.campaignDetails,
  }) : super(key: key);

  final CampaignDetails campaignDetails;

  @override
  _TagsState createState() => _TagsState();
}

class _TagsState extends State<Tags> {
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
          const CustomLabel(title: "TAGS"),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          Wrap(
            children: _buildChips(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChips() {
    return widget.campaignDetails.tags.map<Widget>((tag) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Chip(
          backgroundColor: SMColors.primaryColor,
          label: Text(tag, style: CustomTextStyle.regularText(14)),
        ),
      );
    }).toList();
  }
}