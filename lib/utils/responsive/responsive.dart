import 'package:flutter/material.dart';

class Responsive {
  // Breakpoints
  static const mobile = 768;
  static const tablet = 1024;

  // Device Type

  // Mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobile;
  }

  // Tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return width >= mobile && width < tablet;
  }

  // Desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tablet;
  }

  // Screen Height
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Screen Width
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
