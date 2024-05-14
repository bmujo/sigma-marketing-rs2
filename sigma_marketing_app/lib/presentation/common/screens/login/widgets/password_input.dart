import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../utils/colors/colors.dart';
import '../../../../../blocs/common/login/login_validate/login_validate_bloc.dart';

class PasswordInput extends StatelessWidget {
  late final FocusNode focusNodePassword;
  late final TextEditingController passwordController;
  late bool isObscure = true;

  PasswordInput(
      FocusNode focusNodePassword, TextEditingController passwordController) {
    this.focusNodePassword = focusNodePassword;
    this.passwordController = passwordController;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginValidateBloc, LoginValidateState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.fromLTRB(32, 47, 32, 0),
            child: Focus(
              child: TextField(
                  key: const Key('loginForm_passwordInput_textField'),
                  controller: passwordController,
                  focusNode: focusNodePassword,
                  obscureText: isObscure,
                  enableSuggestions: false,
                  autocorrect: false,
                  onChanged: (password) {
                    context
                        .read<LoginValidateBloc>()
                        .add(LoginPasswordChanged(password));
                  },
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: SMColors.primaryColor),
                    ),
                    floatingLabelStyle: const TextStyle(
                        color: SMColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      color: focusNodePassword.hasFocus
                          ? SMColors.primaryColor
                          : SMColors.dimGrey,
                      icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        isObscure = !isObscure;
                      },
                    ),
                    errorText: state.status.isInitial
                        ? null
                        : state.password.isNotValid
                            ? 'invalid password'
                            : null,
                  )),
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  context
                      .read<LoginValidateBloc>()
                      .add(LoginPasswordChanged(passwordController.text));
                }
              },
            ));
      },
    );
  }
}
