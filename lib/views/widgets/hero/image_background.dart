import 'package:portfolio/utils/responsive/responsive.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/core/constants/app_colors.dart';

class Imagebackground extends StatefulWidget {
  const Imagebackground({super.key});

  @override
  State<Imagebackground> createState() => _ImagebackgroundState();
}

class _ImagebackgroundState extends State<Imagebackground>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _orbitController;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 1.0, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.93, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await precacheImage(
        const AssetImage('assets/icons/Logo.png'),
        context,
      );
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = Responsive.isMobile(context);
        final isDark = AppColors.isDark(context);

        final heroSize = constraints.maxWidth.clamp(
          isMobile ? 250.0 : 300.0,
          isMobile ? 400.0 : 460.0,
        );

        final yellowStarColor = const Color(0xFFFFD700);
        final glowPrimary = isDark ? const Color(0xFF051CCC) : const Color(0xFFBE4DFF);
        final glowSecondary = isDark ? const Color(0xFFFF4D9D) : const Color(
            0xFF8C66FF);

        return Padding(
          padding: EdgeInsets.only(right: isMobile ? 0 : 40),
          child: SizedBox(
            height: heroSize,
            width: heroSize,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // 1. Ambient Background Glow
                        Container(
                          height: heroSize,
                          width: heroSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                glowPrimary.withAlpha((0.12 * 255).round()),
                                glowSecondary.withAlpha((0.06 * 255).round()),
                                Colors.transparent,
                              ],
                              stops: const [0.25, 0.60, 1],
                            ),
                          ),
                        ),

                        // 2. Yellow Star - Smooth Organic Trail
                        AnimatedBuilder(
                          animation: _orbitController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _orbitController.value * pi * 2,
                              child: Container(
                                height: heroSize * 0.80,
                                width: heroSize * 0.80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: SweepGradient(
                                    colors: [
                                      Colors.transparent,
                                      yellowStarColor.withValues(alpha: 0.02),
                                      yellowStarColor.withValues(alpha: 0.15),
                                      yellowStarColor.withValues(alpha: 0.45),
                                      yellowStarColor,
                                      Colors.transparent,
                                    ],
                                    stops: const [0.0, 0.40, 0.70, 0.88, 0.98, 1.0],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // 3. Multi-Color Star - Smooth Dynamic Trail (Purple -> Blue -> SkyBlue)
                        AnimatedBuilder(
                          animation: _orbitController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: (_orbitController.value * pi * 2) + pi, // 180° Balanced Offset
                              child: Container(
                                height: heroSize * 0.80,
                                width: heroSize * 0.80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: SweepGradient(
                                    colors: [
                                      Colors.transparent,
                                      const Color(0xFF6C2BFF).withValues(alpha: 0.05), // Purple start
                                      const Color(0xFF3B82F6).withValues(alpha: 0.25), // Blue mix
                                      const Color(0xFF38BDF8).withValues(alpha: 0.60), // SkyBlue peak
                                      const Color(0xFF38BDF8),
                                      Colors.transparent, // Tail sharp edge vanish filter
                                    ],
                                    stops: const [0.0, 0.35, 0.65, 0.85, 0.98, 1.0],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // 4. Structural Inner Ring Border
                        Container(
                          height: heroSize * 0.78,
                          width: heroSize * 0.78,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.cardBackground(context),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.black.withValues(alpha: 0.08),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: glowPrimary.withAlpha((0.15 * 255).round()),
                                blurRadius: 30,
                                spreadRadius: -2,
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.cardBackground(context),
                              boxShadow: [
                                BoxShadow(
                                  color: isDark
                                      ? Colors.black.withValues(alpha: 0.3)
                                      : Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 14,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 5. Profile Image Layer
                        Container(
                          height: heroSize * 0.78,
                          width: heroSize * 0.78,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.cardBackground(context),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            'assets/icons/Logo.png',
                            fit: BoxFit.cover,
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
      },
    );
  }
}