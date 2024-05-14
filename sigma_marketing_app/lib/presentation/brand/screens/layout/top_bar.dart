import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/blocs/brand/notification/notification_number_bloc.dart';
import 'package:sigma_marketing/presentation/brand/screens/new_campaign/new_campaign_screen.dart';
import 'package:sigma_marketing/blocs/user/notification/notification_bloc.dart';
import 'package:sigma_marketing/presentation/user/screens/profile/profile_screen.dart';

import '../../../../utils/colors/colors.dart';
import '../../../common/widgets/notification/item_notification.dart';
import '../profile/profile_brand_screen.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late NotificationNumberBloc _notificationNumberBloc;
  late NotificationBloc _notificationBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _notificationNumberBloc = NotificationNumberBloc();
    _notificationNumberBloc.add(NotificationNumberFetched());

    _notificationBloc = NotificationBloc();
    _notificationBloc.add(NotificationFetched());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _notificationNumberBloc.close();
    _notificationBloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
      } else {
        context.read<NotificationBloc>().add(NotificationFetched());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationBloc>(
      create: (context) => _notificationBloc,
      child: Container(
        decoration: const BoxDecoration(
          color: SMColors.main,
          border: Border(
            left: BorderSide(
              color: SMColors.borderColor,
              width: 1.0,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => NewCampaignScreen(),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: SMColors.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              child: const Text('New Campaign'),
            ),
            Expanded(child: Container()),
            _buildNotificationButton(context),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => ProfileBrandScreen());
              },
              icon: const Icon(Icons.person),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationButton(BuildContext context) {
    return StreamBuilder<int>(
        stream: _notificationNumberBloc.unreadNotificationsStream,
        builder: (context, snapshot) {
          var numberOfUnreadNotifications = 0;
          if (snapshot.hasData) {
            numberOfUnreadNotifications = snapshot.data!;
          }
          return IconButton(
            onPressed: () {
              showNotificationsMenu(context);
            },
            icon: Stack(
              clipBehavior: Clip.values[0],
              children: [
                const Icon(Icons.notifications, color: Colors.white),
                numberOfUnreadNotifications > 0
                    ? Positioned(
                        top: -6,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            numberOfUnreadNotifications.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        });
  }
}

void showNotificationsMenu(BuildContext context) {
  if (context.read<NotificationBloc>().state.notifications.isEmpty) {
    return;
  }

  showMenu(
      context: context,
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      position: const RelativeRect.fromLTRB(50, 50, 0, 0).shift(Offset.zero),
      color: SMColors.thirdMain,
      items: context
          .read<NotificationBloc>()
          .state
          .notifications
          .map((notification) {
        return PopupMenuItem(
          padding: EdgeInsets.zero,
          child: ItemNotification(
            notification: notification,
            onNotificationTap: () {
              context
                  .read<NotificationBloc>()
                  .add(SetNotificationOpen(notificationId: notification.id));
              Navigator.pop(context);
            },
          ),
        );
      }).toList());
}
