import 'package:flutter/material.dart';
import 'package:sigma_marketing/data/models/response/brand/campaign/campaign_brand.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_status/custom_status.dart';

import '../../../../../config/style/custom_text_style.dart';
import '../../../../../utils/colors/colors.dart';

class CampaignItem extends StatelessWidget {
  final int? index;
  final int? selectedCampaignIndex;
  final CampaignBrand campaign;
  final ValueSetter<int?> onSelect;

  const CampaignItem({
    required this.index,
    required this.selectedCampaignIndex,
    required this.campaign,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedCampaignIndex;
    return GestureDetector(
        onTap: () {
          if (isSelected) {
            onSelect(null); // Deselect the item
          } else {
            onSelect(index); // Select the item
          }
        },
        child: Container(
          margin: isSelected
              ? const EdgeInsets.only(left: 16, top: 16, right: 0, bottom: 16)
              : const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? SMColors.secondMain : SMColors.main,
            borderRadius: isSelected
                ? const BorderRadius.only(
                    topLeft: Radius.circular(11),
                    bottomLeft: Radius.circular(11))
                : BorderRadius.circular(11),
            border: Border.all(color: SMColors.secondMain, width: 0.0),
          ),
          child: Column(children: [
            ClipRRect(
              borderRadius: isSelected
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(campaign.imageUrl, fit: BoxFit.cover),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  children: [
                    Column(children: [
                      Text(
                        campaign.title,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.mediumText(16),
                      ),
                    ],),
                    const Spacer(),
                    CustomStatus(status: campaign.status),
                  ],
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
                child: Row(
                  children: [
                    Text(
                      'Likes: ${campaign.likes}',
                      style: CustomTextStyle.regularText(14),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Influencers: ${campaign.influencers}',
                      style: CustomTextStyle.regularText(14),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ))
          ]),
        ));
  }
}
