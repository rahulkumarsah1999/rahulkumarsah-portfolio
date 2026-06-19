import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/views/widgets/common/social_hover_icon.dart';

class SkillCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final double? width;

  const SkillCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    final titleStyle = TextStyle(
      color: AppColors.primaryText(context),
      fontSize: isMobile ? 12 : 13,
      fontWeight: FontWeight.w700,
    );

    final subtitleStyle = TextStyle(
      color: AppColors.secondaryText(context),
      fontSize: isMobile ? 9 : 10,
      height: 1.4,
    );

    final skillCardDecoration = BoxDecoration(
      color: AppColors.cardBackground(context),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.accent.withValues(alpha: 0.22)),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadow,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );

    return SizedBox(
      width: width ?? (isMobile ? 145 : 160),
      child: HoverLift(
        onTap: (){},
        liftOffset: 6,
        grayscaleOnHover: true,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 10 : 10,
            horizontal: isMobile ? 12 : 16,
          ),
          decoration: skillCardDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: isMobile ? 28 : 30,
                width: isMobile ? 28 : 30,
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: titleStyle,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: subtitleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
