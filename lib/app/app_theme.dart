import 'package:flutter/material.dart';
import 'package:weather_app/home/home.dart';

import 'app_colors.dart';

/// Creates [ThemeData] based on `data`.
ThemeData resolveAppTheme(DynamicThemeData data) {
  final ColorScheme colorScheme;
  switch (data.brightness) {
    case Brightness.light:
      colorScheme = ColorScheme.light(
        primary: AppColors.primaryLight,
        primaryContainer: AppColors.primaryContainerLight,
        secondary: AppColors.secondaryLight,
        background: data.background,
        onBackground: data.onBackground,
        error: AppColors.errorLight,
        onError: AppColors.onErrorLight,
      );
      break;
    case Brightness.dark:
      colorScheme = ColorScheme.dark(
        primary: AppColors.primaryDark,
        primaryContainer: AppColors.primaryContainerDark,
        secondary: AppColors.secondaryDark,
        background: data.background,
        onBackground: data.onBackground,
        error: AppColors.errorDark,
        onError: AppColors.onErrorDark,
      );
      break;
  }

  final textTheme = _getTextTheme(
    colorScheme.primary,
    colorScheme.secondary,
  );

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: data.background,
    highlightColor: data.onBackground.withOpacity(0.5),
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: data.background,
      scrolledUnderElevation: 3.0,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: data.background,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: colorScheme.primary,
    ),
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: textTheme.bodyMedium!.copyWith(
        color: colorScheme.onError,
      ),
      backgroundColor: colorScheme.error,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 0.0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: data.onBackground,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(40, 40),
      ),
    ),
    fontFamily: 'Poppins',
    textTheme: textTheme,
  );
}

TextTheme _getTextTheme(Color primary, Color secondary) {
  return TextTheme(
    displayLarge: TextStyle(
      color: primary,
      fontSize: 102,
      fontWeight: FontWeight.w400,
      height: 1.15,
    ),
    headlineMedium: TextStyle(
      color: primary,
      fontSize: 27,
      fontWeight: FontWeight.w700,
      height: 1.1,
    ),
    titleLarge: TextStyle(
      color: primary,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      height: 1.15,
    ),
    titleMedium: TextStyle(
      color: primary,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.0,
    ),
    titleSmall: TextStyle(
      color: secondary,
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.2,
    ),
    bodyMedium: TextStyle(
      color: secondary,
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.2,
    ),
    labelLarge: TextStyle(
      color: primary,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );
}
