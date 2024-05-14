import 'package:flutter/material.dart';
import 'package:sigma_marketing/presentation/brand/screens/campaigns/campaign_details/campaign_details.dart';
import 'package:sigma_marketing/presentation/brand/screens/campaigns/campaign_list/campaign_list.dart';

import '../../../../config/style/custom_text_style.dart';
import '../../../../utils/colors/colors.dart';

class CampaignsDesktopScreen extends StatefulWidget {
  const CampaignsDesktopScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const CampaignsDesktopScreen());
  }

  @override
  _CampaignsDesktopScreenState createState() => _CampaignsDesktopScreenState();
}

class _CampaignsDesktopScreenState extends State<CampaignsDesktopScreen> {
  int? selectedCampaignId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: SMColors.main, // Background color
                border: Border(
                  top: BorderSide(
                    color: SMColors.borderColor,
                    width: 1.0,
                  ),
                  left: BorderSide(
                    color: SMColors.borderColor,
                    width: 1.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(0),
              child: CampaignList(
                onSelect: (campaignId) {
                  setState(() {
                    selectedCampaignId = campaignId;
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: selectedCampaignId != null ? SMColors.secondMain : SMColors.main, // Background color
                border: const Border(
                  top: BorderSide(
                    color: SMColors.borderColor,
                    width: 1.0,
                  ),
                  left: BorderSide(
                    color: SMColors.borderColor,
                    width: 1.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: selectedCampaignId != null
                  ? CampaignDetails(
                      campaignId: selectedCampaignId!,
                      onDeselect: () {
                        setState(() {
                          selectedCampaignId = null;
                        });
                      },
                    )
                  : Center(
                      child: Text(
                        'Select campaign',
                        style: CustomTextStyle.semiBoldText(18),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
