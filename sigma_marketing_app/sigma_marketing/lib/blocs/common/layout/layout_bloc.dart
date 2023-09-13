import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import '../../../config/constants.dart';

part 'layout_event.dart';

part 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  final StreamController<int> _unreadMessagesController =
      StreamController<int>();

  Stream<int> get unreadMessagesStream => _unreadMessagesController.stream;

  HubConnection? hubConnection;

  LayoutBloc() : super(LayoutInitial()) {
    on<LayoutFetched>(
      _onLayoutLoaded,
    );
  }

  Future<void> _onLayoutLoaded(
      LayoutFetched event, Emitter<LayoutState> emit) async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: "token") ?? "";

      hubConnection = HubConnectionBuilder()
          .withUrl(AppConstants.chatUrl,
              options: HttpConnectionOptions(
                accessTokenFactory: () => Future.value("Bearer $token"),
              ))
          .build();

      hubConnection?.on("ReceiveNumberOfUnreadMessages", (args) async {
        if (args != null) {
          var number = 0;
          try {
            number = int.parse((args[1] as String));
          } catch (e) {
            Logger().e(e);
          }

          _unreadMessagesController.add(number);
        }
      });

      await hubConnection?.start();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  Future<void> close() {
    hubConnection?.stop();
    _unreadMessagesController.close();
    return super.close();
  }
}
