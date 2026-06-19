
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/core/constants/app_colors.dart';
import 'package:portfolio/utils/responsive/responsive.dart';
import 'package:portfolio/views/widgets/buttons/gradient_buton.dart';
import 'package:portfolio/views/widgets/cards/opportunity_card.dart';
import 'package:portfolio/views/widgets/contact/contact_info.dart';
import 'package:portfolio/views/widgets/common/section_title.dart';
import 'package:portfolio/views/widgets/common/social_hover_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web/web.dart' as web;

import '../../../data/portfolio_data.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = AppColors.isDark(context);
    // sizing
    final socialIconSize = isMobile ? 20.0 : 22.0;
    final socialSpacing = isMobile ? 10.0 : 20.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SectionTitle(title: "Let's Build Something\n",
        subtitle: ' Amazing Together',
          fontSize: 25,
        ),
        const SizedBox(height: 20),
         SizedBox(
           width: 520,
           child: Text(
            "I'm always excited to work on new ideas, innovative "
                "projects or opportunities. Let's connect and "
                "create something impactful.",
            style: TextStyle(
              color: AppColors.primaryText(context),
              fontSize: 15,
              height: 1.7,
            ),
                   ),
         ),
        const SizedBox(height: 20),
        Container(
          width: 120,
          height: 2,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.secondary, AppColors.accent],
            ),
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
        ),

        const SizedBox(height: 28),
        ContactInfo(
          circleColor: AppColors.secondary.withValues(alpha: 0.2),
          icon: Icon(
            Icons.email_rounded,color: AppColors.primary,
          ),
          label: 'Email',
          labelColor: AppColors.secondary,
          value: 'rkhhp713@gmail.com',
        ),
        const SizedBox(height: 20),
        ContactInfo(
          circleColor: AppColors.success.withValues(alpha: 0.2),
          icon: Icon(
            Icons.phone_in_talk_rounded,
            color: AppColors.success.withValues(alpha: 0.48),
          ),
          label: 'Phone',
          labelColor: AppColors.success,
          value: '+91 7902070478',
        ),
        const SizedBox(height: 20),
        ContactInfo(
          circleColor: const Color(0xFFFF9800).withValues(alpha: 0.2),
          icon: Icon(
            Icons.location_on_rounded,
            color: const Color(0xFFFF9800),
          ),
          label: 'Location',
          labelColor: const Color(0xFFFF9800),
          value: 'Bihar, India',
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Text(
              "Let's Connect",
              style: TextStyle(
                color: AppColors.primaryText(
                  context,
                ),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: socialSpacing,
            ),
            ...portfolioData.socialLinks.map((item) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: HoverLift(
                  grayscaleOnHover: true,
                  child: SvgPicture.asset(
                    isDark
                        ? item['darkIcon']
                        : item['lightIcon'],
                    height: socialIconSize,
                    width: socialIconSize,
                  ),
                  onTap: () async {
                    final String? socialUrl =
                    item['url'];

                    final Uri uri = Uri.parse(
                      socialUrl!,
                    );

                    final launched =
                    await launchUrl(
                      uri,
                      mode:
                      LaunchMode.platformDefault,
                    );

                    if (!launched) {
                      debugPrint(
                        'Could not launch: $socialUrl',
                      );
                    }
                  },
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 35),
        Align(
          alignment: Alignment.bottomLeft,
          child: GradientButon(
            icon: const Icon(
              Icons.download_rounded,
              color: Colors.white,
            ),
            label: 'Download Resume',
            onTap: () {
              web.HTMLAnchorElement()
                ..href = '/resume.pdf'
                ..download = 'Rahul Kumar Sah Resume.pdf'
                ..click();
            },
          ),
        ),
        const SizedBox(height: 60),
        Align(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
            width: 460,
            child: OpportunityCard(),
          ),
        ),
      ],
    );
  }
}
