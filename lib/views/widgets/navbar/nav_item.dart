import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/providers/navbar/navbar_provider.dart';

class NavItem extends ConsumerStatefulWidget {
  final String title;
  const NavItem({
    super.key,
    required this.title,
  });

  @override
  ConsumerState<NavItem> createState() =>
      _NavItemState();
}

class _NavItemState extends ConsumerState<NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final currentNav = ref.watch(navbarProvider);
    final isActive =
        currentNav == widget.title.toLowerCase();

    // state
    final isInteractive =
        _isHovered || isActive;

    // sizing
    final horizontalPadding = 18.0;
    final verticalPadding = 14.0;
    final titleFontSize =
        _isHovered ? 14.5 : 14.0;

    final indicatorWidth =
        isInteractive ? 22.0 : 0.0;

    // styles
    final titleStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: titleFontSize,
      letterSpacing: -0.15,
      color: isInteractive
          ? AppColors.primary
          : AppColors.secondaryText(context),
    );

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(
                milliseconds: 180,
              ),
              style: titleStyle,
              child: Text(
                widget.title,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 220,
              ),
              curve: Curves.easeOut,
              height: 2,
              width: indicatorWidth,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius:
                    BorderRadius.circular(999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
