import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../blocs/common/login/login_bloc.dart';
import '../../../../blocs/common/login/login_validate/login_validate_bloc.dart';
import '../../../common/screens/login/form/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: SMColors.main,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                create: (context) {
                  return LoginBloc(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context),
                  );
                },
              ),
              BlocProvider<LoginValidateBloc>(
                create: (context) {
                  return LoginValidateBloc();
                },
              ),
            ],
            child: Column(
              children: [
                LogoSection(),
                LoginForm(),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class LogoSection extends StatelessWidget {
  const LogoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 66),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/logo_dark.png"),
        ],
      ),
    );
  }
}
