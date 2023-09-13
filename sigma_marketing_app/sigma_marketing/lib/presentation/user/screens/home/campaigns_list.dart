import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/user/campaign/campaigns/campaigns_bloc.dart';
import '../../../common/widgets/bottom_loader/bottom_loader.dart';
import '../campaign_details/campaign_details_screen.dart';
import 'campaigns_item.dart';

class CampaignsList extends StatefulWidget {
  const CampaignsList({super.key});

  @override
  State<CampaignsList> createState() => _CampaignsListState();
}

class _CampaignsListState extends State<CampaignsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignsBloc, CampaignsState>(
      builder: (context, state) {
        switch (state.status) {
          case CampaignsStatus.failure:
            return const Center(child: Text('failed to fetch campaigns'));
          case CampaignsStatus.success:
            if (state.campaigns.isEmpty) {
              return const Center(child: Text('no campaigns'));
            }
            return Expanded(
                child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (!state.hasReachedMax &&
                    index >= state.campaigns.length - 1) {
                  return const BottomLoader();
                }
                return CampaignListItem(
                  onCampaignTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CampaignDetailsScreen(
                            campaignId: state.campaigns[index].id,
                            onLikeStatusChanged: (isLiked) {
                              setState(() {
                                state.campaigns[index].liked = !isLiked;
                                state.campaigns[index].likes =
                                    isLiked ? state.campaigns[index].likes - 1 : state.campaigns[index].likes + 1;
                              });
                            }),
                      ),
                    );
                  },
                  campaign: state.campaigns[index],
                  onLikeTap: () {
                    final campaignsBloc = context.read<CampaignsBloc>();
                    var campaign = state.campaigns[index];
                    campaignsBloc.add(ToggleLikeCampaign(
                        campaignId: campaign.id, liked: !campaign.liked));
                  },
                );
              },
              itemCount: state.hasReachedMax
                  ? state.campaigns.length
                  : state.campaigns.length + 1,
              controller: _scrollController,
            ));
          case CampaignsStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom)
      context.read<CampaignsBloc>().add(CampaignsFetched(query: ""));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
