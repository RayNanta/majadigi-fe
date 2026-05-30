import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class SinakerMainPage extends StatelessWidget {
  const SinakerMainPage({super.key});

  static const _menus = [
    _SinakerMenuItem(
      routeName: RouteNames.homeSinakerTrainingList,
      title: 'Daftar Pelatihan Kerja',
      subtitle: 'Pendaftaran program pelatihan Kerja',
      icon: Icons.storefront_outlined,
    ),
    _SinakerMenuItem(
      routeName: RouteNames.homeSinakerTrainingCenters,
      title: 'Balai Latihan Kerja',
      subtitle: 'Balai Pelatihan Kerja di Jawa Timur',
      icon: Icons.storefront_outlined,
    ),
    _SinakerMenuItem(
      routeName: RouteNames.homeSinakerTrainingRegistrationList,
      title: 'Cek Pendaftaran Pelatihan',
      subtitle: 'Cek pendaftaran pelatihan yang telah dilakukan',
      icon: Icons.verified_user_rounded,
    ),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeSinaker);
  }

  void _openMenu(BuildContext context, _SinakerMenuItem item) {
    if (item.routeName != null) {
      context.pushNamed(item.routeName!);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.title} akan kita lanjutkan berikutnya.')),
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
                      'SINAKER',
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
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                itemCount: _menus.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 22),
                itemBuilder: (context, index) {
                  final item = _menus[index];

                  return _SinakerMenuCard(
                    item: item,
                    onTap: () => _openMenu(context, item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SinakerMenuCard extends StatelessWidget {
  const _SinakerMenuCard({required this.item, required this.onTap});

  final _SinakerMenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF111827).withValues(alpha: 0.04),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 106,
                height: 106,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F5FF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  item.icon,
                  size: 48,
                  color: AppColors.welcomeAccent,
                ),
              ),
              const SizedBox(width: 22),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0C2B5A),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.subtitle,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF4F5561),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SinakerMenuItem {
  const _SinakerMenuItem({
    this.routeName,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String? routeName;
  final String title;
  final String subtitle;
  final IconData icon;
}
