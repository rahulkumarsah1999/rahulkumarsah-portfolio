import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';

/// Returns the icon string for the given [item] based on the current theme.
///
/// Supports:
/// - Single icon (key: 'icon')
/// - Theme-based images (keys: 'darkIcon', 'lightIcon')
String getIcon(
  BuildContext context,
  Map<String, dynamic> item,
) {
  final isDark = AppColors.isDark(context);

  // Single icon support
  final singleIcon = item['icon'];
  if (singleIcon != null) {
    return singleIcon as String;
  }

  // Theme-based icon support
  final darkIcon = item['darkIcon'] as String?;
  final lightIcon = item['lightIcon'] as String?;

  return isDark
      ? (darkIcon ?? lightIcon ?? '')
      : (lightIcon ?? darkIcon ?? '');
}

/// Finds any icon item by [name] from a list.
///
/// Works for:
/// - socialLinks
/// - techStack
/// - cardDetail
/// - snapshotItems
/// - any future portfolio data list
Map<String, dynamic> getIconByName(
  List<Map<String, dynamic>> items,
  String name,
) {
  return items.firstWhere(
    (item) => item['name'] == name,
    orElse: () => items.firstWhere(
      (item) => item['title'] == name,
      orElse: () => <String, dynamic>{},
    ),
  );
}