import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';

class MessageField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  // TODO(Rahul): Remove temporary compatibility after full SVG migration.
  final Widget icon;
  const MessageField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // TODO(Rahul): Add responsive sizing if textarea design changes.
    // sizing
    final iconSize = 20.0;
    final borderRadius = 10.0;
    final iconLeftPadding = 16.0;
    final contentLeftPadding = 50.0;

    // styles
    final inputTextStyle = TextStyle(
      color: AppColors.primaryText(context),
      fontSize: 14,
    );

    final hintStyle = TextStyle(
      color: AppColors.secondaryText(context),
      fontSize: 13,
    );

    // decoration
    final inputDecoration = InputDecoration(
      hintText: hint,
      hintStyle: hintStyle,
      filled: true,
      fillColor: AppColors.iconBackground(context),
      contentPadding: EdgeInsets.fromLTRB(
        contentLeftPadding,
        18,
        16,
        18,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: AppColors.borderColor(context),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: AppColors.secondary,
          width: 1.5,
        ),
      ),
    );

    // widget tree
    return Stack(
      children: [
        TextField(
          controller: controller,
          maxLines: 5,
          style: inputTextStyle,
          decoration: inputDecoration,
        ),
        Positioned(
          top: 18,
          left: iconLeftPadding,
          child: SizedBox(
            width: iconSize,
            height: iconSize,
            child: FittedBox(
              fit: BoxFit.contain,
              child: icon,
            ),
          ),
        ),
      ],
    );
  }
}
