import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../data/models/response/notification/notification_sigma.dart';
import '../../../data/repositories/repository_impl.dart';

part 'notification_event.dart';
part 'notification_state.dart';

const _notificationsLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final RepositoryImpl _repository = RepositoryImpl();
  int currentPage = 1;

  NotificationBloc() : super(const NotificationState()) {
    on<NotificationFetched>(
      _onNotificationFetched,
      transformer: throttleDroppable(throttleDuration),
    );

    on<SetNotificationOpen>(
      _onSetNotificationOpen,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onNotificationFetched(
      NotificationFetched event,
      Emitter<NotificationState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == NotificationStatus.initial) {
        currentPage = 1;
        final notifications = await _fetchNotifications();
        currentPage++;
        final hasMoreData = notifications.length == _notificationsLimit;
        return emit(
          state.copyWith(
            status: NotificationStatus.success,
            notifications: notifications,
            hasReachedMax: !hasMoreData,
          ),
        );
      }
      final notifications = await _fetchNotifications();
      currentPage++;
      final hasMoreData = notifications.length == _notificationsLimit;
      notifications.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: NotificationStatus.success,
          notifications: List.of(state.notifications)
            ..addAll(notifications),
          hasReachedMax: !hasMoreData,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: NotificationStatus.failure));
    }
  }

  Future<void> _onSetNotificationOpen(
      SetNotificationOpen event, Emitter<NotificationState> emit) async {
    try {
      var response = await _repository.setNotificationOpen(event.notificationId);
      add(NotificationFetched());
      final notifications = await _fetchNotifications();
      emit(state.copyWith(notifications: notifications, status: NotificationStatus.success));
    } catch (_) {
      add(NotificationFetched());
    }
  }

  Future<List<NotificationSigma>> _fetchNotifications() async {
    try {
      final response = await _repository.getNotifications(currentPage, _notificationsLimit);
      if (response.items.isNotEmpty) {
        return response.items;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('error fetching notifications');
    }
  }
}
