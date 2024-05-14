import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/style/custom_text_style.dart';
import '../../../../utils/colors/colors.dart';
import '../../../common/widgets/bottom_loader/bottom_loader.dart';
import '../../../common/widgets/notification/item_notification.dart';
import '../../../../blocs/user/notification/notification_bloc.dart';
import '../../../common/dialogs/dialogs.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _scrollController = ScrollController();
  late NotificationBloc _notificationsBloc;

  @override
  void initState() {
    super.initState();
    _notificationsBloc = NotificationBloc();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SMColors.main,
      appBar: AppBar(
          backgroundColor: SMColors.main,
          centerTitle: true,
          title:
              Text('Notifications', style: CustomTextStyle.semiBoldText(20))),
      body: BlocProvider(
        create: (_) => _notificationsBloc..add(NotificationFetched()),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            switch (state.status) {
              case NotificationStatus.failure:
                return Center(
                    child: Text('failed to fetch notifications',
                        style: CustomTextStyle.semiBoldText(14)));
              case NotificationStatus.success:
                if (state.notifications.isEmpty) {
                  return Center(
                      child: Text('no notifications',
                          style: CustomTextStyle.semiBoldText(14)));
                }
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (!state.hasReachedMax &&
                        index >= state.notifications.length - 1) {
                      return const BottomLoader();
                    }
                    return ItemNotification(
                      notification: state.notifications[index],
                      onNotificationTap: () {
                        _notificationsBloc.add(SetNotificationOpen(
                            notificationId: state.notifications[index].id));
                        showMessageDialog(
                            context,
                            state.notifications[index].title,
                            state.notifications[index].message);
                      },
                    );
                  },
                  itemCount: state.hasReachedMax
                      ? state.notifications.length
                      : state.notifications.length + 1,
                  controller: _scrollController,
                );
              case NotificationStatus.initial:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
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
    if (_isBottom) _notificationsBloc.add(NotificationFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
