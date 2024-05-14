import 'package:flutter/material.dart';
import 'package:sigma_marketing/blocs/common/layout/layout_bloc.dart';
import '../../../../blocs/brand/notification/notification_number_bloc.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/icons/icons.dart';
import '../chat/chat_list/chat_screen.dart';
import '../home/home_screen.dart';
import '../my_campaigns/my_campaigns_screen.dart';
import '../notification/notifications_screen.dart';
import '../profile/profile_screen.dart';

class MobileLayout extends StatefulWidget {
  @override
  _MobileLayoutState createState() => _MobileLayoutState();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => MobileLayout());
  }
}

class _MobileLayoutState extends State<MobileLayout> {
  late LayoutBloc _layoutBloc;
  late NotificationNumberBloc _notificationNumberBloc;

  final List<Widget> _screens = [
    HomeScreen(),
    MyCampaignsScreen(),
    NotificationsScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  final Map<String, IconData> _icons = const {
    'Home': SMIcons.home,
    'My Campaigns': SMIcons.grid,
    'Notifications': SMIcons.bellNotification,
    'Chat': SMIcons.chat,
    'Profile': SMIcons.profile,
  };

  int _currentIndex = 0;

  @override
  void initState() {
    _layoutBloc = LayoutBloc();
    _layoutBloc.add(LayoutFetched());

    _notificationNumberBloc = NotificationNumberBloc();
    _notificationNumberBloc.add(NotificationNumberFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SMColors.main,
      body: _screens[_currentIndex],
      bottomNavigationBar: StreamBuilder<int>(
        stream: _layoutBloc.unreadMessagesStream,
        builder: (context, layoutSnapshot) {
          var numberOfUnreadMessages = 0;
          if (layoutSnapshot.hasData) {
            numberOfUnreadMessages = layoutSnapshot.data!;
          }

          return StreamBuilder<int>(
            stream: _notificationNumberBloc.unreadNotificationsStream,
            builder: (context, notificationSnapshot) {
              var numberOfUnreadNotifications = 0;
              if (notificationSnapshot.hasData) {
                numberOfUnreadNotifications = notificationSnapshot.data!;
              }

              return BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                items: _icons.map((title, icon) {
                  return MapEntry(
                    title,
                    BottomNavigationBarItem(
                      icon: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(icon),
                          if (title == 'Chat' && numberOfUnreadMessages > 0)
                            Positioned(
                              right: -5,
                              top: -5,
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '$numberOfUnreadMessages',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          if (title == 'Notifications' &&
                              numberOfUnreadNotifications > 0)
                            Positioned(
                              right: -5,
                              top: -5,
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '$numberOfUnreadNotifications',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                      label: "",
                      backgroundColor: SMColors.main,
                    ),
                  );
                }).values.toList(),
                currentIndex: _currentIndex,
                backgroundColor: SMColors.main,
                selectedItemColor: SMColors.primaryColor,
                unselectedItemColor: Colors.grey[600],
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
