import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class IslamicCenterMainPage extends StatelessWidget {
  const IslamicCenterMainPage({super.key});

  static const _facilities = [
    _FacilityItem(
      title: 'Aula',
      description:
          'Ruang pertemuan megah untuk seminar, wisuda, dan acara skala besar.',
      tags: ['Hall Utama', 'Kapasitas 500+'],
      routeName: RouteNames.homeIslamicCenterAula,
    ),
    _FacilityItem(
      title: 'Asrama',
      description:
          'Hunian nyaman dan strategis untuk peserta kegiatan menginap.',
      tags: ['Kamar 2 Bed', 'Full AC'],
      routeName: RouteNames.homeIslamicCenterAsrama,
    ),
    _FacilityItem(
      title: 'Ruangan Masjid',
      description:
          'Ruang serbaguna masjid untuk pengajian dan pertemuan tertutup.',
      tags: ['Ruang VIP', 'Audio System'],
      routeName: RouteNames.homeIslamicCenterMasjid,
    ),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeIslamicCenter);
  }

  void _showPlaceholder(BuildContext context, String label) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Detail $label akan kita lanjutkan berikutnya.',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
          ),
        ),
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
                      'ISLAMIC CENTER JAWA TIMUR',
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
                itemCount: _facilities.length + 1,
                separatorBuilder: (_, index) =>
                    SizedBox(height: index == 0 ? 24 : 28),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Text(
                      'Pilih Fasilitas Sesuai Kebutuhan Anda',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF20242C),
                        height: 1.25,
                      ),
                    );
                  }

                  final item = _facilities[index - 1];
                  return _FacilityCard(
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
            ),
          ],
        ),
      ),
    );
  }
}

class _FacilityItem {
  const _FacilityItem({
    required this.title,
    required this.description,
    required this.tags,
    this.routeName,
  });

  final String title;
  final String description;
  final List<String> tags;
  final String? routeName;
}

class _FacilityCard extends StatelessWidget {
  const _FacilityCard({required this.item, required this.onTap});

  final _FacilityItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF111827).withValues(alpha: 0.04),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 22),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                        child: Image.asset(
                          'assets/images/dummy_image.png',
                          width: double.infinity,
                          height: 270,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 18,
                        child: _OverlayPill(
                          label: 'TERSEDIA',
                          backgroundColor: Colors.white,
                          textColor: AppColors.welcomeAccent,
                        ),
                      ),
                      const Positioned(
                        top: 16,
                        right: 18,
                        child: _RatingChip(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF262A32),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item.description,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.55,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: item.tags
                            .map((tag) => _TagChip(label: tag))
                            .toList(),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        height: 62,
                        child: FilledButton(
                          key: ValueKey('facility-detail-${item.title}'),
                          onPressed: onTap,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.welcomeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(31),
                            ),
                            textStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: const Text('Lihat Detail'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OverlayPill extends StatelessWidget {
  const _OverlayPill({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
          color: textColor,
        ),
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  const _RatingChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF7B4B17).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 18, color: Color(0xFFFCD34D)),
          const SizedBox(width: 6),
          Text(
            '4.9',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F0FF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColors.welcomeAccent,
        ),
      ),
    );
  }
}
