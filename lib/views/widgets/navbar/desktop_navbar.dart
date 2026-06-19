import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/views/widgets/navbar/animated_navbar_title.dart';
import 'package:portfolio/views/widgets/navbar/nav_item.dart';
import 'package:portfolio/providers/theme/theme_provider.dart';
import 'package:portfolio/providers/navbar/navbar_provider.dart';

class DesktopNavbar extends ConsumerWidget {
  final String name;
  final String tailname;
  final VoidCallback? onHomeTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  const DesktopNavbar({
    super.key,
    required this.name,
    required this.tailname,
    this.onHomeTap,
    this.onAboutTap,
    this.onProjectsTap,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = AppColors.isDark(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // Breakpoint raised to 950px so it instantly becomes a clean mobile menu
        // on tablets, medium screens, and small browser windows without squeezing links.
        final isMobile = screenWidth < 950;

        final navbarRadius = isMobile ? 24.0 : 30.0;
        final navbarHorizontalMargin = isMobile ? 12.0 : (screenWidth < 1150 ? 16.0 : 30.0);
        final navbarHorizontalPadding = isMobile ? 16.0 : 30.0;
        final navbarVerticalPadding = isMobile ? 3.0 : 10.0;
        final themeIconSize = isMobile ? 18.0 : 20.0;

        final navbarDecoration = BoxDecoration(
          color: AppColors.navbarBackground(context),
          borderRadius: BorderRadius.circular(navbarRadius),
          border: Border.all(
            color: AppColors.borderColor(context),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: isDark ? 36 : 24,
              spreadRadius: -6,
              offset: const Offset(0, 14),
            ),
          ],
        );

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: isMobile ? 6 : 8,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: navbarHorizontalMargin,
              vertical: 5,
            ),
            decoration: navbarDecoration,
            child: Row(
              children: [
                // TITLE / LOGO
                GestureDetector(
                  onTap: () {
                    ref.read(navbarProvider.notifier).changeNavItem('home');
                    onHomeTap?.call();
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: navbarHorizontalPadding,
                      vertical: navbarVerticalPadding,
                    ),
                    child: AnimatedNavbarTitle(
                      name: name,
                      tailname: tailname,
                      fontSize: isMobile ? 13 : 15,
                    ),
                  ),
                ),
                const Spacer(),

                // DESKTOP NAVIGATION LINKS
                if (!isMobile) ...[
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InkWell(
                        onTap: () {
                          ref.read(navbarProvider.notifier).changeNavItem('home');
                          onHomeTap?.call();
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: _NavbarHover(child: const NavItem(title: 'Home')),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InkWell(
                        onTap: () {
                          ref.read(navbarProvider.notifier).changeNavItem('about');
                          onAboutTap?.call();
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: _NavbarHover(child: const NavItem(title: 'About')),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InkWell(
                        onTap: () {
                          ref.read(navbarProvider.notifier).changeNavItem('projects');
                          onProjectsTap?.call();
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: _NavbarHover(child: const NavItem(title: 'Projects')),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InkWell(
                        onTap: () {
                          ref.read(navbarProvider.notifier).changeNavItem('contact');
                          onContactTap?.call();
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: _NavbarHover(child: const NavItem(title: 'Contact')),
                      ),
                    ),
                  ),
                ],

                // THEME TOGGLE
                Padding(
                  padding: EdgeInsets.only(
                    right: isMobile ? 4 : 16,
                  ),
                  child: InkWell(
                    onTap: () {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: _NavbarHover(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                          color: AppColors.primaryText(context),
                          size: themeIconSize,
                        ),
                      ),
                    ),
                  ),
                ),

                // MOBILE MENU
                if (isMobile)
                  PopupMenuButton<String>(
                    tooltip: '',
                    color: AppColors.cardBackground(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 'home':
                          ref.read(navbarProvider.notifier).changeNavItem('home');
                          onHomeTap?.call();
                          break;
                        case 'about':
                          ref.read(navbarProvider.notifier).changeNavItem('about');
                          onAboutTap?.call();
                          break;
                        case 'projects':
                          ref.read(navbarProvider.notifier).changeNavItem('projects');
                          onProjectsTap?.call();
                          break;
                        case 'contact':
                          ref.read(navbarProvider.notifier).changeNavItem('contact');
                          onContactTap?.call();
                          break;
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'home', child: Text('Home')),
                      PopupMenuItem(value: 'about', child: Text('About')),
                      PopupMenuItem(value: 'projects', child: Text('Projects')),
                      PopupMenuItem(value: 'contact', child: Text('Contact')),
                    ],
                    child: _NavbarHover(
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.menu_rounded,
                          color: AppColors.primaryText(context),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavbarHover extends StatefulWidget {
  final Widget child;
  const _NavbarHover({required this.child});
  @override
  State<_NavbarHover> createState() => _NavbarHoverState();
}

class _NavbarHoverState extends State<_NavbarHover> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(0, _isHovered ? -1.5 : 0.0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? (isDark ? AppColors.primary.withValues(alpha: 0.12) : Colors.black.withValues(alpha: 0.06))
                  : Colors.transparent,
              blurRadius: _isHovered ? 18.0 : 0.0,
              offset: Offset(0, _isHovered ? 12.0 : 0.0),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}