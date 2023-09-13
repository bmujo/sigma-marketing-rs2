import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/colors/colors.dart';
import '../../../../../blocs/common/login/login_bloc.dart';
import '../../../../../blocs/common/login/login_validate/login_validate_bloc.dart';

class LoginButton extends StatelessWidget {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  LoginButton(TextEditingController emailController, TextEditingController passwordController){
    this.emailController = emailController;
    this.passwordController = passwordController;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginValidateBloc, LoginValidateState>(
      // Rebuild only when isButtonEnabled changes
      buildWhen: (previous, current) =>
          previous.isButtonEnabled != current.isButtonEnabled,
      builder: (context, validateState) {
        return BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, loginState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 35, 32, 0),
                  child: AbsorbPointer(
                    absorbing: !validateState.isButtonEnabled,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SMColors.primaryColor,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: validateState.isButtonEnabled
                          ? () {
                              context
                                  .read<LoginBloc>()
                                  .add(LoginSubmitted(
                                    email: emailController.text,
                                    password: passwordController.text,
                              ));
                            }
                          : null,
                      child: const Text('Login'),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
