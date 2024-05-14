import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';

import '../../../../../data/models/response/campaign/campaign_details.dart';
import '../../../../../utils/colors/colors.dart';

class CampaignDuration extends StatefulWidget {
  const CampaignDuration({
    Key? key,
    required this.campaignDetails,
  }) : super(key: key);

  final CampaignDetails campaignDetails;

  @override
  _CampaignDurationState createState() => _CampaignDurationState();
}

class _CampaignDurationState extends State<CampaignDuration> {
  int days = 0;
  String startDate = "";
  String endDate = "";

  @override
  void initState() {
    super.initState();
    final start = widget.campaignDetails.start;
    final end = widget.campaignDetails.end;
    days = (end.difference(start).inSeconds) ~/ Duration.secondsPerDay;

    startDate = DateFormat("dd.MM.yyyy").format(start);
    endDate = DateFormat("dd.MM.yyyy").format(end);
  }

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
          Row(
            children: [
              const CustomLabel(title: "DURATION"),
              Expanded(child: Container()),
              Text("days: $days", style: CustomTextStyle.regularText(12)),
            ],
          ),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          Row(children: [
            Text("Start date", style: CustomTextStyle.mediumText(14)),
            Expanded(child: Container()),
            Text(startDate, style: CustomTextStyle.regularText(14)),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Text("End date", style: CustomTextStyle.mediumText(14)),
            Expanded(child: Container()),
            Text(endDate, style: CustomTextStyle.regularText(14)),
          ]),
        ],
      ),
    );
  }
}
