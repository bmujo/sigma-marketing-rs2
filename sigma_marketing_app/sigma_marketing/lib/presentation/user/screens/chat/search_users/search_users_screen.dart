import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/style/custom_text_style.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../../blocs/common/chat/search_users/search_users_bloc.dart';
import '../chat_details/chat_details_screen.dart';
import 'package:sigma_marketing/data/models/response/user/search_user.dart';

class SearchUsersScreen extends StatefulWidget {
  const SearchUsersScreen({Key? key}) : super(key: key);

  @override
  _SearchUsersScreenState createState() => _SearchUsersScreenState();
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SMColors.main,
      appBar: AppBar(
        backgroundColor: SMColors.main,
        centerTitle: true,
        title: Text('Start New Chat', style: CustomTextStyle.semiBoldText(20)),
        leading: IconButton(
          icon: const IconTheme(
            data: IconThemeData(color: SMColors.white),
            child: BackButtonIcon(),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => SearchUsersBloc(),
        child: BlocBuilder<SearchUsersBloc, SearchUsersState>(
          builder: (context, state) {
            if (state is SearchUsersInitial) {
              BlocProvider.of<SearchUsersBloc>(context)
                  .add(const GetUsersEvent(query: "a"));
            } else if (state is SearchUsersLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      style: CustomTextStyle.regularText(16),
                      controller: _searchController,
                      decoration: InputDecoration(
                        fillColor: SMColors.secondMain,
                        filled: true,
                        hintText: 'Search users',
                        prefixIconColor: SMColors.hintColor,
                        hintStyle:
                            CustomTextStyle.regularText(16, SMColors.hintColor),
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (query) {
                        if (query.isEmpty) {
                          query = 'a';
                        }
                        _debouncer.run(() {
                          BlocProvider.of<SearchUsersBloc>(context)
                              .add(GetUsersEvent(query: query));
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.imageUrl),
                          ),
                          title: Text('${user.firstName} ${user.lastName}',
                              style: CustomTextStyle.mediumText(16)),
                          onTap: () {
                            _navigateToStartChat(context, user);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is SearchUsersError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void _navigateToStartChat(BuildContext context, SearchUser user) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration:
            const Duration(milliseconds: 300),
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                ChatDetailsScreen(user: user),
        transitionsBuilder: (context, animation,
            secondaryAnimation, child) {
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
      ),
    );
  }
}

class Debouncer {
  final Duration delay;
  VoidCallback? _callback;
  Timer? _timer;

  Debouncer({required this.delay});

  void run(VoidCallback callback) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(delay, () {
      callback();
    });
  }
}
