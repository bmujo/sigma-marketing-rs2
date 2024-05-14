import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/utils/colors/colors.dart';

import '../../../../../blocs/common/login/login_bloc.dart';
import '../widgets/email_input.dart';
import '../widgets/login_button.dart';
import '../widgets/password_input.dart';

class LoginForm extends StatelessWidget {
  late final FocusNode focusNodeEmail;
  late final TextEditingController emailController;

  late final FocusNode focusNodePassword;
  late final TextEditingController passwordController;

  LoginForm() {
    focusNodeEmail = FocusNode();
    emailController = TextEditingController();

    focusNodePassword = FocusNode();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: SingleChildScrollView(
                  child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 45),
                child: Text("Welcome",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              EmailInput(focusNodeEmail, emailController),
              PasswordInput(focusNodePassword, passwordController),
              _forgotPasswordButton(context),
              LoginButton(emailController, passwordController),
              _registerButton(context),
            ],
          )),
    );
  }

  Padding _forgotPasswordButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(32, 12, 32, 0),
        child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
              onTap: () => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Forgot Password'),
                          content:
                              Text('Password recovery feature coming soon.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    )
                  },
              child: const Text("Forgot username or password?",
                  style: TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue))),
        ));
  }

  Padding _registerButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
        child: Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => register(context),
              child: const Text("New user sign up",
                  style: TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue)),
            )));
  }
}

void register(BuildContext context) {
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => RegistrationScreen()),
  // );
}
