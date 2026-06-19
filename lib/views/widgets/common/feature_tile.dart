import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';

class FeatureTile extends StatelessWidget {
  final String title;
  final Widget? icon;
  const FeatureTile({
    super.key,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        icon ??
          const  Icon(
              Icons.check_rounded,
              size: 18,
              color: AppColors.primary,
            ),

        const SizedBox(width: 8),

        Flexible(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.primaryText(context),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
