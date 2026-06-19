import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/utils/responsive/responsive.dart';
import 'package:portfolio/views/widgets/featured_project/details_section.dart';
import 'package:portfolio/views/widgets/featured_project/image_section.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final ValueChanged<bool>? onExpandChanged;

  const ProjectCard({
    super.key,
    required this.project,
    this.onExpandChanged,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isExpanded = false;
  bool _isHovered = false;

  Future<void> _toggleExpand() async {
    final nextExpanded = !_isExpanded;

    if (!mounted) return;

    if (nextExpanded) {
      widget.onExpandChanged?.call(true);

      await Future.delayed(const Duration(milliseconds: 120));

      if (!mounted) return;

      setState(() {
        _isExpanded = true;
      });
    } else {
      setState(() {
        _isExpanded = false;
      });

      await Future.delayed(const Duration(milliseconds: 260));

      if (!mounted) return;

      widget.onExpandChanged?.call(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // responsive
    final isMobile = Responsive.isMobile(context);
    final isSmallMobile = MediaQuery.of(context).size.width < 360;

    // state
    final project = widget.project;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // sizing
    final horizontalPadding = isMobile ? 12.0 : 20.0;
    final cardPaddingHorizontal = isMobile ? 12.0 : 20.0;
    final cardPaddingVertical = isMobile ? 16.0 : 14.0;
    final aspectRatio = isMobile ? 16 / 11.5 : 16 / 8.8;
    final hoverScale = (!isMobile && _isHovered) ? 1.015 : 1.0;
    final hoverOffset = (!isMobile && _isHovered) ? -4.0 : 0.0;
    final shadowBlur = (!isMobile && _isHovered) ? 32.0 : 18.0;
    final shadowOffset = (!isMobile && _isHovered) ? 18.0 : 10.0;

    // styles
    final buttonTextStyle = TextStyle(
      color: AppColors.secondary,
      fontSize: isMobile ? 8 : 10,
      fontWeight: FontWeight.w700,
    );

    // decoration
    final cardColor = isDarkMode ? AppColors.cardBackground(context) : Colors.white;

    final overlayColor = isDarkMode
        ? Colors.black.withAlpha(76)
        : Colors.white.withAlpha(170);

    final shadowColor = isDarkMode
        ? Colors.black.withAlpha((_isHovered ? 50 : 25).round())
        : Colors.black.withAlpha((_isHovered ? 18 : 10).round());

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 6,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 700,
          ),
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            cursor: SystemMouseCursors.click,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              scale: hoverScale,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                transform: Matrix4.translationValues(
                  0,
                  hoverOffset,
                  0,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.22),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: shadowBlur,
                        spreadRadius: -5,
                        offset: Offset(0, shadowOffset),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      if (!isMobile)
                        Positioned.fill(
                          child: AnimatedScale(
                            scale: _isHovered ? 1.03 : 1.0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutCubic,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      sigmaX: 12,
                                      sigmaY: 12,
                                    ),
                                    child: ImageSection(project: project),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Container(color: overlayColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 520),
                        curve: Curves.easeOutCubic,
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: cardPaddingHorizontal,
                            vertical: cardPaddingVertical,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: aspectRatio,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    clipBehavior: Clip.antiAlias,
                                    child: ImageSection(project: project),
                                  ),
                                ),
                              ),
                              SizedBox(height: isMobile ? 16 : 10),
                              DetailsSection(
                                project: project,
                                isExpanded: _isExpanded,
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: _toggleExpand,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOutCubic,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile
                                        ? (isSmallMobile ? 14 : 16)
                                        : 18,
                                    vertical: isMobile ? 4 : 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                      colors: _isExpanded
                                          ? [
                                              AppColors.primary.withValues(alpha: .20),
                                              AppColors.secondary.withValues(alpha: .12),
                                            ]
                                          : [
                                              AppColors.primary.withValues(alpha: .14),
                                              Colors.white.withValues(alpha: .04),
                                            ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    border: Border.all(
                                      color: AppColors.primary.withValues(alpha: .22),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(alpha: .10),
                                        blurRadius: 14,
                                        spreadRadius: -4,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AnimatedRotation(
                                        turns: _isExpanded ? 0.5 : 0,
                                        duration: const Duration(milliseconds: 350),
                                        child: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: AppColors.secondary,
                                          size: isMobile ? 14 : 18,
                                        ),
                                      ),
                                      SizedBox(width: isMobile ? 6 : 8),
                                      AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 250),
                                        child: Text(
                                          _isExpanded ? 'Show Less' : 'View More',
                                          key: ValueKey(_isExpanded),
                                          style: buttonTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
