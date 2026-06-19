import 'package:flutter/material.dart';

/// Reusable hover lift widget for cards, images,
/// icons, buttons and any custom child.
class HoverLift extends StatefulWidget {
  final Widget child;
  final double liftOffset;
  final Duration duration;
  final VoidCallback onTap;
  /// Optional grayscale effect for icons/chips on hover.
  /// Keep false for cards and buttons.
  final bool grayscaleOnHover;

  const HoverLift({
    super.key,
    required this.child,
    required this.onTap,
    this.liftOffset = 2,
    this.duration = const Duration(
      milliseconds: 180,
    ),
    this.grayscaleOnHover = false,
  });

  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: widget.duration,
          transform: Matrix4.translationValues(
            0,
            isHovered ? -widget.liftOffset : 0.0,
            0,
          ),
          child: widget.grayscaleOnHover
              ? ColorFiltered(
                  colorFilter: isHovered
                      ? const ColorFilter.matrix([
                          0.2126, 0.7152, 0.0722, 0, 0,
                          0.2126, 0.7152, 0.0722, 0, 0,
                          0.2126, 0.7152, 0.0722, 0, 0,
                          0, 0, 0, 1, 0,
                        ])
                      : const ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.dst,
                        ),
                  child: widget.child,
                )
              : widget.child,
        ),
      ),
    );
  }
}
