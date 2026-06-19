import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/views/widgets/about/bio_panel.dart';
import 'package:portfolio/views/widgets/about/snapshot_card.dart';
import 'package:portfolio/views/widgets/about/stats_bar.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.sectionBackground(context),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;

              // 🔥 FLEXIBLE WRAPPING CHECK: If width drops below 950px, shift to clean column stacked format
              final isStackedLayout = screenWidth < 950;

              final double horizontalPadding = isStackedLayout ? 20.0 : 40.0;
              final double verticalPadding = isStackedLayout ? 60.0 : 80.0;
              final double contentSpacing = isStackedLayout ? 32.0 : 48.0;

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Column(
                  children: [
                    if (!isStackedLayout)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(
                            flex: 13,
                            child: BioPanel(),
                          ),
                          SizedBox(width: 48), // Distinct space spacer canvas
                          Expanded(
                            flex: 9,
                            child: SnapshotCard(),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const BioPanel(),
                          SizedBox(height: contentSpacing),
                          const SnapshotCard(),
                        ],
                      ),
                    SizedBox(height: contentSpacing * 1.5),
                    const StatsBar(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}