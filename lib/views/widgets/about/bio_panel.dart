import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/views/widgets/common/badge_pill.dart';
import 'package:portfolio/views/widgets/common/section_title.dart';
import 'package:portfolio/views/widgets/common/skill_card.dart';
import '../../../data/portfolio_data.dart';

class BioPanel extends StatelessWidget {
  const BioPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenWidth = size.width;

    // Consistency breakpoint matching the container layouts
    final isMobileOrTablet = screenWidth < 950;

    final bioTextStyle = TextStyle(
      color: AppColors.secondaryText(context),
      fontSize: isMobileOrTablet ? 14.0 : 16.0,
      height: 1.85,
      letterSpacing: 0.3,
    );

    return Column(
      // 💡 FIXED: Always align container boundaries to the left (start)
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobileOrTablet)
          const Align(
            alignment: Alignment.centerLeft,
            child: BadgePill(label: 'Get to know me'),
          )
        else
          const BadgePill(label: 'Get to know me'),
        const SizedBox(height: 16),
        const Align(
          alignment: Alignment.centerLeft,
          child: SectionTitle(title: 'About', subtitle: ' Me'),
        ),
        SizedBox(height: isMobileOrTablet ? 18 : 24),

        // 💡 FIXED: Force clear text layout alignment to the left
        Text(
          "I’m Rahul Kumar Sah, a Flutter Developer passionate about building scalable, responsive, and high-performance cross-platform applications. With expertise in Dart, Firebase, API integration, and clean architecture.",
          textAlign: TextAlign.start,
          style: bioTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          "I specialize in turning complex ideas into smooth, user-friendly mobile experiences.",
          textAlign: TextAlign.start,
          style: bioTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          "Driven by continuous learning and problem-solving, I focus on writing maintainable code that delivers impactful digital products.",
          textAlign: TextAlign.start,
          style: bioTextStyle,
        ),
        SizedBox(height: isMobileOrTablet ? 32 : 52),

        // 🛠️ OPTIMIZED SKILLS GRID: Compact sizing forced into sharp geometric row alignments
        SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: isMobileOrTablet ? 12 : 16,
            runSpacing: isMobileOrTablet ? 12 : 16,
            // Desktop par start se dikhega, mobile/tablet par clear card presentation ke liye center balanced rahega
            alignment: WrapAlignment.start,
            children: portfolioData.skills.map((skill) {

              // Mobile: 2 cards per row
              // Tablet: compact 2x2 layout
              // Desktop: original size
              double cardWidth;

              if (screenWidth < 768) {
                cardWidth = (screenWidth - 70) / 2;
              } else if (screenWidth < 950) {
                cardWidth = 135;
              } else {
                cardWidth = 120;
              }

              return SizedBox(
                width: cardWidth,
                child: SkillCard(
                  icon: skill['icon'],
                  title: skill['title'],
                  subtitle: skill['subtitle'],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}