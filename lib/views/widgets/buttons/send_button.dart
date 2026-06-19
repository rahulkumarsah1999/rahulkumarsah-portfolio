import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';

class SendButton extends StatefulWidget {
  final VoidCallback? onTap;
  final bool isLoading;
  const SendButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // state
    final isDisabled =
        widget.isLoading || widget.onTap == null;

    final isInteractive =
        _isHovered && !isDisabled;

    final gradient = LinearGradient(
      colors: isDisabled
          ? [
              Colors.grey.shade500,
              Colors.grey.shade600,
            ]
          : [
              AppColors.secondary,
              AppColors.accent,
            ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    // styles
    final buttonTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );

    // sizing
    final shadowBlur =
        isInteractive ? 22.0 : 10.0;

    final shadowOffset =
        isInteractive ? 7.0 : 4.0;

    final hoverOffset =
        isInteractive ? -3.0 : 0.0;

    final hoverScale =
        isInteractive ? 1.01 : 1.0;

    final baseShadow = [
      BoxShadow(
        color: (isDisabled
                ? Colors.grey.shade700
                : AppColors.accent.withValues(alpha: 0.35))
            .withValues(alpha: isInteractive ? 0.44 : 0.22),
        blurRadius: shadowBlur,
        offset: Offset(0, shadowOffset),
      ),
    ];

    // widget tree
    return SizedBox(
      width: double.infinity,
      child: MouseRegion(
        onEnter: isDisabled
            ? null
            : (_) => setState(() {
                  _isHovered = true;
                }),
        onExit: isDisabled
            ? null
            : (_) => setState(() {
                  _isHovered = false;
                }),
        cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
        child: GestureDetector(
          onTap: isDisabled ? null : widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.ease,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: baseShadow,
            ),
            transform: Matrix4.identity()
              ..translateByDouble(
                0.0,
                hoverOffset,
                0.0,
                1.0,
              )
              ..scaleByDouble(
                hoverScale,
                hoverScale,
                1.0,
                1.0,
              ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              child: widget.isLoading
                  ? Row(
                      key: const ValueKey('loading'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Sending...',
                          style: buttonTextStyle,
                        ),
                      ],
                    )
                  : Row(
                      key: const ValueKey('idle'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Send Message',
                          style: buttonTextStyle,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
