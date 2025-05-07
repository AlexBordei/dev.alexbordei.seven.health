import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Colors
  static const Color primaryColor = Color(0xFF7E57C2);
  static const Color secondaryColor = Color(0xFF42A5F5);
  static const Color accentColor = Color(0xFF03A9F4);

  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0BEC5);

  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);

  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFFFA000);
  static const Color infoColor = Color(0xFF1976D2);

  // Text Styles
  static TextStyle get headlineLarge => TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.25,
      );

  static TextStyle get headlineMedium => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.25,
      );

  static TextStyle get headlineSmall => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
      );

  static TextStyle get titleLarge => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      );

  static TextStyle get titleMedium => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      );

  static TextStyle get titleSmall => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      );

  static TextStyle get bodyLarge => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      );

  static TextStyle get labelLarge => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      );

  static TextStyle get labelMedium => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      );

  static TextStyle get labelSmall => TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
      );

  // Shape
  static BorderRadius get borderRadiusSmall => BorderRadius.circular(4.r);
  static BorderRadius get borderRadiusMedium => BorderRadius.circular(8.r);
  static BorderRadius get borderRadiusLarge => BorderRadius.circular(16.r);

  // Spacing
  static double get spacingXxs => 2.w;
  static double get spacingXs => 4.w;
  static double get spacingSm => 8.w;
  static double get spacingMd => 16.w;
  static double get spacingLg => 24.w;
  static double get spacingXl => 32.w;
  static double get spacingXxl => 48.w;

  // Elevation
  static double get elevationSmall => 2;
  static double get elevationMedium => 4;
  static double get elevationLarge => 8;

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceLight,
        background: backgroundLight,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryLight,
        onBackground: textPrimaryLight,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        elevation: elevationSmall,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusMedium,
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusMedium,
        ),
        buttonColor: primaryColor,
      ),
      textTheme: TextTheme(
        headlineLarge: headlineLarge.copyWith(color: textPrimaryLight),
        headlineMedium: headlineMedium.copyWith(color: textPrimaryLight),
        headlineSmall: headlineSmall.copyWith(color: textPrimaryLight),
        titleLarge: titleLarge.copyWith(color: textPrimaryLight),
        titleMedium: titleMedium.copyWith(color: textPrimaryLight),
        titleSmall: titleSmall.copyWith(color: textPrimaryLight),
        bodyLarge: bodyLarge.copyWith(color: textPrimaryLight),
        bodyMedium: bodyMedium.copyWith(color: textPrimaryLight),
        bodySmall: bodySmall.copyWith(color: textSecondaryLight),
        labelLarge: labelLarge.copyWith(color: textPrimaryLight),
        labelMedium: labelMedium.copyWith(color: textPrimaryLight),
        labelSmall: labelSmall.copyWith(color: textSecondaryLight),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: borderRadiusMedium,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: spacingMd,
          vertical: spacingSm,
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceDark,
        background: backgroundDark,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryDark,
        onBackground: textPrimaryDark,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceDark,
        foregroundColor: textPrimaryDark,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        elevation: elevationSmall,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusMedium,
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusMedium,
        ),
        buttonColor: primaryColor,
      ),
      textTheme: TextTheme(
        headlineLarge: headlineLarge.copyWith(color: textPrimaryDark),
        headlineMedium: headlineMedium.copyWith(color: textPrimaryDark),
        headlineSmall: headlineSmall.copyWith(color: textPrimaryDark),
        titleLarge: titleLarge.copyWith(color: textPrimaryDark),
        titleMedium: titleMedium.copyWith(color: textPrimaryDark),
        titleSmall: titleSmall.copyWith(color: textPrimaryDark),
        bodyLarge: bodyLarge.copyWith(color: textPrimaryDark),
        bodyMedium: bodyMedium.copyWith(color: textPrimaryDark),
        bodySmall: bodySmall.copyWith(color: textSecondaryDark),
        labelLarge: labelLarge.copyWith(color: textPrimaryDark),
        labelMedium: labelMedium.copyWith(color: textPrimaryDark),
        labelSmall: labelSmall.copyWith(color: textSecondaryDark),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: borderRadiusMedium,
        ),
        filled: true,
        fillColor: surfaceDark,
        contentPadding: EdgeInsets.symmetric(
          horizontal: spacingMd,
          vertical: spacingSm,
        ),
      ),
    );
  }
}
