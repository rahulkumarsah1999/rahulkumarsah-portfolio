
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';

class AnimatedNavbarTitle extends StatefulWidget {
  final String name;
  final String tailname;
  final double fontSize;

  const AnimatedNavbarTitle({
    super.key,
    required this.name,
    required this.tailname,
    this.fontSize = 16,
  });

  @override
  State<AnimatedNavbarTitle> createState() =>
      _AnimatedNavbarTitleState();
}

class _AnimatedNavbarTitleState
    extends State<AnimatedNavbarTitle> {
  String _displayedText = '';
  bool _showDot = true;

  Timer? _typingTimer;
  Timer? _blinkTimer;

  @override
  void initState() {
    super.initState();
    _startTypingAnimation();
    _startBlinkingDot();
  }

  void _startTypingAnimation() {
    final fullText = widget.name;
    int currentIndex = 0;

    _typingTimer = Timer.periodic(
      const Duration(milliseconds: 90),
      (timer) {
        if (currentIndex < fullText.length) {
          setState(() {
            _displayedText += fullText[currentIndex];
          });
          currentIndex++;
        } else {
          timer.cancel();
        }
      },
    );
  }

  void _startBlinkingDot() {
    _blinkTimer = Timer.periodic(
      const Duration(milliseconds: 650),
      (_) {
        if (!mounted) return;

        setState(() {
          _showDot = !_showDot;
        });
      },
    );
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _blinkTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    // state
    final isDark = AppColors.isDark(context);

    // sizing
    final dotFontSize =
        isMobile ? 18.0 : 20.0;

    // styles
    final nameStyle = TextStyle(
      fontSize: widget.fontSize,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText(context),
      letterSpacing: -0.2,
    );

    final tailStyle = TextStyle(
      fontSize: widget.fontSize,
      fontWeight: FontWeight.w700,
      color: AppColors.secondary,
      letterSpacing: -0.2,
    );

    final dotStyle = TextStyle(
      fontSize: dotFontSize,
      fontWeight: FontWeight.w900,
      color: isDark
          ? const Color(0xFFFFD54F)
          : const Color(0xFF16A34A),
      height: 1,
    );

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: _displayedText,
            style: nameStyle,
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _showDot ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 1.5,
                ),
                child: Text(
                  '.',
                  style: dotStyle,
                ),
              ),
            ),
          ),
          TextSpan(
            text: widget.tailname,
            style: tailStyle,
          ),
        ],
      ),
    );
  }
}
