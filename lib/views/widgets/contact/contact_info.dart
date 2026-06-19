import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';

class ContactInfo extends StatelessWidget {
  final Color circleColor;
  final Widget icon;
  final Color labelColor;
  final String label;
  final String value;
  const ContactInfo({
    super.key,
    required this.circleColor,
    required this.icon,
    required this.label,
    required this.labelColor,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    // sizing
    final containerSize = 30.0;
    final iconSize = 10.0;
    final spacing = 14.0;

    // styles
    final labelStyle = TextStyle(
      color: labelColor,
      fontSize: 13,
      fontWeight: FontWeight.w600,
    );

    final valueStyle = TextStyle(
      color: AppColors.primaryText(context),
      fontSize: 14,
    );

    // widget tree
    return Row(
      children: [
        Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
          ),
          child: SizedBox(
            width: iconSize,
            height: iconSize,
            child: icon,
          ),
        ),
        SizedBox(width: spacing),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: labelStyle,
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: valueStyle,
            ),
          ],
        ),
      ],
    );
  }
}
