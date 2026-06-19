import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';
import 'package:portfolio/views/widgets/cards/project_card.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:portfolio/views/widgets/cards/other_project_card.dart';
import 'package:portfolio/views/widgets/common/section_title.dart';
import 'package:portfolio/views/widgets/common/tech_chip.dart';

import '../../data/project_data.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final PageController _pageController = PageController(
    viewportFraction: 1.0,
  );

  int _currentIndex = 0;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // responsive
    final isMobile = Responsive.isMobile(context);
    // final isDark = AppColors.isDark(context);

    // sizing
    final horizontalPadding =
        isMobile ? 20.0 : 42.0;

    final verticalPadding =
        isMobile ? 44.0 : 80.0;

    final sectionSpacing =
        isMobile ? 18.0 : 28.0;

    final headerSpacing =
        isMobile ? 10.0 : 14.0;

    final subtitleFontSize =
        isMobile ? 13.0 : 15.0;

    final otherTitleSize =
        isMobile ? 18.0 : 22.0;

    final contentMaxWidth =
        isMobile ? double.infinity : 1240.0;

    // data
    final featuredProjects = ProjectData.myProjects
        .where((p) => p.isFeatured)
        .toList();

    final otherProjects = ProjectData.myProjects
        .where((p) => !p.isFeatured)
        .toList();

    // styles
    final subtitleStyle = TextStyle(
      color: AppColors.secondaryText(context),
      fontWeight: FontWeight.w600,
      fontSize: subtitleFontSize,
      letterSpacing: -0.15,
      height: 1.6,
    );

    final tech = {
      'name': 'Projects',
      'lightIcon': 'assets/images/work.svg',
      'darkIcon': 'assets/images/work.svg',
    };

    return Container(
      color: AppColors.sectionBackground(context),
      width: double.infinity,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Header Chip
              TechChip(
                tech: tech,
                isMobile: isMobile,
                iconColor: AppColors.secondary,
                borderRadius: 30,
              ),

              SizedBox(height: headerSpacing),

              /// Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 20,
                    color: AppColors.primary,
                  ),

                  SectionTitle(title: ' My', subtitle: ' Projects '),

                  SvgPicture.asset(
                    'assets/images/sparkle.svg',
                    height: 16,
                    width: 16,
                    colorFilter: ColorFilter.mode(
                      AppColors.secondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8),

              Text(
                "Things I've built with passion and modern technologies",
                textAlign: TextAlign.center,
                style: subtitleStyle,
              ),

              SizedBox(height: sectionSpacing),

              /// Featured Project Carousel
              ExpandablePageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                dragStartBehavior: DragStartBehavior.down,
                itemCount: featuredProjects.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                    isExpanded = false;
                  });
                },
                itemBuilder: (context, index) {
                  return ProjectCard(
                    project: featuredProjects[index],
                    onExpandChanged: (expanded) {
                      if (!mounted) return;
                      setState(() {
                        isExpanded = expanded;
                      });
                    },
                  );
                },
              ),

              SizedBox(height: 20),

              /// Dots
              Container(
                width: 140,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderColor(context),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor:
                  (_currentIndex + 1) / featuredProjects.length,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              SizedBox(height: sectionSpacing),

              /// Other Projects
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.layers_rounded,
                    size: 25,
                    color: AppColors.secondary,
                  ),

                  const SizedBox(width: 12),

                  Text(
                    "Other Projects",
                    style: TextStyle(
                      color: AppColors.primaryText(context),
                      fontSize: otherTitleSize,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                    ),
                  ),

                  const SizedBox(width: 6),

                  Text(
                    "(In Progress)",
                    style: TextStyle(
                      color: AppColors.secondaryText(context),
                      fontSize: subtitleFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: sectionSpacing),

              /// Other Cards
              Padding(
                padding: const EdgeInsets.all(8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 900;

                    return Wrap(
                      spacing: 16,
                      runSpacing: 18,
                      children: [
                        ...otherProjects.map(
                          (project) => SizedBox(
                            width: isWide
                                ? (constraints.maxWidth - 16) / 2
                                : constraints.maxWidth,
                            child: OtherProjectCard(
                              project: project,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
