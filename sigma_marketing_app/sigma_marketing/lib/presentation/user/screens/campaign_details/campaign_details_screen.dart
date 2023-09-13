import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/presentation/user/screens/campaign_details/widgets/achievements.dart';
import 'package:sigma_marketing/presentation/user/screens/campaign_details/widgets/campaign_duration.dart';
import 'package:sigma_marketing/presentation/user/screens/campaign_details/widgets/campaign_video.dart';
import 'package:sigma_marketing/presentation/user/screens/campaign_details/widgets/company_info.dart';
import 'package:sigma_marketing/presentation/user/screens/campaign_details/widgets/details.dart';
import 'package:sigma_marketing/presentation/user/screens/campaign_details/widgets/location.dart';
import 'package:sigma_marketing/presentation/user/screens/campaign_details/widgets/open_positions.dart';
import 'package:sigma_marketing/presentation/user/screens/campaign_details/widgets/photos.dart';
import 'package:sigma_marketing/presentation/user/screens/campaign_details/widgets/tags.dart';
import 'package:sigma_marketing/presentation/user/screens/campaign_details/widgets/track_your_state.dart';
import '../../../../config/style/custom_text_style.dart';
import '../../../../data/models/request/campaign/campaign_state.dart';
import '../../../../data/models/response/campaign/campaign_details.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/enums/campaign_user_status.dart';
import '../../../../blocs/user/campaign/campaign_details/campaign_details_bloc.dart';

class CampaignDetailsScreen extends StatefulWidget {
  final int campaignId;
  final Function(bool) onLikeStatusChanged;

  CampaignDetailsScreen({
    required this.campaignId,
    required this.onLikeStatusChanged,
  });

