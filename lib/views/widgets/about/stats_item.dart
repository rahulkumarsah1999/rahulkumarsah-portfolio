import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';

class StatsItem extends StatelessWidget {
  final String icon;
  final String value;
  final String title;
  const StatsItem({super.key,
    required this.icon,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 24,
        vertical: isMobile ? 10 : 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon Box
          Container(
            padding: const EdgeInsets.all(4),
            width: isMobile ? 28 : 30,
            height: isMobile ? 28 : 30,
            decoration: BoxDecoration(
              color: AppColors.iconBackground(context).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              height: isMobile ? 18 : 20,
              width: isMobile ? 18 : 20,
            ),
          ),

          SizedBox(height: isMobile ? 8 : 12),

          // Numeric Value Text
          Text(
            value,
            style: TextStyle(
              color: AppColors.primaryText(context),
              fontSize: isMobile ? 13 : 15,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 1),

          // Title Text
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.secondaryText(context),
              fontSize: isMobile ? 11 : 13,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}