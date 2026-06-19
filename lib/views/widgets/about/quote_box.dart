import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';

class QuoteBox extends StatelessWidget {
  final String quote;

  const QuoteBox({
    super.key,
    this.quote =
        'Code is not just what I write,\n'
        'it’s how I solve problems.',
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final width = Responsive.width(context);

    final quoteTextStyle = TextStyle(
      color: AppColors.secondaryText(context),
      fontSize: isMobile ? 16 : 18,
      height: 1.4,
      letterSpacing: 0.3,
      fontStyle: FontStyle.italic,
    );

    final quoteMarkStyle = TextStyle(
      color: AppColors.primary,
      fontSize: isMobile ? 22 : 26,
      fontWeight: FontWeight.w600,
    );

    return Container(
      width: isTablet
          ? width * 0.4
          : double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 14 : 16,
        vertical: isMobile ? 10 : 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.sectionBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor(context)),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: quoteTextStyle,
          children: [
            TextSpan(
              text: '\u201C',
              style: quoteMarkStyle,
            ),
            TextSpan(
              text: quote,
            ),
            TextSpan(
              text: '\u201D',
              style: quoteMarkStyle,
            ),
          ],
        ),
      ),
    );
  }
}
