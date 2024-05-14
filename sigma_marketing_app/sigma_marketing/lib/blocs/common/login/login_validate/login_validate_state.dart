part of '../../../../../blocs/common/login/login_validate/login_validate_bloc.dart';

class LoginValidateState extends Equatable {
  const LoginValidateState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isButtonEnabled = false,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final bool isButtonEnabled;

  LoginValidateState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    bool? isButtonEnabled,
  }) {
    return LoginValidateState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  @override
  List<Object> get props => [status, email, password, isButtonEnabled];
}