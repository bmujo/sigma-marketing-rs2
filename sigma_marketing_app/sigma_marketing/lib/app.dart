import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_marketing/blocs/common/authentication/authentication_bloc.dart';
import 'package:sigma_marketing/presentation/brand/screens/layout/desktop_layout.dart';
import 'package:sigma_marketing/presentation/user/screens/layout/mobile_layout.dart';
import 'package:sigma_marketing/presentation/brand/screens/login/login_desktop_screen.dart';
import 'package:sigma_marketing/presentation/user/screens/login/login_screen.dart';
import 'package:sigma_marketing/presentation/user/screens/splash/splash_screen.dart';
import 'package:sigma_marketing/config/themes/my_themes.dart';
import 'package:sigma_marketing/push_notifications/desktop_push_notifications.dart';

import 'data/repositories/authentication/authentication_repository.dart';
import 'data/repositories/user/user_repository.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();

    if(Platform.isWindows) {
      initializeDesktopPushNotifications();
    }
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  _getHomeRoute(context),
                      (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  _getLoginRoute(context),
                      (route) => false,
                );
                break;
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }

  Route<dynamic> _getHomeRoute(BuildContext context) {
    if(kIsWeb) return DesktopLayout.route();
    if (Platform.isAndroid || Platform.isIOS) {
      return MobileLayout.route();
    } else if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      // Use the desktop/web version of the home screen
      return DesktopLayout.route();
    } else {
      // Default to mobile version for unknown platforms
      return MobileLayout.route();
    }
  }

  Route<dynamic> _getLoginRoute(BuildContext context) {
    if(kIsWeb) return LoginDesktopScreen.route();
    if (Platform.isAndroid || Platform.isIOS) {
      return LoginScreen.route();
    } else if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      // Use the desktop/web version of the login screen
      return LoginDesktopScreen.route();
    } else {
      // Default to mobile version for unknown platforms
      return LoginScreen.route();
    }
  }
}
