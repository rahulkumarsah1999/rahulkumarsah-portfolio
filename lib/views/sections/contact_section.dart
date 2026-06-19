import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';
import 'package:portfolio/views/widgets/common/badge_pill.dart';
import 'package:portfolio/views/widgets/contact/left_panel.dart';
import 'package:portfolio/views/widgets/contact/right_panel.dart';
import 'package:portfolio/views/widgets/common/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    // responsive
    final isMobile = Responsive.isMobile(context);

    // sizing
    final horizontalPadding = isMobile ? 20.0 : 42.0;
    final verticalPadding = isMobile ? 60.0 : 80.0;
    final panelSpacing = isMobile ? 14.0 : 24.0;
    final contentMaxWidth = isMobile ? double.infinity : 1320.0;

    // styles


    // decoration
    final sectionDecoration = BoxDecoration(
      color: AppColors.sectionBackground(context),
    );

    // widget tree
    return Container(
      decoration: sectionDecoration,
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
            children: [
              const SectionTitle(title: 'Contact', subtitle: ' Me'),
              SizedBox(height: isMobile ? 20 : 70),
              Align(
                alignment: Alignment.centerLeft,
                child: BadgePill(label: "CONTACT ME",color: AppColors.accent,)
              ),
              SizedBox(height: isMobile ? 20 : 40),
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const LeftPanel(),
                        SizedBox(height: panelSpacing),
                        const RightPanel(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 10,
                          child: LeftPanel(),
                        ),
                        SizedBox(width: panelSpacing),
                        const Expanded(
                          flex: 11,
                          child: RightPanel(),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
