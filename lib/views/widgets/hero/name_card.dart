import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';
import 'package:portfolio/views/widgets/common/social_hover_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/portfolio_data.dart';
import '../buttons/primary_button.dart';

class NameCard extends StatefulWidget {
  final VoidCallback? onContactTap;

  const NameCard({super.key, this.onContactTap});

  @override
  State<NameCard> createState() => _NameCardState();
}

class _NameCardState extends State<NameCard> {
  String _animatedName = '';
  bool _hasStarted = false;
  bool _showCursor = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTypingAnimation();
    });
    _startCursorBlink();
  }

  Future<void> _startTypingAnimation() async {
    if (_hasStarted) return;
    _hasStarted = true;
    final fullText = portfolioData.name;

    for (int i = 0; i <= fullText.length; i++) {
      if (!mounted) return;
      setState(() {
        _animatedName = fullText.substring(0, i);
      });
      await Future.delayed(const Duration(milliseconds: 75));
    }
    if (mounted) {
      setState(() => _showCursor = true);
    }
  }

  Future<void> _startCursorBlink() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 700));
      if (!mounted) return;
      setState(() => _showCursor = !_showCursor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = AppColors.isDark(context);

    // 💡 FIXED SIZES: Koi formula nahi, simple clear measurements
    final double titleFontSize = isMobile ? 14.0 : 20.0;
    final double nameFontSize = isMobile ? 32.0 : 54.0;
    final double roleFontSize = isMobile ? 11.0 : 14.0;
    final double descriptionFontSize = isMobile ? 14.0 : 16.5;
    final double socialIconSize = isMobile ? 18.0 : 22.0;
    final double buttonHeight = isMobile ? 40.0 : 48.0;
    final double spacing = isMobile ? 12.0 : 20.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Greeting Text
        Text(
          "Hi, I'm",
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText(context),
          ),
        ),
        SizedBox(height: spacing * 0.5),

        // Animated Name Row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                _animatedName,
                style: TextStyle(
                  height: 1.1,
                  letterSpacing: -0.5,
                  fontSize: nameFontSize,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _showCursor ? 1 : 0.15,
              duration: const Duration(milliseconds: 250),
              child: Container(
                width: isMobile ? 2.0 : 3.5,
                height: nameFontSize * 0.85,
                margin: const EdgeInsets.only(left: 4),
                decoration: BoxDecoration(
                  color: AppColors.blink(context),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spacing * 0.6),

        // Role Pill
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: roleFontSize * 0.8,
            vertical: roleFontSize * 0.3,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            portfolioData.role,
            style: TextStyle(
              fontSize: roleFontSize,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
        SizedBox(height: spacing * 0.8),

        // Body Description RichText
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: descriptionFontSize,
              color: AppColors.primaryText(context),
              height: 1.4,
            ),
            children: [
              TextSpan(text: portfolioData.heroDescription['before']),
              TextSpan(
                text: portfolioData.heroDescription['highlight'],
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(text: portfolioData.heroDescription['after']),
            ],
          ),
        ),
        SizedBox(height: spacing * 1.2),

        // Action Buttons (Get in touch / Resume)
        Wrap(
          spacing: 12.0,
          runSpacing: 8.0,
          children: [
            PrimaryButton(
              label: 'Get in touch',
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
              bgcolor: AppColors.success,
              isPrimary: true,
              onTap: widget.onContactTap,
              buttonHeight: buttonHeight,
            ),
            PrimaryButton(
              label: 'View Resume',
              bgcolor: isDark ? const Color(0xFF101827) : AppColors.navbar,
              textStyle: TextStyle(
                color: AppColors.secondaryText(context),
                fontSize: 14.0,
              ),
              // icon: const Icon(
              //   Icons.visibility_outlined,
              //   size: 20.0,
              // ),
              iconColor: AppColors.secondaryText(context),
              onTap: () async {
                final Uri resumeUri = Uri.parse('${Uri.base.origin}/resume.html');
                await launchUrl(
                  resumeUri,
                  mode: LaunchMode.externalApplication,
                  webOnlyWindowName: '_blank',
                );
              },
              buttonHeight: buttonHeight,
            ),
          ],
        ),
        SizedBox(height: spacing * 1.2),

        // Social Icons Section
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10.0,
          runSpacing: 8.0,
          children: [
            Text(
              "Let's Connect",
              style: TextStyle(
                fontSize: descriptionFontSize,
                color: AppColors.primaryText(context),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4.0),
            ...portfolioData.socialLinks.map((item) {
              return Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: HoverLift(
                  grayscaleOnHover: true,
                  liftOffset: 4,
                  child: SvgPicture.asset(
                    isDark ? item['darkIcon'] : item['lightIcon'],
                    height: socialIconSize,
                    width: socialIconSize,
                  ),
                  onTap: () async {
                    final String? socialUrl = item['url'];
                    final Uri uri = Uri.parse(socialUrl!);
                    await launchUrl(uri, mode: LaunchMode.platformDefault);
                  },
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}