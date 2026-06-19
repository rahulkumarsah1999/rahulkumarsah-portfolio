import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/core/constants/app_colors.dart';

class SnapshotRow extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  const SnapshotRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    final iconBoxSize = isMobile ? 28.0 : 30.0;
    final iconSize = isMobile ? 16.0 : 18.0;

    final titleStyle = TextStyle(
      color: AppColors.primaryText(context),
      fontWeight: FontWeight.w700,
      fontSize: isMobile ? 12 : 13,
    );

    final subtitleStyle = TextStyle(
      color: AppColors.secondaryText(context),
      fontSize: isMobile ? 10 : 11,
      height: 1.4,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(isMobile ? 8 : 10),
          child: Container(
            padding: const EdgeInsets.all(4),
            width: iconBoxSize,
            height: iconBoxSize,
            decoration: BoxDecoration(
              color: AppColors.iconBackground(context).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              height: iconSize,
              width: iconSize,
            ),
          ),
        ),
        SizedBox(width: isMobile ? 10 : 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: titleStyle,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: subtitleStyle,
              )
            ],
          ),
        )
      ],
    );
  }
}
