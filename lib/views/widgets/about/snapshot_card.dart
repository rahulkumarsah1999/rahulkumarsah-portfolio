import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';
import 'package:portfolio/views/widgets/about/quote_box.dart';
import 'package:portfolio/views/widgets/about/snapshot_row.dart';

import '../../../data/portfolio_data.dart';

class SnapshotCard extends StatelessWidget {
  const SnapshotCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final titleStyle = TextStyle(
      color: AppColors.primaryText(context),
      fontSize: isMobile ? 18 : 20,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
    );

    final subtitleStyle = TextStyle(
      color: AppColors.secondaryText(context),
      fontSize: isMobile ? 11 : 12,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 24,
          vertical: isMobile ? 22 : 26,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.cardBackground(context),
              AppColors.cardBackground(context).withValues(
                alpha: 0.94,
              ),
            ],
          ),
          border: Border.all(
            color: AppColors.accent
                .withValues(alpha: 0.22),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(
                alpha: 0.08,
              ),
              blurRadius: 40,
              spreadRadius: -10,
              offset: const Offset(0, 18),
            ),
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.03,
              ),
              blurRadius: 12,
              spreadRadius: -4,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(
                    isMobile ? 10 : 12,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.secondary.withValues(
                          alpha: 0.16,
                        ),
                        AppColors.primary.withValues(
                          alpha: 0.08,
                        ),
                      ],
                    ),
                    border: Border.all(
                      color: AppColors.secondary
                          .withValues(alpha: 0.18),
                    ),
                  ),
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    color: AppColors.secondary,
                    size: isMobile ? 20 : 22,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'At a Glance',
                      style: titleStyle,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Quick snapshot about me',
                      style: subtitleStyle,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 22),

            SizedBox(
              height: isMobile ? 4 : 6,
            ),

            Wrap(
              spacing: 14,
              runSpacing: 16,
              children: portfolioData.snapItems.map((snapshot) {
                return SizedBox(
                  width: double.infinity,
                  child: SnapshotRow(
                    icon: snapshot['icon'],
                    title: snapshot['title'],
                    subtitle: snapshot['subtitle'],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: isMobile ? 24 : 28),
            const QuoteBox(),
          ],
        ),
      ),
    );
  }
}
