import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF3CC18E);
  static const neutral000 = Color(0xFFFFFFFF);
  static const neutral200 = Color(0xFFE3E6EA);
  static const neutral400 = Color(0xFF777B84);
  static const neutral500 = Color(0xFF263238);

  static const accent1 = Color(0xFF934E42);
  static const accent2 = Color(0xFFCC753A);
  static const accent3 = Color(0xFFE4944B);
  static const accent4 = Color(0xFFF98A8A);
  static const accent5 = Color(0xFFF5B8A3);
}

class AppTextStyles {
  // NOTE: When SF Pro Display font files are added, change `fontFamily` to 'SF Pro Display'.
  static const heading4 = TextStyle(
    fontSize: 22,
    height: 32 / 22,
    fontWeight: FontWeight.w600,
    color: AppColors.neutral500,
  );
  static const body1 = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    color: AppColors.neutral500,
  );
  static const body1Bold = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
    color: AppColors.neutral500,
  );
  static const body2 = TextStyle(
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w400,
    color: AppColors.neutral500,
  );
  static const subText1 = TextStyle(
    fontSize: 12,
    height: 18 / 12,
    fontWeight: FontWeight.w400,
    color: AppColors.neutral400,
  );
}

ThemeData buildTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      background: AppColors.neutral000,
    ),
    scaffoldBackgroundColor: AppColors.neutral000,
    textTheme: base.textTheme.copyWith(
      headlineSmall: AppTextStyles.heading4,
      bodyLarge: AppTextStyles.body1,
      bodyMedium: AppTextStyles.body2,
      titleMedium: AppTextStyles.body1Bold,
      labelSmall: AppTextStyles.subText1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        minimumSize: const Size.fromHeight(48),
        textStyle: AppTextStyles.body1Bold.copyWith(color: Colors.white),
      ),
    ),
  );
}
