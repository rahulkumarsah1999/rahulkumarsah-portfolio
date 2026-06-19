import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';
import 'package:portfolio/models/project_model.dart';

class ImageSection extends StatelessWidget {
  final ProjectModel project;

  const ImageSection({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    // state

    // responsive
    final isMobile = Responsive.isMobile(context);
    final width = Responsive.width(context);
    final isDark = AppColors.isDark(context);

    // sizing
    final imageSize = isMobile ? width * 0.72 : 320.0;
    final imageWidth = isMobile ? width * 0.92 : 280.0;

    final glowSize = isMobile ? width * 0.82 : 260.0;

    final premiumGlowSize = isMobile ? width * 0.56 : 320.0;

    final imageOffset = isMobile ? 10.0 : 15.0;

    final reflectionOffset = isMobile ? 115.0 : 165.0;
    // widget tree
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: imageWidth,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // soft ambient glow
                Container(
                  width: glowSize,
                  height: glowSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(
                          alpha: isDark ? 0.10 : 0.10,
                        ),
                        blurRadius: isDark ? 90 : 110,
                        spreadRadius: isDark ? 8 : 18,
                      ),
                    ],
                  ),
                ),

                // premium radial glow
                if (isDark)
                  Container(
                    width: premiumGlowSize,
                    height: premiumGlowSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.18),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                // reflection
                Transform.translate(
                  offset: Offset(0, reflectionOffset),
                  child: Opacity(
                    opacity: isDark ? 0.08 : 0.05,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateX(3.1416)
                        ..scaleByDouble(1.0, 0.68, 0.0,1.0),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: 12,
                          sigmaY: 14,
                        ),
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withValues(alpha: 0.55),
                                Colors.transparent,
                              ],
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.dstIn,
                          child: Image.asset(
                            project.images.first,
                            height: imageSize,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // main product image
                Transform.translate(
                  offset: Offset(0, imageOffset),
                  child: Image.asset(
                    project.images.first,
                    height: imageSize,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
