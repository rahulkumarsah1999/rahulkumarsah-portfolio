import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';

class PrivacyNote extends StatelessWidget {
  const PrivacyNote({super.key});

  @override
  Widget build(BuildContext context) {
    // responsive
    final isMobile = Responsive.isMobile(context);

    // sizing
    final iconSize = isMobile ? 12.0 : 14.0;

    final fontSize = isMobile ? 10.0 : 11.0;

    final spacing = 6.0;

    // styles
    final noteStyle = TextStyle(
      color: AppColors.secondaryText(context),
      fontSize: fontSize,
    );

    // widget tree
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          // TODO(Rahul): Replace verified icon with SVG after full icon migration.
          child: Icon(
            Icons.verified_user_rounded,
            color: AppColors.secondaryText(context),
            size: iconSize,
          ),
        ),
        SizedBox(width: spacing),
        Flexible(
          child: Text(
            'Your information is safe with me. I respect your privacy.',
            textAlign: TextAlign.center,
            style: noteStyle,
          ),
        ),
      ],
    );
  }
}
