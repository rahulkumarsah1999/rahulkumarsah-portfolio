import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/views/widgets/common/social_hover_icon.dart';

class PrimaryCard extends StatelessWidget {
  final Map<String, dynamic> cardDetail;

  const PrimaryCard({
    super.key,
    required this.cardDetail,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 850;

    final title = cardDetail['title'] ?? '';
    final description = cardDetail['description'] ?? '';
    final icons = cardDetail['icons'] as List?;

    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final titleStyle = TextStyle(
      color: AppColors.primaryText(context),
      fontSize: isMobile ? 14 : 16,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
    );

    final descriptionStyle = TextStyle(
      color: AppColors.secondaryText(context),
      fontSize: isMobile ? 11 : 12,
      fontWeight: FontWeight.w400,
    );

    return HoverLift(
      liftOffset: 4,
      grayscaleOnHover: false,
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: isMobile ? 4 : 8,
          vertical: isMobile ? 6 : 10,
        ),
        padding: EdgeInsets.all(
          isMobile ? 14 : 18,
        ),
        constraints: BoxConstraints(
          minHeight: isMobile ? 120 : 140,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardBackground(context),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.accent.withValues(
              alpha: 0.18,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(
                alpha: 0.04,
              ),
              blurRadius: 16,
              spreadRadius: -4,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Title
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: titleStyle,
            ),

            if (description.toString().isNotEmpty) ...[
              const SizedBox(height: 6),

              /// Description
              Text(
                description,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: descriptionStyle,
              ),
            ],
            const SizedBox(height: 14),

            /// Icons
            if (icons != null && icons.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: icons.map<Widget>((icon) {
                  final iconPath = isDark
                      ? icon['darkIcon']
                      : icon['lightIcon'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                    ),
                    child: SvgPicture.asset(
                      iconPath,
                      width: isMobile ? 24 : 28,
                      height: isMobile ? 24 : 28,
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}