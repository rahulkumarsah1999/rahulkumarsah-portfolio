import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/utils/responsive/responsive.dart';

class OtherProjectCard extends StatefulWidget {
  final ProjectModel project;
  final ValueChanged<bool>? onExpandChanged;


  const OtherProjectCard({
    super.key,
    required this.project,
    this.onExpandChanged,
  });

  @override
  State<OtherProjectCard> createState() => _OtherProjectCardState();
}

class _OtherProjectCardState extends State<OtherProjectCard> {
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

    // state
    final project = widget.project;

    // sizing
    final iconSize = isMobile ? 16.0 : 22.0;
    final iconPadding = isMobile ? 8.0 : 12.0;
    final iconRadius = isMobile ? 12.0 : 16.0;
    final minHeight = isMobile ? 120.0 : 160.0;
    final minWidth = isMobile ? 200.0 : 400.0;

    // styles
    final titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText(context),
    );

    final subtitleStyle = TextStyle(
      color: AppColors.secondaryText(context).withValues(alpha: 0.8),
      fontSize: 11,
      fontWeight: FontWeight.w500,
    );

    final descriptionStyle = TextStyle(
      color: AppColors.secondaryText(context),
      fontSize: 12.5,
      height: 1.55,
      letterSpacing: 0.3,
    );

    final statusStyle = const TextStyle(
      color: Colors.blue,
      fontSize: 10,
      fontWeight: FontWeight.w700,
    );

    final actionStyle = TextStyle(
      color: AppColors.primary,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );

    // decoration
    final cardDecoration = BoxDecoration(
      color: AppColors.cardBackground(context),
      borderRadius: BorderRadius.circular(24),
      border:  Border.all(
        color: AppColors.accent.withValues(alpha: .22),
      ),
    );

    final hoverScale = (!isMobile && _isHovered) ? 1.015 : 1.0;
    final hoverOffset = (!isMobile && _isHovered) ? -4.0 : 0.0;


    return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isMobile ? double.infinity : 700,
        ),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _toggleExpand,
            behavior: HitTestBehavior.opaque,
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
            constraints: BoxConstraints(
              minHeight: minHeight,
              minWidth: minWidth,
            ),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(16),
            decoration: cardDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Header
                    Container(
                      padding: EdgeInsets.all(iconPadding),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(iconRadius),
                      ),
                      child: Icon(
                        _getProjectIcon(project.title),
                        color: AppColors.primary,
                        size: iconSize,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Title, Status, and Short/Long Description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  project.title,
                                  style: titleStyle,
                                ),
                              ),
                              // Status Tag
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  project.status,
                                  style: statusStyle,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          // Subtitle
                          Text(
                            project.subtitle,
                            style: subtitleStyle,
                          ),
                          const SizedBox(height: 8),
                          // Description: Limits to 1 line if collapsed, wraps completely if expanded
                          Text(
                            project.description,
                            maxLines: _isExpanded ? null : 1,
                            overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                            style: descriptionStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Dynamic Hidden Block: ONLY shows when expanded
                if (_isExpanded) ...[
                  const SizedBox(height: 16),

                  // Key Features Block
                  if (project.keyFeatures.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.borderColor(context).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Key Features',
                            style: TextStyle(
                              color: AppColors.primaryText(context),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            project.keyFeatures.map((feature) => '• $feature').join('\n'),
                            style: TextStyle(
                              color: AppColors.secondaryText(context),
                              fontSize: 11.5,
                              height: 1.55,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Tech Stack Chips
                  if (project.techStack.isNotEmpty) ...[
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: project.techStack.map((tech) {
                        final String name = tech['name'] as String? ?? '';
                        final Color chipColor = tech['color'] as Color? ?? AppColors.primary;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: chipColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: chipColor.withValues(alpha: 0.2), width: 0.5),
                          ),
                          child: Text(
                            name,
                            style: TextStyle(
                              color: chipColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 4),
                  ],
                ],

                const SizedBox(height: 12),

                // View Details Interactive Trigger Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        _isExpanded ? 'Show Less' : 'View Details',
                        style: actionStyle,
                      ),
                      const Spacer(),
                      AnimatedRotation(
                        turns: _isExpanded ? 0.25 : 0, // Rotates the arrow downwards when expanded
                        duration: const Duration(milliseconds: 250),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ),
    );
  }

  IconData _getProjectIcon(String title) {
    switch (title) {
      case 'LocalMate':
        return Icons.people_alt_rounded;
      case 'SafeTrack':
        return Icons.health_and_safety_rounded;
      default:
        return Icons.laptop_mac_rounded;
    }
  }
}