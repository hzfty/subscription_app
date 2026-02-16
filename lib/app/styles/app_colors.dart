import 'package:flutter/material.dart';

/// Палитра цветов приложения
///
/// ВАЖНО:
/// - Используйте AppColors для кастомных цветов
/// - Для Material3 цветов используйте Theme.of(context).colorScheme
/// - Организовано по назначению: primary, backgrounds, surfaces, text, buttons, status
class AppColors {
  AppColors._(); // Приватный конструктор

  // ============================================
  // PRIMARY COLORS
  // ============================================
  static const Color primary = Color(0xFF2196F3); // Blue
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1976D2);

  // ============================================
  // BACKGROUNDS
  // ============================================
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF121212);

  // ============================================
  // SURFACES
  // ============================================
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // ============================================
  // DIVIDERS
  // ============================================
  static const Color divider = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF2C2C2C);

  // ============================================
  // TEXT COLORS
  // ============================================
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);

  static const Color textPrimaryDark = Color(0xFFE0E0E0);
  static const Color textSecondaryDark = Color(0xFF9E9E9E);
  static const Color textDisabledDark = Color(0xFF616161);

  // ============================================
  // BUTTON COLORS
  // ============================================
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = Color(0xFF757575);
  static const Color buttonDisabled = Color(0xFFE0E0E0);

  // ============================================
  // STATUS COLORS
  // ============================================
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color error = Color(0xFFF44336); // Red
  static const Color warning = Color(0xFFFF9800); // Orange
  static const Color info = Color(0xFF2196F3); // Blue

  // ============================================
  // CUSTOM COLORS (если нужны дополнительные)
  // ============================================
  // TODO: Добавьте специфичные цвета вашего приложения здесь
  // static const Color customBlue = Color(0xFF..);
}
