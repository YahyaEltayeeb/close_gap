import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:close_gap/core/utils/font_weight.dart';
import 'colors.dart';

abstract class AppTheme {
  // ==== Light Theme ====
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColors.lightPrimary,
        secondary: AppColors.lightProgress,
        surface: AppColors.lightCard,
        onPrimary: AppColors.white,
        onSecondary: AppColors.black,
        onSurface: AppColors.lightTextSecondary,
        error: AppColors.red,
        onError: AppColors.white,
      ),
      primaryIconTheme: IconThemeData(color: AppColors.darkBottomNav),
      iconTheme: IconThemeData(color: AppColors.darkBottomNav),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.black),
        titleTextStyle: GoogleFonts.balooThambi2(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: AppFontWeight.semiBold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightBottomNav,
        selectedItemColor: AppColors.lightPrimary,
        unselectedItemColor: AppColors.grey,
      ),
      textTheme: _textTheme(isDarkMode: false),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.lightProgress,
      ),
    );
  }

  // ==== Dark Theme ====
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.darkPrimary,
        secondary: AppColors.darkProgress,
        surface: AppColors.darkCard,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.blacklight,
        error: AppColors.red,
        onError: AppColors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkCard,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.darkIcon),
        titleTextStyle: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 20,
          fontWeight: AppFontWeight.bold,
        ),
      ),
      iconTheme: IconThemeData(color: AppColors.grey),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBottomNav,
        selectedItemColor: AppColors.darkPrimary,
        unselectedItemColor: AppColors.grey,
      ),
      textTheme: _textTheme(isDarkMode: true),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.darkProgress,
      ),
    );
  }

  // ==== TextTheme Function ====
  static TextTheme _textTheme({required bool isDarkMode}) {
    Color primaryColor = isDarkMode
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    Color secondaryColor = isDarkMode
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return TextTheme(
      // Display (Main Titles)
      displayLarge: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 24,
        fontWeight: AppFontWeight.extraBold,
      ),
      displayMedium: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 20,
        fontWeight: AppFontWeight.bold,
      ),
      displaySmall: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 16,
        fontWeight: AppFontWeight.semiBold,
      ),
      // Headline (Section Titles)
      headlineLarge: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 22,
        fontWeight: AppFontWeight.extraBold,
      ),
      headlineMedium: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 18,
        fontWeight: AppFontWeight.bold,
      ),
      headlineSmall: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 16,
        fontWeight: AppFontWeight.medium,
      ),
      // Title (Common Text)
      titleLarge: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 20,
        fontWeight: AppFontWeight.extraBold,
      ),
      titleMedium: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 16,
        fontWeight: AppFontWeight.medium,
      ),
      titleSmall: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 14,
        fontWeight: AppFontWeight.regular,
      ),
      // Body (Paragraphs)
      bodyLarge: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 16,
        fontWeight: AppFontWeight.regular,
      ),
      bodyMedium: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 14,
        fontWeight: AppFontWeight.regular,
      ),
      bodySmall: GoogleFonts.balooThambi2(
        color: secondaryColor,
        fontSize: 12,
        fontWeight: AppFontWeight.regular,
      ),
      // Label (Buttons, Captions)
      labelLarge: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 18,
        fontWeight: AppFontWeight.medium,
      ),
      labelMedium: GoogleFonts.balooThambi2(
        color: primaryColor,
        fontSize: 14,
        fontWeight: AppFontWeight.regular,
      ),
      labelSmall: GoogleFonts.balooThambi2(
        color: secondaryColor,
        fontSize: 12,
        fontWeight: AppFontWeight.regular,
      ),
    );
  }
}
