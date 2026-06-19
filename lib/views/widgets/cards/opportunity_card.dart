import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/utils/responsive/responsive.dart';

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final header = portfolioData.availableFor.first;
    final isMobile = Responsive.isMobile(context);

    final titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColors.success,
    );

    // Modern Flutter Standard: .withValues(alpha: ...) handles exact transparency matrix
    final cardDecoration = BoxDecoration(
      color: AppColors.cardBackground(context),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: AppColors.accent.withValues(alpha: 0.22),
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.secondary.withValues(alpha: 0.08),
          blurRadius: 20,
          spreadRadius: -6,
          offset: const Offset(0, 8),
        ),
      ],
    );

    // Filtering items safely to avoid map index collisions
    final items = portfolioData.availableFor.sublist(1);

    return Container(
      constraints: const BoxConstraints(
        minHeight: 40,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.secondary,
                      const Color(0xFF5AC8FA),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/icons/rocket.svg',
                  height: 20,
                  width: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                header['title'] ?? 'Available For',
                style: titleStyle,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 💡 FLEX REPLACEMENT FOR THE GRID VIEW (Zero text overflows or clipping)
          if (isMobile)
            Column(
              children: items.map((item) => _buildItem(context, item['title'])).toList(),
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      if (items.isNotEmpty) _buildItem(context, items[0]['title']),
                      if (items.length > 1) _buildItem(context, items[1]['title']),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      if (items.length > 2) _buildItem(context, items[2]['title']),
                      if (items.length > 3) _buildItem(context, items[3]['title']),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String text) {
    final textStyle = TextStyle(
      color: AppColors.secondaryText(context),
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 1.3, // Added explicit line-height baseline for ideal vertical rhythm
    );
    final isMobile = Responsive.isMobile(context);
    final spacing = isMobile ? 10.0 : 12.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Keeps the tick aligned perfectly with first text line
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0), // Precision alignment adjustment
            child: Icon(
              Icons.check_circle_rounded,
              color: AppColors.accent,
              size: 16,
            ),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Text(
              text,
              style: textStyle,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}