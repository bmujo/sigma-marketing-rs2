part of '../../../../../blocs/common/login/login_validate/login_validate_bloc.dart';

abstract class LoginValidateEvent extends Equatable {
  const LoginValidateEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginValidateEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginValidateEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}
