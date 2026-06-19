import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';
import 'package:portfolio/views/widgets/about/stats_item.dart';

import '../../../data/portfolio_data.dart';

class StatsBar extends StatelessWidget {
  const StatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final statsList = portfolioData.stats;
    final isMobile = Responsive.isMobile(context);

    final horizontalPadding = isMobile ? 8.0 : 28.0;
    final verticalPadding = isMobile ? 12.0 : 20.0;
    final dividerSpacing = isMobile ? 12.0 : 24.0;

    final containerDecoration = BoxDecoration(
      color: AppColors.cardBackground(context),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: AppColors.accent.withValues(alpha: 0.22),
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadow,
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: containerDecoration,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                statsList.length,
                (index) {
                  final stat = statsList[index];
                  final isLastItem = index == statsList.length - 1;

                  return Row(
                    children: [
                      StatsItem(
                        icon: stat['icon'],
                        value: stat['value'],
                        title: stat['title'],
                      ),
                      if (!isLastItem) ...[
                        SizedBox(width: dividerSpacing),
                        VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: AppColors.borderColor(context),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}