import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class KhasJatimMainPage extends StatelessWidget {
  const KhasJatimMainPage({super.key});

  static const _features = [
    _KhasJatimFeature(
      title: 'Naskah Kuno Jawa Timur',
      description:
          'Jelajahi ribuan koleksi sastra, babad, dan serat dari berbagai era kerajaan di Jawa Timur yang telah dialihmediakan.',
      buttonLabel: 'Telusuri',
      routeName: RouteNames.homeKhasJatimManuscripts,
    ),
    _KhasJatimFeature(
      title: 'Pendaftaran Naskah Kuno',
      description:
          'Daftarkan koleksi Anda untuk didata dan dibantu proses pelestariannya demi anak cucu.',
      buttonLabel: 'Daftar',
      routeName: RouteNames.homeKhasJatimRegistration,
    ),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeKhasJatim);
  }

  void _handleFeatureTap(BuildContext context, _KhasJatimFeature feature) {
    if (feature.routeName != null) {
      context.pushNamed(feature.routeName!);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Fitur ${feature.title} akan segera tersedia.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.welcomeAccent,
              padding: const EdgeInsets.fromLTRB(16, 18, 20, 18),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _handleBack(context),
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(36, 36),
                    ),
                    icon: const Icon(Icons.arrow_back_rounded, size: 30),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'KHAS JATIM',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 30, 24, 28),
                children: [
                  Text(
                    'Fitur Utama',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: context.appThemedTextColor(
                        const Color(0xFF101218),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  for (final feature in _features) ...[
                    _FeatureCard(
                      feature: feature,
                      onPressed: () => _handleFeatureTap(context, feature),
                    ),
                    if (feature != _features.last) const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature, required this.onPressed});

  final _KhasJatimFeature feature;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 310),
            child: Text(
              feature.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                height: 1.38,
                color: AppColors.welcomeAccent,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: Text(
              feature.description,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 1.7,
                color: context.appThemedMutedTextColor(const Color(0xFF3F434E)),
              ),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 58,
            width: 176,
            child: FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.welcomeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      feature.buttonLabel,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KhasJatimFeature {
  const _KhasJatimFeature({
    required this.title,
    required this.description,
    required this.buttonLabel,
    this.routeName,
  });

  final String title;
  final String description;
  final String buttonLabel;
  final String? routeName;
}
