import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/typography.dart';

// параметры темы текстов
const textTheme = TextTheme(
  headlineLarge: AppTypography.styleLargeTitle, // 32
  headlineSmall: AppTypography.styleSubtitle, // 18
  titleLarge: AppTypography.styleTitle, // 24
  titleMedium: AppTypography.styleText, // 16
  titleSmall: AppTypography.styleSmallBold, // 14
  bodyLarge: AppTypography.styleMenu, // 16
  bodyMedium: AppTypography.styleSmall, // 14
  bodySmall: AppTypography.styleSuperSmall2, // 12,
  labelMedium: AppTypography.styleButton, // 14
  labelSmall: AppTypography.styleSuperSmall, // 12
);

// параметры светлой темы
final lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  highlightColor: AppColors.transparent,
  //splashColor: AppColors.transparent,
  textTheme: textTheme,
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: AppColors.white),
  splashColor: AppColors.splashColor,
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
    error: AppColors.redWhite,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.secondary2,
    circularTrackColor: AppColors.background,
  ),
  extensions: const <ThemeExtension<dynamic>>[
    CustomColors(
      gradient1: AppColors.gradientLeftWhite,
      gradient2: AppColors.gradientRightWhite,
    ),
  ],
);

// параметры темной темы
final darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.mainBlack,
  highlightColor: AppColors.transparent,
  //splashColor: AppColors.transparent,
  textTheme: textTheme,
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: AppColors.mainBlack),
  splashColor: AppColors.splashColor,
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
    error: AppColors.redBlack,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.secondary2,
    circularTrackColor: AppColors.dark,
  ),
  extensions: const [
    CustomColors(
      gradient1: AppColors.gradientLeftBlack,
      gradient2: AppColors.gradientRightBlack,
    ),
  ],
);

// пользовательские цвета приложения
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color? gradient1;
  final Color? gradient2;

  const CustomColors({
    required this.gradient1,
    required this.gradient2,
  });

  @override
  CustomColors copyWith({Color? gradient1, Color? gradient2}) {
    return CustomColors(
      gradient1: gradient1 ?? this.gradient1,
      gradient2: gradient2 ?? this.gradient2,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }

    return CustomColors(
      gradient1: Color.lerp(gradient1, other.gradient1, t),
      gradient2: Color.lerp(gradient2, other.gradient2, t),
    );
  }

}