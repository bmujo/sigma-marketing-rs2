import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../blocs/common/login/login_bloc.dart';
import '../../../../blocs/common/login/login_validate/login_validate_bloc.dart';
import '../../../common/screens/login/form/login_form.dart';

class LoginDesktopScreen extends StatelessWidget {
  const LoginDesktopScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginDesktopScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logo_bg.png'),
            fit: BoxFit.cover,
          ),
          color: SMColors.background,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 40.0, left: 80.0, right: 80.0, bottom: 40.0),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                create: (context) {
                  return LoginBloc(
                    authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
                  );
                },
              ),
              BlocProvider<LoginValidateBloc>(
                create: (context) {
                  return LoginValidateBloc(); // You might need to provide necessary dependencies
                },
              ),
            ],
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: SMColors.main.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(6, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              color: SMColors.main,
                              child: Center(
                                child: Image.asset("assets/logo_dark.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: SMColors.main,
                        padding: const EdgeInsets.all(20.0),
                        child: LoginForm(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

