import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/core/constants/app_colors.dart';

class TechChip extends StatelessWidget {
final Map<String, dynamic> tech;
final bool isMobile;

final double? iconSize;
final EdgeInsetsGeometry? padding;
final double? borderRadius;
final double? fontSize;
final Color? iconColor;
final Color? titleColor;

const TechChip({
  super.key,
  required this.tech,
  required this.isMobile,
  this.iconSize,
  this.padding,
  this.borderRadius,
  this.fontSize,
  this.iconColor,
  this.titleColor,
});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final resolvedIconSize = iconSize ?? (isMobile ? 20 : 22);
    final titleStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: fontSize ?? (isMobile ? 13 : 15),
      letterSpacing: 0.2,
      color: titleColor ?? AppColors.primaryText(context),
    );

    return Container(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 15,
            vertical: isMobile ? 12 : 10,
          ),
      decoration: BoxDecoration(
        color: AppColors.sectionBackground(context),
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        border: Border.all(
          color: AppColors.borderColor(context)
              .withValues(alpha: isDark ? 0.15 : 0.9),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              isDark ? tech['darkIcon'] : tech['lightIcon'],
              height: resolvedIconSize,
              width: resolvedIconSize,
              colorFilter: iconColor != null
                  ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                  : null,
            ),
          ),
          SizedBox(width: isMobile ? 10 : 12),
          Text(
            tech['name'],
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: titleStyle,
          ),
        ],
      ),
    );
  }
}
