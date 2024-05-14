import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import 'package:sigma_marketing/data/models/response/brand/campaign_details/influencer.dart';
import 'package:sigma_marketing/data/models/response/user/search_user.dart';
import 'package:sigma_marketing/presentation/common/widgets/custom_button/custom_button.dart';
import '../../../../../blocs/common/chat/search_users/search_users_bloc.dart';
import '../../../../../data/models/request/invite/invite.dart';
import '../../../../../data/models/response/base/base_status.dart';
import '../../../../../utils/colors/colors.dart';

class InviteInfluencersDialog extends StatefulWidget {
  final List<Influencer> alreadyInvitedInfluencers;
  final int campaignId;

  const InviteInfluencersDialog(
      {Key? key,
      required this.alreadyInvitedInfluencers,
      required this.campaignId})
      : super(key: key);

  @override
  _InviteInfluencersDialogState createState() =>
      _InviteInfluencersDialogState();
}

class _InviteInfluencersDialogState extends State<InviteInfluencersDialog> {
  List<SearchUser> users = [];
  List<Influencer> invitedInfluencers = [];

  final _searchTextController = TextEditingController();

  late SearchUsersBloc _searchUsersBloc;

  @override
  void initState() {
    for (var element in widget.alreadyInvitedInfluencers) {
      users.removeWhere((tag) => tag.id == element.id);
    }

    _searchUsersBloc = SearchUsersBloc();
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(20),
            color: SMColors.secondMain.withOpacity(0.8),
            child: BlocBuilder<SearchUsersBloc, SearchUsersState>(
              bloc: _searchUsersBloc,
              builder: (context, state) {
                if (state is SearchUsersInitial) {
                  return _buildContent(context);
                } else if (state is SearchUsersLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchUsersLoaded) {
                  users = state.users;
                  return _buildContent(context);
                } else if (state is SearchUsersError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is InviteUsers) {
                  return Center(
                    child: Text(
                      'Inviting...',
                      style: CustomTextStyle.mediumText(16),
                    ),
                  );
                } else if (state is InviteUsersDone) {
                  Navigator.of(context).pop(invitedInfluencers);
                  return Center(
                    child: Text(
                      'Invited',
                      style: CustomTextStyle.mediumText(16),
                    ),
                  );
                } else if (state is InviteUsersError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _buildHeader(context),
        const SizedBox(height: 16),
        _buildSearchField(),
        const SizedBox(height: 16),
        _buildInfluencersList(),
        const SizedBox(height: 16),
        _buildAddButton(),
        const SizedBox(height: 16),
        const Divider(
          color: SMColors.white,
          height: 1,
        ),
        const SizedBox(height: 8),
        _buildAddedInfluencers(),
      ]),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Invite Influencers',
            style: CustomTextStyle.semiBoldText(20),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.close,
            color: SMColors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: SMColors.secondMain,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _searchTextController,
        onChanged: (query) {
          _searchUsersBloc.add(GetUsersEvent(query: query));
        },
        decoration: const InputDecoration(
          hintText: 'Search for influencers',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildInfluencersList() {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: SMColors.secondMain,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Row(children: [
            CircleAvatar(backgroundImage: NetworkImage(user.imageUrl)),
            const SizedBox(width: 8),
            Text('${user.firstName} ${user.lastName}'),
            const Spacer(),
            CustomButton(
                text: 'Add',
                onPressed: () {
                  setState(() {
                    final influencer = convertSearchUserToInfluencer(user);
                    invitedInfluencers.add(influencer);
                    users.remove(user);
                  });
                }),
          ]);
        },
      ),
    );
  }

  Influencer convertSearchUserToInfluencer(SearchUser user) {
    return Influencer(
      id: user.id,
      imageUrl: user.imageUrl,
      firstName: user.firstName,
      lastName: user.lastName,
      status: BaseStatus(
        value: 0,
        name: "Invited",
        color: "",
      ),
      currentEarningSigma: 0,
      currentEarningCash: 0,
      achievements: [],
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: SMColors.white,
        backgroundColor: SMColors.primaryColor,
      ),
      onPressed: () {
        if (invitedInfluencers.isEmpty) return;

        final invite = Invite(
          campaignId: widget.campaignId,
          users: invitedInfluencers.map((e) => e.id).toList(),
        );

        _searchUsersBloc.add(InviteUsersEvent(invite: invite));
      },
      child: Text('Invite all selected influencers'),
    );
  }

  Widget _buildAddedInfluencers() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(invitedInfluencers.length, (index) {
        final user = invitedInfluencers[index];
        return Row(children: [
          CircleAvatar(backgroundImage: NetworkImage(user.imageUrl)),
          const SizedBox(width: 8),
          Text('${user.firstName} ${user.lastName}'),
          const Spacer(),
          CustomButton(
              text: 'Remove',
              onPressed: () {
                setState(() {
                  invitedInfluencers.remove(user);
                });
              }),
        ]);
      }),
    );
  }
}
