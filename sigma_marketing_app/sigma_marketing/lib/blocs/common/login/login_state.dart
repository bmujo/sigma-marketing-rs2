part of '../../../../blocs/common/login/login_bloc.dart';

enum LoginStatus { initial, inProgress, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
  });

  final LoginStatus status;

  LoginState copyWith({
    LoginStatus? status,
    String? email,
    String? password,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
