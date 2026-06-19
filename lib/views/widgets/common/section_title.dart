import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double? fontSize;
  final FontWeight fontWeight;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.fontSize,
    this.fontWeight = FontWeight.w800,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      color: AppColors.primaryText(context),
      fontSize: fontSize ?? 40,
      fontWeight: fontWeight,
    );

    final subtitleStyle = TextStyle(
      color: AppColors.secondary,
      fontSize: fontSize ?? 40,
      fontWeight: fontWeight,
    );

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: titleStyle,
          ),
          TextSpan(
            text: subtitle ?? '',
            style: subtitleStyle,
          ),
        ],
      ),
    );
  }
}
