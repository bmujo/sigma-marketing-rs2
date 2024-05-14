import 'package:flutter/material.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';

import '../../../../../data/models/response/campaign/campaign_details.dart';
import '../../../../../utils/colors/colors.dart';

class TrackYourState extends StatefulWidget {
  const TrackYourState({
    Key? key,
    required this.campaignDetails,
  }) : super(key: key);

  final CampaignDetails campaignDetails;

  @override
  _TrackYourStateState createState() => _TrackYourStateState();
}

class _TrackYourStateState extends State<TrackYourState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: SMColors.thirdMain,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.fromBorderSide(BorderSide(color: SMColors.primaryColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(title: "TRACK YOUR STATE"),
          const Divider(
            color: SMColors.white,
            thickness: 1,
          ),
          Row(children: [
            Text("25.08.2023 23:51"),
            const SizedBox(width: 5),
            Expanded(child: Text("Campaign will be completed in 2 days")),
          ],),
          Divider(
            color: SMColors.dividerColor,
            thickness: 1,
          ),
          Row(children: [
            Text("25.08.2023 23:51"),
            const SizedBox(width: 5),
            Expanded(child: Text("Campaign will be completed in 2 days")),
          ],),
          Divider(
            color: SMColors.dividerColor,
            thickness: 1,
          ),
          Row(children: [
            Text("25.08.2023 23:51"),
            const SizedBox(width: 5),
            Expanded(child: Text("Campaign will be completed in 2 days")),
          ],),
          Divider(
            color: SMColors.dividerColor,
            thickness: 1,
          ),
          Row(children: [
            Text("25.08.2023 23:51"),
            const SizedBox(width: 5),
            Expanded(child: Text("Campaign will be completed in 2 days")),
          ],)
        ],
      ),
    );
  }
}