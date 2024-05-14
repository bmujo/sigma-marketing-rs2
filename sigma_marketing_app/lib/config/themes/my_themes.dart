import 'package:flutter/material.dart';
import '../../utils/colors/colors.dart';

enum MyThemeKeys { light, dark }

class MyThemes {
  const MyThemes();

  static final ThemeData lightTheme = ThemeData(
    primaryColor: SMColors.primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xff171d49),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.blue,
      cursorColor: SMColors.primaryColor,
      selectionHandleColor: SMColors.primaryColor,
    ),
    brightness: Brightness.light,
    highlightColor: Colors.white,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
        focusColor: Colors.blueAccent,
        splashColor: Colors.lightBlue),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.white)
        .copyWith(background: SMColors.main),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    brightness: Brightness.dark,
    highlightColor: Colors.white,
    textSelectionTheme:
    const TextSelectionThemeData(selectionColor: Colors.blue),
    colorScheme: const ColorScheme(
      background: Colors.black54,
      brightness: Brightness.dark,
      error: Colors.red,
      onError: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      primary: Colors.white,
      secondary: Colors.white,
      surface: Colors.white,
      onBackground: SMColors.main,
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
      surfaceTintColor: Colors.white,
    )
  );

  static List<BoxShadow> shadow = <BoxShadow>[
    const BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  static EdgeInsets padding =
  const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.light:
        return lightTheme;
      case MyThemeKeys.dark:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}
