import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/typography.dart';

const textTheme = TextTheme(
  headlineLarge: AppTypography.styleLargeTitle,
  headlineSmall: AppTypography.styleSubtitle,
  titleMedium: AppTypography.styleText, // 16
  titleSmall: AppTypography.styleSmallBold, // 14
  bodyMedium: AppTypography.styleSmall, // 14
  labelMedium: AppTypography.styleButton,
);

final lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  textTheme: textTheme,
  colorScheme: const ColorScheme.light(
    //background: AppColors.white,
    onBackground: AppColors.secondary,
    surface: AppColors.background,
    onSurface: AppColors.secondary,
    onSurfaceVariant: AppColors.secondary2,
    primary: AppColors.secondary,
    primaryContainer: AppColors.background,
    //onPrimary: AppColors.white,
    onPrimaryContainer: AppColors.secondary2,
    secondary: AppColors.greenWhite,
    onSecondary: AppColors.white,
    outline: AppColors.inactiveBlack,
    tertiary: AppColors.white,
    onTertiary: AppColors.mainWhite,
  ),
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.mainBlack,
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  textTheme: textTheme,
  colorScheme: const ColorScheme.dark(
    background: AppColors.mainBlack,
    //onBackground: AppColors.white,
    surface: AppColors.dark,
    //onSurface: AppColors.white,
    onSurfaceVariant: AppColors.secondary2,
    primary: AppColors.white,
    primaryContainer: AppColors.dark,
    onPrimary: AppColors.secondary,
    onPrimaryContainer: AppColors.secondary2,
    secondary: AppColors.greenBlack,
    onSecondary: AppColors.white,
    outline: AppColors.inactiveBlack,
    tertiary: AppColors.mainBlack,
    onTertiary: AppColors.white,
  ),
);
