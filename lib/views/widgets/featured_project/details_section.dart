import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/utils/responsive/responsive.dart';
import 'package:portfolio/views/widgets/common/badge_pill.dart';
import 'package:portfolio/views/widgets/buttons/action_button.dart';
import 'package:portfolio/views/widgets/common/feature_tile.dart';

class DetailsSection extends StatelessWidget {
  final ProjectModel project;
  final bool isExpanded;

  const DetailsSection({
    super.key,
    required this.project,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    // state
    final visibleFeatures = isExpanded
        ? project.keyFeatures
        : (isMobile
        ? project.keyFeatures.take(3).toList()
        : project.keyFeatures.take(4).toList());

    final halfLength = (visibleFeatures.length / 2).ceil();

    // sizing
    final titleFontSize = isMobile ? 20.0 : 24.0;
    final subtitleFontSize = isMobile ? 13.0 : 14.0;
    final descriptionFontSize = isMobile ? 13.0 : 14.0;

    final sectionSpacing = 14.0;
    final smallSpacing = 8.0;
    final tinySpacing = 6.0;
    final columnSpacing = 16.0;
    final desktopSpacing = 28.0;
    final maxWidth = isMobile ? double.infinity : 650.0;

    // styles
    final titleStyle = TextStyle(
      fontSize: titleFontSize,
      fontWeight: FontWeight.w700,
    );

    final subtitleStyle = TextStyle(
      color: AppColors.primary,
      fontSize: subtitleFontSize,
      fontWeight: FontWeight.w600,
    );

    final descriptionStyle = TextStyle(
      fontSize: descriptionFontSize,
      letterSpacing: 0.2,
      height: 1.7,
    );

    final sectionTitleStyle = TextStyle(
      color: AppColors.primary,
      fontSize: 13,
      fontWeight: FontWeight.bold,
    );

    final mobileSectionTitleStyle = TextStyle(
      color: AppColors.primary,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title,
            style: titleStyle,
          ),

          SizedBox(height: tinySpacing),

          Text(
            project.subtitle,
            style: subtitleStyle,
          ),

          SizedBox(height: sectionSpacing),

          Text(
            project.description,
            maxLines: isExpanded ? null : 2,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: descriptionStyle,
          ),

          SizedBox(height: sectionSpacing),

          Divider(thickness: 1, color: AppColors.borderColor(context)),

          SizedBox(height: sectionSpacing),

          Row(
            children: [
              Icon(Icons.insights_sharp, size: 16, color: Colors.amber.shade500),
              SizedBox(width: tinySpacing),
              Text(
                "Key Features",
                style: sectionTitleStyle,
              ),
            ],
          ),

          SizedBox(height: smallSpacing),

          isMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: visibleFeatures
                .map((feature) => FeatureTile(title: feature))
                .toList(),
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: visibleFeatures
                      .take(halfLength)
                      .map((feature) => FeatureTile(title: feature))
                      .toList(),
                ),
              ),

              SizedBox(width: columnSpacing),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: visibleFeatures
                      .skip(halfLength)
                      .map((feature) => FeatureTile(title: feature))
                      .toList(),
                ),
              ),
            ],
          ),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return ClipRect(
                child: SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: -1,
                  child: child,
                ),
              );
            },

            child: !isExpanded
                ? const SizedBox.shrink()
                : Container(
              key: const ValueKey('expanded-content'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: sectionSpacing),

                  Divider(
                    thickness: 1,
                    color: AppColors.borderColor(context),
                  ),

                  SizedBox(height: sectionSpacing),

                  isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.code_off_rounded,
                                  size: 16,
                                  color: Colors.cyan[500],
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Tech Stack",
                                  style: mobileSectionTitleStyle,
                                ),
                              ],
                            ),
                            SizedBox(height: smallSpacing),
                            // TODO(Rahul): Replace Map access with strongly typed TechStack model.
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: project.techStack
                                  .map(
                                    (tech) => BadgePill(
                                      label: tech['name'] as String,
                                      color: tech['color'] as Color,
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  Icons.lightbulb_outline_rounded,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Challenges Solved",
                                  style: mobileSectionTitleStyle,
                                ),
                              ],
                            ),
                            SizedBox(height: smallSpacing),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: project.challengesSolved
                                  .map(
                                    (challenge) => FeatureTile(
                                      icon: Icon(Icons.arrow_right_rounded),
                                      title: challenge,
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(height: 12),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ActionButton(
                                githubUrl: project.githubUrl ?? '',
                                liveUrl: project.liveUrl,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Tech Stack section title as a horizontal row
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.code_off_rounded,
                                        size: 16,
                                        color: Colors.cyan[500],
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Tech Stack',
                                        style: sectionTitleStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: smallSpacing),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: project.techStack
                                        .map(
                                          (tech) => BadgePill(
                                            label: tech['name'] as String,
                                            color: tech['color'] as Color,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(height: 30),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: ActionButton(
                                        githubUrl: project.githubUrl ?? '',
                                        liveUrl: project.liveUrl,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: desktopSpacing),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Challenges solved section title as a horizontal row
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.lightbulb_outline_rounded,
                                        size: 16,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Challenges Solved',
                                        style: sectionTitleStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: smallSpacing),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: project.challengesSolved
                                        .map(
                                          (challenge) => FeatureTile(
                                            icon: Icon(Icons.arrow_right_rounded),
                                            title: challenge,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
