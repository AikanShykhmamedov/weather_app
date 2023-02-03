import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_app/app/app_theme.dart';
import 'package:weather_app/home/home.dart';
import 'package:weather_app/home/src/constants/weather_colors.dart';
import 'package:weather_app/localization/localization.dart';

class AppMock extends StatelessWidget {
  const AppMock({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: resolveAppTheme(const DynamicThemeData(
        brightness: Brightness.dark,
        background: WeatherColors.darkBackground,
        onBackground: WeatherColors.darkOnBackground,
      )),
      home: child,
    );
  }
}
