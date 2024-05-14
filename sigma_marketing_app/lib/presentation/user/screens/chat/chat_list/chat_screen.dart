import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/config/style/custom_text_style.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../../blocs/common/chat/chat_list/chat_list_bloc.dart';
import '../search_users/search_users_screen.dart';
import 'chat_list.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatListBloc()..add(ChatListFetched()),
      child: Scaffold(
        backgroundColor: SMColors.main,
        appBar: AppBar(
            backgroundColor: SMColors.main,
            centerTitle: true,
            title: Text('Chat', style: CustomTextStyle.semiBoldText(20))),
        body: const ChatList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: SMColors.primaryColor,
          onPressed: () {
            _navigateToSearch(context);
          },
          child: const Icon(Icons.message),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void _navigateToSearch(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SearchUsersScreen(),
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
      ),
    ).then((value) =>
        {context.read<ChatListBloc>().add(ChatListRefresh())});
  }
}
