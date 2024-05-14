import 'package:flutter/material.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_label/custom_label.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../data/models/response/campaign/campaign_details.dart';
import '../../../../../utils/colors/colors.dart';

class CampaignVideo extends StatefulWidget {
  const CampaignVideo({
    Key? key,
    required this.campaignDetails,
  }) : super(key: key);

  final CampaignDetails campaignDetails;

  @override
  _CampaignVideoState createState() => _CampaignVideoState();
}

class _CampaignVideoState extends State<CampaignVideo> {
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
          const CustomLabel(title: "VIDEO"),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          Container(
            padding:
            const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 20),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId:
                YoutubePlayer.convertUrlToId(widget.campaignDetails.videoUrl) ??
                    '',
                flags: const YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
            ),
          )
        ],
      ),
    );
  }
}