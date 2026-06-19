import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import '../../../data/portfolio_data.dart';

class FormHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const FormHeader({
    super.key,
    this.title = '',
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    // sizing
    final iconContainerSize = 54.0;
    final iconSize = 24.0;
    final spacing = 16.0;

    // data
    final formHeader = portfolioData.formHeader;

    // styles
    final titleStyle = TextStyle(
      color: AppColors.primaryText(context),
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );

    final subtitleStyle = TextStyle(
      color: AppColors.secondaryText(context),
      fontSize: 12,
      height: 1.5,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: iconContainerSize,
          height: iconContainerSize,
          decoration: BoxDecoration(
            color: AppColors.iconBackground(context),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              formHeader['icon'],
              height: iconSize,
              width: iconSize,
            )
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.isNotEmpty
                    ? title
                    : formHeader['title'],
                style: titleStyle,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle.isNotEmpty
                    ? subtitle
                    : formHeader['subtitle'],
                style: subtitleStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
