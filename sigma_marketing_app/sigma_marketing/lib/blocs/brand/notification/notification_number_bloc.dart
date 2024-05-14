import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import '../../../config/constants.dart';

part 'notification_number_event.dart';
part 'notification_number_state.dart';

class NotificationNumberBloc extends Bloc<NotificationNumberEvent, NotificationNumberState> {
  final StreamController<int> _unreadNotificationsController = StreamController<int>();
  Stream<int> get unreadNotificationsStream => _unreadNotificationsController.stream;

  NotificationNumberBloc() : super(NotificationNumberInitial()) {
    on<NotificationNumberFetched>(
      _onLayoutLoaded,
    );
  }

  Future<void> _onLayoutLoaded(NotificationNumberFetched event, Emitter<NotificationNumberState> emit) async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: "token") ?? "";

      final connection = HubConnectionBuilder()
          .withUrl(AppConstants.notificationUrl,
          options: HttpConnectionOptions(
            accessTokenFactory: () => Future.value("Bearer $token"),
          ))
          .build();

      connection.on("ReceiveNumberOfUnreadNotifications", (args) async {
        if (args != null) {
          var number = 0;
          try {
            number = (args[0] as int);
          } catch (e) {
            Logger().e(e);
          }

          _unreadNotificationsController.add(number);
        }
      });

      await connection.start();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  Future<void> close() {
    _unreadNotificationsController.close();
    return super.close();
  }
}
