import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';

class GradientButon extends StatefulWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final double? iconSize;
  final double? fontSize;
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  const GradientButon({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconSize,
    this.fontSize,
    this.spacing,
    this.padding,
  });

  @override
  State<GradientButon> createState() => _GradientButonState();
}

class _GradientButonState extends State<GradientButon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    // sizing
    final resolvedIconSize =
        widget.iconSize ?? (isMobile ? 12.0 : 18.0);

    final resolvedFontSize =
        widget.fontSize ?? (isMobile ? 10.0 : 14.0);

    final resolvedSpacing =
        widget.spacing ?? 8.0;

    final resolvedPadding = widget.padding ??
        const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 14,
        );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.identity()
            ..translateByDouble(
              0.0,
              _isHovered ? -3.0 : 0.0,
              0.0,
              1.0,
            ),
          padding: resolvedPadding,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6C2BFF),
                Color(0xFF3B82F6),
                Color(0xFF38BDF8),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withValues(alpha:
                  _isHovered ? 0.35 : 0.18,
                ),
                blurRadius: _isHovered ? 24 : 14,
                offset: Offset(
                  0,
                  _isHovered ? 10 : 6,
                ),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: resolvedIconSize,
                height: resolvedIconSize,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: widget.icon,
                ),
              ),
              SizedBox(width: resolvedSpacing),
              Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: resolvedFontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
