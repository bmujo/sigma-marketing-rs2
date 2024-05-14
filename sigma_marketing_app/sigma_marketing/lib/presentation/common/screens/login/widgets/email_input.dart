import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../utils/colors/colors.dart';
import '../../../../../blocs/common/login/login_validate/login_validate_bloc.dart';

class EmailInput extends StatelessWidget {
  late final FocusNode focusNodeEmail;
  late final TextEditingController emailController;

  EmailInput(FocusNode focusNodeEmail, TextEditingController emailController) {
    this.focusNodeEmail = focusNodeEmail;
    this.emailController = emailController;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginValidateBloc, LoginValidateState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.fromLTRB(32, 84, 32, 0),
            child: Focus(
              child: TextField(
                  key: const Key('loginForm_usernameInput_textField'),
                  controller: emailController,
                  focusNode: focusNodeEmail,
                  onChanged: (email) {
                    context
                        .read<LoginValidateBloc>()
                        .add(LoginEmailChanged(email));
                  },
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: SMColors.primaryColor),
                    ),
                    floatingLabelStyle: const TextStyle(
                        color: SMColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    labelText: 'Email',
                    suffixIcon: Icon(
                      Icons.email,
                      color: focusNodeEmail.hasFocus
                          ? SMColors.primaryColor
                          : SMColors.dimGrey,
                    ),
                    errorText: state.status.isInitial
                        ? null
                        : state.email.isNotValid
                            ? 'invalid email'
                            : null,
                  )),
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  context
                      .read<LoginValidateBloc>()
                      .add(LoginEmailChanged(emailController.text));
                }
              },
            ));
      },
    );
  }
}
