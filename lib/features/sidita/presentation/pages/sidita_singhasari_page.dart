import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class SiditaSinghasariPage extends StatelessWidget {
  const SiditaSinghasariPage({super.key});

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeSiditaAccommodations);
  }

  void _showPlaceholder(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label akan kita lanjutkan berikutnya.')),
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
                      'The Singhasari Resort',
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
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 760,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                'assets/images/dummy_image.png',
                                fit: BoxFit.cover,
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.10),
                                      Colors.black.withValues(alpha: 0.45),
                                      context.isDarkMode
                                          ? Theme.of(context)
                                                .scaffoldBackgroundColor
                                                .withValues(alpha: 0.96)
                                          : Colors.white.withValues(
                                              alpha: 0.96,
                                            ),
                                    ],
                                    stops: const [0.0, 0.48, 0.82, 1.0],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 24,
                          right: 24,
                          bottom: 220,
                          child: Text(
                            'The Singhasari\nResort',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              height: 1.12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          right: 24,
                          bottom: 28,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                            decoration: BoxDecoration(
                              color: context.appSurfaceColor,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: context.appThemedCardShadows([
                                BoxShadow(
                                  color: const Color(
                                    0xFF111827,
                                  ).withValues(alpha: 0.08),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ]),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 84,
                                      height: 84,
                                      decoration: BoxDecoration(
                                        color: context.isDarkMode
                                            ? AppColors.welcomeAccent
                                                  .withValues(alpha: 0.16)
                                            : const Color(0xFFE7F0FF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.temple_buddhist_rounded,
                                        size: 38,
                                        color: AppColors.welcomeAccent,
                                      ),
                                    ),
                                    const SizedBox(width: 18),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Kabupaten Ngawi',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                              color: context.appTextColor,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Jawa Timur, Indonesia',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: context.appMutedTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 22,
                                      color: context.appMutedTextColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Batu, Jawa Timur',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: context.appMutedTextColor,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => _showPlaceholder(
                                        context,
                                        'Open in Maps',
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Open in Maps',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        AppColors.welcomeAccent,
                                                  ),
                                            ),
                                            const SizedBox(width: 6),
                                            const Icon(
                                              Icons.open_in_new_rounded,
                                              size: 20,
                                              color: AppColors.welcomeAccent,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 34),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                child: _InfoCard(
                                  icon: Icons.verified_outlined,
                                  title: 'CHSE Certified',
                                  description:
                                      'Standar Protokol Kesehatan Ketat',
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: _InfoCard(
                                  icon: Icons.location_on_outlined,
                                  title: 'Strategis',
                                  description:
                                      'Dekat Jatim Park & Museum Angkut',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 34),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Galeri Foto',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: context.appTextColor,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => _showPlaceholder(
                                  context,
                                  'Semua galeri The Singhasari Resort',
                                ),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.welcomeAccent,
                                  textStyle: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                child: const Text('Lihat Semua'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.asset(
                                    'assets/images/dummy_image.png',
                                    height: 170,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.asset(
                                    'assets/images/dummy_image.png',
                                    height: 170,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 44),
                          Text(
                            'Tentang Resort',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: context.appTextColor,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'The Singhasari Resort merupakan perpaduan harmonis antara budaya Kerajaan Singhasari yang agung dengan kemewahan modern. Terletak di dataran tinggi Batu yang sejuk, resort ini menawarkan pengalaman menginap yang tak terlupakan dengan pemandangan pegunungan yang menakjubkan.\n\nSetiap sudut resort dirancang untuk memberikan kenyamanan maksimal, mulai dari lobi yang megah hingga fasilitas kelas dunia yang tersedia untuk seluruh keluarga.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.85,
                              color: context.appMutedTextColor,
                            ),
                          ),
                          const SizedBox(height: 34),
                          Text(
                            'Fasilitas Utama',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: context.appTextColor,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Wrap(
                            spacing: 14,
                            runSpacing: 14,
                            children: const [
                              _FacilityChip(
                                icon: Icons.wifi_rounded,
                                label: 'Free WiFi',
                              ),
                              _FacilityChip(
                                icon: Icons.pool_rounded,
                                label: 'Kolam Renang',
                              ),
                              _FacilityChip(
                                icon: Icons.restaurant_rounded,
                                label: 'Restoran',
                              ),
                              _FacilityChip(
                                icon: Icons.fitness_center_rounded,
                                label: 'Gym Center',
                              ),
                              _FacilityChip(
                                icon: Icons.spa_rounded,
                                label: 'Spa & Sauna',
                              ),
                            ],
                          ),
                        ],
                      ),
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: AppColors.welcomeAccent),
          const SizedBox(height: 14),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: context.appTextColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.55,
              color: context.appMutedTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _FacilityChip extends StatelessWidget {
  const _FacilityChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.appSelectedChipColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: AppColors.welcomeAccent),
          const SizedBox(width: 10),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.welcomeAccent,
            ),
          ),
        ],
      ),
    );
  }
}
