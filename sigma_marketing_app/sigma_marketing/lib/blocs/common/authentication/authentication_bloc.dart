import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/repository_impl.dart';
import '../../../data/repositories/user/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
          (status) => add(_AuthenticationStatusChanged(status)),
    );

    saveNotificationToken();
  }

  final RepositoryImpl _repository = RepositoryImpl();


  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
  _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit,
      ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final token = await _tryGetToken();
        return emit(
          token != null && token.isNotEmpty
              ? AuthenticationState.authenticated(token)
              : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event,
      Emitter<AuthenticationState> emit,
      ) {
    _authenticationRepository.logOut();
  }

  Future<String?> _tryGetToken() async {
    try {
      const storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      return token;
    } catch (_) {
      return null;
    }
  }

  Future<bool> saveNotificationToken() async {
    try {
      String token = await FirebaseMessaging.instance.getToken() ?? "";

      bool isTokenSaved = await _repository.saveNotificationToken(token);
      return isTokenSaved;
    } catch (_) {
      return false;
    }
  }
}
