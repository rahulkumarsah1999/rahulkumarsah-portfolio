import 'package:flutter/material.dart';
import 'package:marqueer/marqueer.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';
import 'package:portfolio/views/widgets/common/section_title.dart';
import 'package:portfolio/views/widgets/common/tech_chip.dart';

import '../../data/portfolio_data.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = AppColors.isDark(context);

    // sizing
    final verticalPadding =
        isMobile ? 42.0 : 72.0;

    final horizontalPadding =
        isMobile ? 20.0 : 42.0;

    final sectionSpacing =
        isMobile ? 18.0 : 24.0;

    final marqueeHeight =
        isMobile ? 52.0 : 66.0;

    final lineHeight =
        isMobile ? 48.0 : 62.0;

    final titleFontSize =
        isMobile ? 12.0 : 14.0;

    final contentMaxWidth =
        isMobile ? double.infinity : 1320.0;

    // styles
    final subtitleStyle = TextStyle(
      fontSize: titleFontSize,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.15,
      color: AppColors.secondaryText(context),
    );

    final techItems = portfolioData.techStack
        .map(
          (tech) => Padding(
            padding: const EdgeInsets.only(right: 14),
            child: TechChip(tech: tech, isMobile: isMobile),
          ),
        )
        .toList();

    // widget tree
    return Container(
      color: AppColors.sectionBackground(context),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 0,
        ),
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: contentMaxWidth,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Accent vertical line
                Container(
                  width: 3,
                  height: lineHeight,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(
                      alpha: isDark ? 0.22 : 0.12,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(width: sectionSpacing),
                // Title + subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(
                        title: 'Tech',
                        subtitle: ' Stack',
                        fontSize: 20,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Tools & technologies I work with',
                        style: subtitleStyle,
                      ),
                      SizedBox(height: sectionSpacing),
                      SizedBox(
                        height: marqueeHeight,
                        child: Marqueer(
                          pps: isMobile ? 82 : 108,
                          direction: MarqueerDirection.rtl,
                          restartAfterInteraction: true,
                          restartAfterInteractionDuration: const Duration(
                            milliseconds: 100,
                          ),
                          child: Row(children: techItems),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
