import 'package:flutter/material.dart';
import 'package:portfolio/views/widgets/hero/image_background.dart';
import 'package:portfolio/views/widgets/hero/name_card.dart';
import '../../utils/responsive/responsive.dart';

class HeroSection extends StatefulWidget {
  final double width;
  final bool isMobile;
  final VoidCallback? onContactTap;

  const HeroSection({
    super.key,
    required this.width,
    required this.isMobile,
    required this.onContactTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final GlobalKey _internalNameCardKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenHeight = Responsive.height(context);
    final isDesktop = Responsive.isDesktop(context);

    // 💡 FIXED MEASUREMENTS: Complex expressions strictly removed
    final double horizontalPadding = widget.isMobile ? 20.0 : 60.0;
    final double topPadding = widget.isMobile ? 50.0 : 80.0;
    final double bottomPadding = widget.isMobile ? 10.0 : 40.0;
    final double imageSize = widget.isMobile ? 350.0 : 460.0;

    final preservedNameCard = NameCard(
      key: _internalNameCardKey,
      onContactTap: widget.onContactTap,
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Container(
          // Strict layout framework restrictions for ultra-wide monitors
          constraints: BoxConstraints(
            minHeight: screenHeight,
            maxWidth: 1440,
          ),
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            top: topPadding,
            bottom: bottomPadding,
          ),
          child: isDesktop
              ? SizedBox(
            // Center alignment layout bounds
            height: screenHeight - topPadding - bottomPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text Profile Information Engine
                Expanded(
                  flex: 12,
                  child: preservedNameCard,
                ),
                const Spacer(flex: 1),
                // Avatar Graphic Canvas
                Expanded(
                  flex: 10,
                  child: Center(
                    child: SizedBox(
                      width: imageSize,
                      height: imageSize,
                      child: const Imagebackground(),
                    ),
                  ),
                ),
              ],
            ),
          )
              : SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: const Imagebackground(),
                  ),
                ),
                const SizedBox(height: 22.0),
                preservedNameCard,
              ],
            ),
          ),
        ),
      ),
    );
  }
}