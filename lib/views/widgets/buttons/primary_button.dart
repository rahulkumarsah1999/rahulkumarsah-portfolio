import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';

class PrimaryButton extends StatefulWidget {
  final String? label;
  final Widget? icon;
  final Color? bgcolor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final bool isPrimary;
  final double? iconSize;
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final double? buttonHeight;

  const PrimaryButton({
    super.key,
    this.label,
    this.icon,
    this.bgcolor,
    this.iconColor,
    this.textStyle,
    this.onTap,
    this.isPrimary = false,
    this.iconSize,
    this.spacing,
    this.padding,
    this.buttonHeight,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    // Sizing Fallbacks - Clean & Predictable
    final resolvedIconSize = widget.iconSize ?? 18.0;
    final resolvedSpacing = widget.spacing ?? 8.0;
    final resolvedHeight = widget.buttonHeight ?? 48.0;

    // FIX: Fixed horizontal padding, vertical dynamically handles by Center/SizedBox height
    final resolvedPadding = widget.padding ?? const EdgeInsets.symmetric(horizontal: 22);

    // FIX: Enforced uniform rounded capsule design
    final BorderRadius capsuleRadius = BorderRadius.circular(30);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _isHovered ? -4.0 : 0.0, 0.0, 1.0)
          ..scaleByDouble(_isHovered ? 1.015 : 1.0, _isHovered ? 1.015 : 1.0, 1.0, 1.0),
        decoration: BoxDecoration(
          borderRadius: capsuleRadius, // Matches inner button perfectly
          gradient: widget.isPrimary
              ? const LinearGradient(
            colors: [
              Color(0xFF6C2BFF),
              Color(0xFF3B82F6),
              Color(0xFF38BDF8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )
              : null,
          color: widget.isPrimary
              ? null
              : widget.bgcolor ?? AppColors.cardBackground(context),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? (widget.isPrimary ? const Color(0xFF3B82F6) : AppColors.secondary).withValues(alpha: 0.25)
                  : Colors.transparent,
              blurRadius: _isHovered ? 20 : 0,
              offset: Offset(0, _isHovered ? 10 : 0),
            ),
          ],
        ),
        child: SizedBox(
          height: resolvedHeight, // Explicitly locks button viewport bounds
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.isPrimary
                  ? Colors.transparent
                  : widget.bgcolor ?? AppColors.cardBackground(context),
              shadowColor: Colors.transparent,
              overlayColor: isDark
                  ? AppColors.primary.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.04),
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: capsuleRadius, // Fixed: Sync with Container radius
              ),
              padding: resolvedPadding,
              side: widget.isPrimary
                  ? BorderSide.none
                  : BorderSide(
                color: AppColors.borderColor(context),
              ),
            ),
            onPressed: widget.onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 180),
                    offset: _isHovered ? const Offset(0.05, 0) : Offset.zero,
                    child: SizedBox(
                      width: resolvedIconSize,
                      height: resolvedIconSize,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: widget.icon,
                      ),
                    ),
                  ),
                  SizedBox(width: resolvedSpacing),
                ],
                if (widget.label != null)
                  Text(
                    widget.label!,
                    style: widget.textStyle ??
                        TextStyle(
                          color: widget.isPrimary
                              ? Colors.white
                              : AppColors.primaryText(context),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                          fontSize: 15,
                        ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}