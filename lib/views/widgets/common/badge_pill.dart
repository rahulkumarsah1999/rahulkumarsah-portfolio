import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';

class BadgePill extends StatelessWidget {
  final String label;
  final Color? color;
  final Widget? icon;

  const BadgePill({
    super.key,
    required this.label,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: color ?? AppColors.secondary.withValues(alpha: 0.85),
      fontSize: 11,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w600,
    );

   final pillDecoration = BoxDecoration(
      color: AppColors.iconBackground(context),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.accent.withValues(alpha: 0.22)),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: pillDecoration,
      child: icon != null
          ? Row(
              children: [
                icon!,
                const SizedBox(width: 6),
                Text(
                  label,
                  style: textStyle,
                ),
              ],
            )
          : Text(
              label,
              style: textStyle,
            ),
    );
  }
}
