import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';
import 'package:portfolio/views/widgets/cards/primary_card.dart';

import '../../data/portfolio_data.dart';

class OnTheTableSection extends StatelessWidget {
  const OnTheTableSection({super.key});

  @override
  Widget build(BuildContext context) {
    // responsive
    final isMobile = Responsive.isMobile(context);

    // state
    final isDark = AppColors.isDark(context);

    // sizing
    final horizontalPadding = isMobile ? 20.0 : 42.0;
    final verticalPadding = isMobile ? 42.0 : 72.0;
    final sectionSpacing = isMobile ? 20.0 : 28.0;
    final titleFontSize = isMobile ? 16.0 : 24.0;
    final subtitleFontSize = isMobile ? 11.0 : 14.0;
    final accentHeight = isMobile ? 48.0 : 62.0;
    final contentMaxWidth = isMobile ? double.infinity : 1320.0;

    // styles
    final titleStyle = TextStyle(
      fontSize: titleFontSize,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      color: AppColors.primaryText(context),
    );

    final subtitleStyle = TextStyle(
      fontSize: subtitleFontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.secondaryText(context),
      letterSpacing: -0.15,
    );

    // decoration
    final sectionDecoration = BoxDecoration(
      color: AppColors.sectionBackground(context),
    );

    return Container(
      width: double.infinity,
      decoration: sectionDecoration,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: contentMaxWidth,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: 3,
                      height: accentHeight,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(
                          alpha: isDark ? 0.22 : 0.12,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: sectionSpacing),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "What I bring to the table",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: titleStyle,
                          ),
                          Text(
                            "For Startups • teams • products",
                            style: subtitleStyle,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sectionSpacing),
                isMobile
                    ? Column(
                        children:
                          portfolioData.cardDetail.map((card) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: PrimaryCard(
                              cardDetail: card,
                            ),
                          );
                        }).toList(),
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                          portfolioData.cardDetail.map((card) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: PrimaryCard(
                                cardDetail: card,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
