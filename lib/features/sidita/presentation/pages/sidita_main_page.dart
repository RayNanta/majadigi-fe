import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class SiditaMainPage extends StatelessWidget {
  const SiditaMainPage({super.key});

  static const _items = [
    _SiditaMenuItem(
      title: 'Destinasi\nWisata',
      icon: Icons.explore_rounded,
      routeName: RouteNames.homeSiditaDestinations,
    ),
    _SiditaMenuItem(
      title: 'Akomodasi',
      icon: Icons.bed_rounded,
      routeName: RouteNames.homeSiditaAccommodations,
    ),
    _SiditaMenuItem(
      title: 'Event',
      icon: Icons.calendar_month_rounded,
      routeName: RouteNames.homeSiditaEvents,
    ),
    _SiditaMenuItem(
      title: 'Wisatawan',
      icon: Icons.groups_rounded,
      routeName: RouteNames.homeSiditaTravelers,
    ),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeSidita);
  }

  void _showPlaceholder(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label akan kita lanjutkan berikutnya.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
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
                      'SIDITA',
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Image.asset(
                        'assets/images/dummy_image.png',
                        width: double.infinity,
                        height: 260,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 34),
                    Text(
                      'Apa yang Anda Perlukan?',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 28),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18,
                            mainAxisExtent: 352,
                          ),
                      itemBuilder: (context, index) {
                        final item = _items[index];

                        return _SiditaFeatureCard(
                          item: item,
                          onTap: () {
                            final routeName = item.routeName;
                            if (routeName != null) {
                              context.pushNamed(routeName);
                              return;
                            }

                            _showPlaceholder(context, item.title);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SiditaMenuItem {
  const _SiditaMenuItem({
    required this.title,
    required this.icon,
    this.routeName,
  });

  final String title;
  final IconData icon;
  final String? routeName;
}

class _SiditaFeatureCard extends StatelessWidget {
  const _SiditaFeatureCard({required this.item, required this.onTap});

  final _SiditaMenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 116,
                height: 116,
                decoration: const BoxDecoration(
                  color: Color(0xFFE7F0FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 42,
                  color: AppColors.welcomeAccent,
                ),
              ),
              const SizedBox(height: 42),
              Text(
                'DATA',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: AppColors.welcomeAccent,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                item.title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1C22),
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
