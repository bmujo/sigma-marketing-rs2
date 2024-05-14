import 'package:flutter/material.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';

import '../../../../../data/models/response/campaign/campaign_details.dart';
import '../../../../../utils/colors/colors.dart';

class CompanyInfo extends StatefulWidget {
  const CompanyInfo({
    Key? key,
    required this.campaignDetails,
  }) : super(key: key);

  final CampaignDetails campaignDetails;

  @override
  _CompanyInfoState createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {
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
          CustomLabel(title: "by ${widget.campaignDetails.company}"),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  widget.campaignDetails.companyImageUrl,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Text(widget.campaignDetails.companyBio,
                      style: CustomTextStyle.regularText(14))),
            ],
          )
        ],
      ),
    );
  }
}
