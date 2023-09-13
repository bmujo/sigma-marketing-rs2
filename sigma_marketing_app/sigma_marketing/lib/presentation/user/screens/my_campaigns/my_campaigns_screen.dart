import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/data/models/response/campaign/my_campaign_item.dart';
import 'package:sigma_marketing/presentation/user/screens/my_campaigns/widgets/campaign_item.dart';

import '../../../../utils/colors/colors.dart';
import '../../../../blocs/user/campaign/my_campaigns/my_campaigns_bloc.dart';
import '../campaign_details/campaign_details_screen.dart';

class MyCampaignsScreen extends StatefulWidget {
  @override
  _MyCampaignsScreenState createState() => _MyCampaignsScreenState();
}

class _MyCampaignsScreenState extends State<MyCampaignsScreen> {
  @override
  Widget build(BuildContext context) {
    return const CustomTabBar();
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            MyCampaignsBloc()..add(const GetMyCampaignsEvent()),
        child: BlocBuilder<MyCampaignsBloc, MyCampaignsState>(
            builder: (context, state) {
          if (state is MyCampaignsLoaded) {
            return MaterialApp(
              color: SMColors.main,
              debugShowCheckedModeBanner: false,
              home: DefaultTabController(
                initialIndex: 1,
                length: 3,
                child: Scaffold(
                  backgroundColor: SMColors.main,
                  appBar: _buildAppBar(context),
                  body: TabBarView(
                    children: [
                      _buildCampaignList(
                          state.myCampaigns.finished,
                          (campaign) => CampaignItem.fromCampaign(
                                  campaign, CampaignCardType.finished, () {
                                _navigateToDetails(context, campaign);
                              })),
                      _buildCampaignList(
                          state.myCampaigns.inProgress,
                          (campaign) => CampaignItem.fromCampaign(
                                  campaign, CampaignCardType.inProgress, () {
                                _navigateToDetails(context, campaign);
                              })),
                      _buildCampaignList(
                          state.myCampaigns.requested,
                          (campaign) => CampaignItem.fromCampaign(
                                  campaign, CampaignCardType.requested, () {
                                _navigateToDetails(context, campaign);
                              })),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is MyCampaignsError) {
            return _buildErrorState(context);
          }
          return _buildLoadingState(context);
        }));
  }

  Widget _buildCampaignList(List<MyCampaignItem> campaigns,
      Widget Function(MyCampaignItem) itemBuilder) {
    return campaigns.isEmpty
        ? Center(
            child: Text('No campaigns yet',
                style: CustomTextStyle.regularText(14)))
        : ListView.builder(
            padding: const EdgeInsets.only(bottom: 80, top: 16),
            itemCount: campaigns.length,
            itemBuilder: (context, index) {
              final campaign = campaigns[index];
              return itemBuilder(campaign);
            },
          );
  }

  MaterialApp _buildLoadingState(BuildContext context) {
    return MaterialApp(
      color: SMColors.main,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          backgroundColor: SMColors.main,
          appBar: _buildAppBar(context),
          body: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return MaterialApp(
      color: SMColors.main,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          backgroundColor: SMColors.main,
          appBar: _buildAppBar(context),
          body: Center(
              child: Text('Error loading campaigns',
                  style: CustomTextStyle.regularText(14))),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: SMColors.main,
      centerTitle: true,
      bottom: TabBar(
        labelColor: SMColors.primaryColor,
        unselectedLabelColor: SMColors.dimBlack,
        indicatorColor: SMColors.primaryColor,
        labelStyle: CustomTextStyle.boldText(14),
        tabs: const [
          Tab(text: 'Finished'),
          Tab(text: 'In Progress'),
          Tab(text: 'Requested'),
        ],
      ),
      title: Text('My Campaigns', style: CustomTextStyle.regularText(14)),
    );
  }

  void _navigateToDetails(BuildContext context, MyCampaignItem campaign) {
    Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  CampaignDetailsScreen(
                campaignId: campaign.campaignId,
                onLikeStatusChanged: (isLiked) {},
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = const Offset(1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ))
        .then((value) =>
            {context.read<MyCampaignsBloc>().add(GetMyCampaignsEvent())});
  }
}
