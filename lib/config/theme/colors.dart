import 'package:flutter/material.dart';
abstract class AppColors {
  // ==== Basics ====
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color red = Color(0xFFFF4D4D);
  

  // ==== Light Mode ====
  static const Color lightBackground = Color(0xFFF3F2EF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightPrimary = Color(0xFF0A66C2); // LinkedIn Blue
  static const Color lightlable = Color(0xFF454B60);
  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0xFF666666);
  static const Color lightIcon = Color(0xFF000000);
  static const Color lightProgress = Color(0xFF0A66C2);
  static const Color lightBottomNav = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF666666);

  // ==== Dark Mode ====
  static const Color darkBackground = Color(0xFF0B0B0B);
  static const Color darkCard = Color(0xFF161616);
  static const Color darkPrimary = Color(
    0xFF0077FF,
  ); // أزرق أفتح شوية في المود الغامق
  static const Color darklable = Color(0xFFFFFFFF);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkIcon = Color(0xFFFFFFFF);
  static const Color darkProgress = Color(0xFF0084FF);
  static const Color darkBottomNav = Color(0xFF161616);
  static const Color blacklight=Color(0xff101114);

  // generate cv screen
  
   // Primary
  static const Color primary = Color(0xFF2979FF);
  static const Color primaryDark = Color(0xFF1565C0);
 
  // Background
  static const Color scaffoldBackground = Color(0xFFF2F2F7);
  static const Color cardBackground = Color(0xFFFFFFFF);
 
  // Text
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF8E8E93);
 
  // Border
  static const Color border = Color(0xFFD1D1D6);
 
  // Divider
  static const Color divider = Color(0xFFE5E5EA);
 
  // Button outline text
  static const Color outlineButtonText = Color(0xFF2979FF);
}
