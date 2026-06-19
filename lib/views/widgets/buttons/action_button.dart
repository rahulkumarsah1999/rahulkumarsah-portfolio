import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/utils/responsive/responsive.dart';

import '../../../data/portfolio_data.dart';
import '../../../utils/helpers/icon_helper.dart';

class ActionButton extends StatelessWidget {
  final String githubUrl;
  final String? liveUrl;

  const ActionButton({
    super.key,
    required this.githubUrl,
    this.liveUrl,
  });

  Future<void> _launchUrl(String url) async {
    try {
      final String normalizedUrl =
      url.startsWith('http')
          ? url
          : 'https://$url';

      debugPrint('Opening URL => $normalizedUrl');

      final Uri uri = Uri.parse(normalizedUrl);

      final bool launched = await launchUrl(
        uri,
        webOnlyWindowName: '_blank',
      );

      if (!launched) {
        debugPrint('Could not launch: $normalizedUrl');
      }
    } catch (e) {
      debugPrint('URL Launch Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // responsive
    final isMobile = Responsive.isMobile(context);

    // sizing
    final spacing = isMobile ? 8.0 : 10.0;
    final iconSize = isMobile ? 16.0 : 18.0;
    final github =
    portfolioData.socialLinks.firstWhere(
          (social) =>
      social['name'] == 'GitHub',
    );

    // widget tree
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: [
        /// GitHub Button
        if (githubUrl.isNotEmpty)
          ElevatedButton.icon(
            onPressed: () => _launchUrl(githubUrl),
            icon: SvgPicture.asset(getIcon(context, github),height: iconSize, width: iconSize,),
            label: const Text('GitHub'),
          ),

        /// Live Demo Button
        if (liveUrl != null && liveUrl!.isNotEmpty)
          ElevatedButton.icon(
            onPressed: () => _launchUrl(liveUrl!),
            icon: Icon(
              Icons.open_in_new_rounded,
              size: iconSize,
            ),
            label: const Text('Live Demo'),
          ),
      ],
    );
  }
}