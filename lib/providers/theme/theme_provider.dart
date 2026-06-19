import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme state manager
class ThemeNotifier
    extends Notifier<ThemeMode> {

  /// Default theme
  @override
  ThemeMode build() {
    return ThemeMode.dark;
  }

  /// Toggle light ↔ dark
  void toggleTheme() {

    /// If system theme
    if (state == ThemeMode.system) {

      /// Check device brightness
      final isDark =
          PlatformDispatcher
              .instance
              .platformBrightness ==
              Brightness.dark;

      /// Opposite of current device theme
      state = isDark
          ? ThemeMode.light
          : ThemeMode.dark;

      return;
    }

    /// Normal toggle
    state =
    state == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
  }
}

/// Provider
final themeProvider =
NotifierProvider<
    ThemeNotifier,
    ThemeMode>(
  ThemeNotifier.new,
);