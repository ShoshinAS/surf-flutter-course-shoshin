import 'package:flutter/material.dart';
import 'package:places/ui/colors.dart';

class AppTypography{

  static const styleSmallBoldWhite = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    color: AppColors.fontColorWhite,
    fontWeight: FontWeight.w700,
    height: 16 / 14,
  );

  static const styleSmallBold = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    color: AppColors.fontColor,
    fontWeight: FontWeight.w700,
    height: 16 / 14,
  );
  static const styleLargeTitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 32,
    color: AppColors.fontColor,
    fontWeight: FontWeight.w700,
    height: 36 / 32,
  );

  static const styleSmall = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    color: AppColors.fontColor,
    fontWeight: FontWeight.w400,
    height: 18 / 14,
  );

  static const styleSmallGray = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    color: AppColors.fontColorGray,
    fontWeight: FontWeight.w400,
    height: 18 / 14,
  );

  static const styleSmallInactive = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    color: AppColors.fontColorInactive,
    fontWeight: FontWeight.w400,
    height: 18 / 14,
  );

  static const styleText = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    color: AppColors.fontColor,
    fontWeight: FontWeight.w500,
    height: 20 / 16,
  );

  static const styleTitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    color: AppColors.fontColor,
    fontWeight: FontWeight.w700,
    height: 28.8 / 24,
  );

  static const styleButton = TextStyle(
    color: AppColors.fontColorWhite,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    letterSpacing: 0.03,
    height: 18 / 14,
  );

}