import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../presentation/common/screens/login/validation_models/email.dart';
import '../../../../presentation/common/screens/login/validation_models/password.dart';

part 'login_validate_event.dart';

part 'login_validate_state.dart';

class LoginValidateBloc extends Bloc<LoginValidateEvent, LoginValidateState> {
  LoginValidateBloc() : super(const LoginValidateState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginValidateState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([state.password, email])
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure,
          isButtonEnabled: Formz.validate([email, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginValidateState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password, state.email])
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure,
        isButtonEnabled: Formz.validate([state.email, password]),
      ),
    );
  }
}
