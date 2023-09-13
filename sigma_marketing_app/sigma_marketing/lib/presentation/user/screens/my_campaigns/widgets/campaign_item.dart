import 'package:flutter/material.dart';

import '../../../../../config/style/custom_text_style.dart';
import '../../../../../data/models/response/campaign/my_campaign_item.dart';
import '../../../../../utils/colors/colors.dart';

enum CampaignCardType {
  requested,
  inProgress,
  finished,
}

class CampaignItem extends StatefulWidget {
  final MyCampaignItem campaign;
  final void Function() onCampaignTap;
  final CampaignCardType campaignCardType;

  const CampaignItem({
    Key? key,
    required this.campaign,
    required this.onCampaignTap,
    required this.campaignCardType,
  }) : super(key: key);

  static Widget fromCampaign(MyCampaignItem campaign,
      CampaignCardType campaignCardType, void Function() onCampaignTap) {
    return CampaignItem(
      campaign: campaign,
      campaignCardType: campaignCardType,
      onCampaignTap: onCampaignTap,
    );
  }

  @override
  _CampaignItemState createState() => _CampaignItemState();
}

class _CampaignItemState extends State<CampaignItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this, // Add the SingleTickerProviderStateMixin to your state class
      duration: const Duration(milliseconds: 1500), // Set the duration of the animation
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onCampaignTap,
      child: Card(
        color: SMColors.secondMain,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.campaign.image,
                  height: 80.0,
                  width: 80.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.campaign.name,
                      style: CustomTextStyle.boldText(16),
                    ),
                    const SizedBox(height: 4.0),
                    _buildLocation(),
                    if (widget.campaignCardType == CampaignCardType.inProgress)
                      _buildProgress(),
                    if (widget.campaignCardType == CampaignCardType.finished)
                      _buildStars(),
                  ],
                ),
              ),
              if (widget.campaignCardType == CampaignCardType.requested)
                _buildStatus(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocation() {
    final location = widget.campaign.location.toUpperCase();
    return Row(children: [
      const Icon(Icons.location_on_outlined, color: SMColors.white, size: 16),
      const SizedBox(width: 4),
      Text(
        location,
        style: CustomTextStyle.mediumText(10),
      ),
      const SizedBox(width: 2),
      const Icon(Icons.api_rounded, color: SMColors.white, size: 8),
      const SizedBox(width: 2),
      Text(
        "RESTAURANT",
        style: CustomTextStyle.mediumText(10),
      ),
    ]);
  }

  Widget _buildStars() {
    return Column(children: [
      const SizedBox(height: 16),
      Row(
        children: List.generate(
          5,
          (index) => Icon(
            index < widget.campaign.stars ? Icons.star : Icons.star_border,
            color: index < widget.campaign.stars ? Colors.yellow : Colors.grey,
          ),
        ),
      ),
    ]);
  }

  Widget _buildProgress() {
    final maxProgress = widget.campaign.daysPassed.toDouble() /
        widget.campaign.days.toDouble();

    _progressController.forward();
    final progressAnimation = Tween(
      begin: 0.0,
      end: maxProgress,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.linear,
    ));

    return Column(
      children: [
        const SizedBox(height: 32),
        AnimatedBuilder(
          animation: progressAnimation,
          builder: (context, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: progressAnimation.value,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                backgroundColor: Colors.grey[300],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Card(
          color: widget.campaign.status == "Requested"
              ? SMColors.yellow
              : SMColors.green,
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.campaign.status,
              style: CustomTextStyle.regularText(12),
            ),
          ),
        )
      ],
    );
  }
}
