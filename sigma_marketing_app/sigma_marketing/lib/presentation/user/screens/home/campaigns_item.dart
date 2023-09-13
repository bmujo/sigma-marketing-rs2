import 'package:flutter/material.dart';

import '../../../../config/style/custom_text_style.dart';
import '../../../../data/models/response/campaign/campaign.dart';
import '../../../../utils/colors/colors.dart';

class CampaignListItem extends StatefulWidget {
  const CampaignListItem({
    Key? key,
    required this.campaign,
    required this.onLikeTap,
    required this.onCampaignTap,
  }) : super(key: key);

  final Campaign campaign;
  final void Function() onLikeTap;
  final void Function() onCampaignTap;

  @override
  _CampaignListItemState createState() => _CampaignListItemState();
}

class _CampaignListItemState extends State<CampaignListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onCampaignTap,
      child: Card(
        color: SMColors.secondMain,
        margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  widget.campaign.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.campaign.title,
                      style: CustomTextStyle.boldText(18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.campaign.company,
                      style: CustomTextStyle.mediumText(12),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: widget.onLikeTap,
                          child: Icon(
                            widget.campaign.liked ? Icons.favorite : Icons.favorite_border,
                            color: widget.campaign.liked ? Colors.red[500] : SMColors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${widget.campaign.likes} Likes",
                          style: CustomTextStyle.mediumText(12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