  @override
  _CampaignDetailsScreenState createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  CampaignState campaignState = CampaignState(
    campaignId: 0,
    campaignUserStatus: 0,
    isUpdateStatus: false,
    liked: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SMColors.main,
      appBar: _campaignDetailsAppBar(context),
      body: BlocProvider(
        create: (context) => CampaignDetailsBloc(),
        child: BlocBuilder<CampaignDetailsBloc, CampaignDetailsState>(
          builder: (context, state) {
            if (state is CampaignDetailsInitial) {
              BlocProvider.of<CampaignDetailsBloc>(context)
                  .add(GetCampaignDetailsEvent(id: widget.campaignId));
            } else if (state is CampaignDetailsLoaded) {
              final campaignDetails = state.campaignDetails;
              campaignState = CampaignState(
                campaignId: campaignDetails.id,
                campaignUserStatus: campaignDetails.campaignUserStatus,
                isUpdateStatus: false,
                liked: campaignDetails.liked,
              );
              return SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(state, context),
                        TrackYourState(campaignDetails: campaignDetails),
                        const SizedBox(height: 16),
                        CompanyInfo(campaignDetails: campaignDetails),
                        const SizedBox(height: 16),
                        Location(campaignDetails: campaignDetails),
                        const SizedBox(height: 16),
                        Details(campaignDetails: campaignDetails),
                        const SizedBox(height: 16),
                        OpenPositions(campaignDetails: campaignDetails),
                        const SizedBox(height: 16),
                        CampaignDuration(campaignDetails: campaignDetails),
                        const SizedBox(height: 16),
                        Photos(campaignDetails: campaignDetails),
                        const SizedBox(height: 16),
                        CampaignVideo(campaignDetails: campaignDetails),
                        const SizedBox(height: 16),
                        Tags(campaignDetails: campaignDetails),
                        const SizedBox(height: 16),
                        Achievements(campaignDetails: campaignDetails),
                        const Divider(
                          color: SMColors.lightGrey,
                          thickness: 3,
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, top: 30, right: 20, bottom: 20),
                          child: _buildActionButton(
                              context,
                              state.campaignDetails,
                              BlocProvider.of<CampaignDetailsBloc>(context)),
                        ),
                      ],
                    )),
              );
            } else if (state is CampaignDetailsError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.blue),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Column _buildHeader(CampaignDetailsLoaded state, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.campaignDetails.title,
                style: CustomTextStyle.semiBoldText(20)
              ),
              Row(
                children: [
                  Text(
                    state.campaignDetails.likes.toString(),
                    style: CustomTextStyle.mediumText(14),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: state.campaignDetails.liked
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_border, color: SMColors.white),
                    onPressed: () {
                      campaignState.isUpdateStatus = false;
                      campaignState.liked = !state.campaignDetails.liked;
                      BlocProvider.of<CampaignDetailsBloc>(context).add(
                          OnCampaignUpdateEvent(campaignState: campaignState));
                      widget.onLikeStatusChanged(state.campaignDetails.liked);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Action buttons
  Widget _buildActionButton(BuildContext context,
      CampaignDetails campaignDetails, CampaignDetailsBloc bloc) {
    return Visibility(
        visible: getActionButtonVisibility(campaignDetails.campaignUserStatus),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              foregroundColor: SMColors.white,
              backgroundColor:
                  getActionButtonColor(campaignDetails.campaignUserStatus),
            ),
            onPressed: () {
              campaignState.isUpdateStatus = true;
              if (campaignDetails.campaignUserStatus ==
                  CampaignUserStatus.initial.index) {
                campaignState.campaignUserStatus =
                    CampaignUserStatus.requested.index;
              }

              if (campaignDetails.campaignUserStatus ==
                  CampaignUserStatus.requested.index) {
                campaignState.campaignUserStatus =
                    CampaignUserStatus.initial.index;
              }

              bloc.add(OnCampaignUpdateEvent(campaignState: campaignState));
            },
            child: Text(
              getActionButtonText(campaignDetails.campaignUserStatus),
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ));
  }

  String getActionButtonText(int status) {
    final innerStatus = CampaignUserStatus.values[status];
    switch (innerStatus) {
      case CampaignUserStatus.initial:
        return 'Request to Join';
      case CampaignUserStatus.requested:
        return 'Cancel Request';
      case CampaignUserStatus.invited:
        return 'Accept Invitation';
      case CampaignUserStatus.denied:
        return 'Request to Join';
      case CampaignUserStatus.accepted:
        return 'Start Campaign';
      case CampaignUserStatus.inProgress:
        return 'Complete Campaign';
      case CampaignUserStatus.completed:
        return 'Campaign Completed';
      case CampaignUserStatus.payedOut:
        return 'Campaign Completed';
      default:
        return 'Request to Join';
    }
  }

  Color getActionButtonColor(int status) {
    final innerStatus = CampaignUserStatus.values[status];
    switch (innerStatus) {
      case CampaignUserStatus.initial:
        return SMColors.primaryColor;
      case CampaignUserStatus.requested:
        return SMColors.blue;
      case CampaignUserStatus.invited:
        return SMColors.primaryColor;
      case CampaignUserStatus.denied:
        return SMColors.primaryColor;
      case CampaignUserStatus.accepted:
        return SMColors.primaryColor;
      case CampaignUserStatus.inProgress:
        return SMColors.primaryColor;
      case CampaignUserStatus.completed:
        return SMColors.primaryColor;
      case CampaignUserStatus.payedOut:
        return SMColors.primaryColor;
      default:
        return SMColors.primaryColor;
    }
  }

  bool getActionButtonVisibility(int status) {
    final innerStatus = CampaignUserStatus.values[status];
    switch (innerStatus) {
      case CampaignUserStatus.initial:
        return true;
      case CampaignUserStatus.requested:
        return true;
      case CampaignUserStatus.invited:
        return true;
      case CampaignUserStatus.denied:
        return true;
      case CampaignUserStatus.accepted:
        return false;
      case CampaignUserStatus.inProgress:
        return false;
      case CampaignUserStatus.completed:
        return false;
      case CampaignUserStatus.payedOut:
        return false;
      default:
        return false;
    }
  }

  AppBar _campaignDetailsAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: SMColors.main,
      centerTitle: true,
      title: Text('Campaign Details',
          style: CustomTextStyle.boldText(20)),
      leading: IconButton(
        icon: const IconTheme(
          data: IconThemeData(color: SMColors.white),
          child: BackButtonIcon(),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
