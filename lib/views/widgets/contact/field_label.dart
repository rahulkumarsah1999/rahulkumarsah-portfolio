import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';

class FieldLabel extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const FieldLabel({
    super.key,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    // styles
    final labelStyle =
        textStyle ??
        TextStyle(
          color: AppColors.primaryText(context),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        );

    return Text(
      text,
      style: labelStyle,
    );
  }
}
