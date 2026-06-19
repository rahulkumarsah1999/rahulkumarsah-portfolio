import 'package:flutter/material.dart';
class AppColors {
  static const Color primary = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF531AFF);
  static const Color accent = Color(0xFF38BDF8);
  static const Color background = Color(0xFFF8FAFC);
  static const Color navbar = Colors.white;
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF636E7C);
  static const Color border = Color(0xFFBCBCBC);
  static const Color shadow = Color(0x14000000);
  static const Color success = Colors.green;
  static const Color error = Colors.red;

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color scaffoldBackground(BuildContext context) =>
      isDark(context) ? const Color(0xFF101827) : background;

  static Color sectionBackground(BuildContext context) =>
      isDark(context) ? const Color(0x192239FF) : const Color(0xFFF3F6FB);

  static Color sectionSecondaryBackground(BuildContext context) =>
      isDark(context) ? const Color(0xFF161F32) : const Color(0xFFF3F6FB);

  static Color sectionS3Background(BuildContext context) =>
      isDark(context) ? const Color(0xFF1A2845) : const Color(0xFFF3F6FB);

  static Color navbarBackground(BuildContext context) =>
      isDark(context) ? const Color(0xFF1A1A1A) : navbar;

  static Color cardBackground(BuildContext context) =>
      isDark(context) ? const Color(0xFF0D0E2C) :  const Color(0xFFDEEAF6);

  static Color borderColor(BuildContext context) => isDark(context)
      ? Colors.white.withValues(alpha: 0.08)
      : border;

  static Color primaryText(BuildContext context) =>
      isDark(context) ? Colors.white : textPrimary;

  static Color secondaryText(BuildContext context) =>
      isDark(context) ? Colors.white70 : textSecondary;

  static Color iconBackground(BuildContext context) => isDark(context)
      ? Colors.white.withValues(alpha: 0.05)
      : primary.withValues(alpha: 0.08);


  static Color blink(BuildContext context) =>
      isDark(context) ? Colors.amberAccent : accent;
}