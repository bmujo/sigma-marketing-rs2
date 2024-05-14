import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';

import '../../../../../data/models/response/user/search_user.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../../blocs/common/chat/search_users/search_users_bloc.dart';

class SearchBarUsers extends StatefulWidget {
  final void Function(SearchUser) onUserSelected;

  const SearchBarUsers({Key? key, required this.onUserSelected})
      : super(key: key);

  @override
  _SearchBarUsersState createState() => _SearchBarUsersState();
}

class _SearchBarUsersState extends State<SearchBarUsers> {
  final TextEditingController _searchController = TextEditingController();
  late SearchUsersBloc _searchUsersBloc;

  @override
  void initState() {
    super.initState();
    _searchUsersBloc = context.read<SearchUsersBloc>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchUsersBloc, SearchUsersState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (query) {
                  _searchUsersBloc.add(GetUsersEvent(query: query));
                },
                style: CustomTextStyle.regularText(14),
                decoration: InputDecoration(
                  fillColor: SMColors.inputDarkColor,
                  filled: true,
                  hintText: 'Search',
                  hintStyle:
                      CustomTextStyle.regularText(14, SMColors.hintColor),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 50,
                  ),
                  prefixIcon: Image.asset('assets/ic_input_search.png'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildUserList(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserList(SearchUsersState state) {
    if (state is SearchUsersLoaded) {
      final users = state.users;

      return Container(
        constraints: const BoxConstraints(maxHeight: 400),
        decoration: BoxDecoration(
          color: SMColors.inputDarkColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.imageUrl),
              ),
              title: Text('${user.firstName} ${user.lastName}',
                  style: CustomTextStyle.regularText(14)),
              onTap: () {
                final selectedUser = user;
                widget.onUserSelected(selectedUser);
                _searchController.text = '';
                _searchUsersBloc.add(GetUsersEvent(query: ''));
              },
            );
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
