import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  // TODO(Rahul): Migrate all form images to SVG.
  final Widget icon;
  final int maxLines;
  final TextInputType keyboardType;
  const InputField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // sizing
    final iconSize = 20.0;
    final borderRadius = 10.0;
    final horizontalPadding = 16.0;
    final verticalPadding =
        maxLines > 1 ? 16.0 : 14.0;

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
      prefixIcon: Padding(
        padding: const EdgeInsets.only(
          left: 14,
          right: 10,
        ),
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: FittedBox(
            fit: BoxFit.contain,
            child: icon,
          ),
        ),
      ),
      prefixIconConstraints:
          const BoxConstraints(),
      hintText: hint,
      hintStyle: hintStyle,
      filled: true,
      fillColor: AppColors.iconBackground(context),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: AppColors.borderColor(context),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: AppColors.secondary,
          width: 1.5,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
    );

    // widget tree
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: inputTextStyle,
      decoration: inputDecoration,
    );
  }
}
