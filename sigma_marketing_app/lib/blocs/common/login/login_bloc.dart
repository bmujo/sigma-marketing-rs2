import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
      emit(state.copyWith(status: LoginStatus.inProgress));
      try {
        await _authenticationRepository.logIn(
          username: event.email,
          password: event.password,
        );
        emit(state.copyWith(status: LoginStatus.success));
      } catch (_) {
        emit(state.copyWith(status: LoginStatus.failure));
      }
  }
}
