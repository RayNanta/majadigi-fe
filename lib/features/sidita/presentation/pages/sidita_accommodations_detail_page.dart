import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../services/sidita_models.dart'; // 🟢 Import model agar dikenali

class SiditaSinghasariPage extends StatelessWidget {
  // 🟢 1. Terima data objek akomodasi secara dinamis dari GoRouter extra
  final AkomodasiModel akomodasi;

  const SiditaSinghasariPage({
    super.key,
    required this.akomodasi,
  });

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
            // APP BAR DINAMIS
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
                      akomodasi.namaAkomodasi, // 🟢 Nama akomodasi riil di App Bar
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // BODY AREA
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HERO IMAGE STACK
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 520, // Dioptimalkan ukurannya agar proporsional
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // 🟢 Foto Utama Dinamis (Bisa Network Link / Local Fallback)
                              akomodasi.fotoUrl != null && akomodasi.fotoUrl!.startsWith('http')
                                  ? Image.network(akomodasi.fotoUrl!, fit: BoxFit.cover)
                                  : Image.asset(
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
                                      Colors.black.withValues(alpha: 0.55),
                                      context.isDarkMode
                                          ? Theme.of(context).scaffoldBackgroundColor
                                          : Colors.white,
                                    ],
                                    stops: const [0.0, 0.40, 0.75, 1.0],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Judul Besar di Atas Gambar
                        Positioned(
                          left: 24,
                          right: 24,
                          bottom: 160,
                          child: Text(
                            akomodasi.namaAkomodasi, // 🟢 Nama Tempat Dinamis
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              height: 1.15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Floating Info Card (Lokasi & Region)
                        Positioned(
                          left: 24,
                          right: 24,
                          bottom: 12,
                          child: Container(
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: context.appSurfaceColor,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: context.appThemedCardShadows([
                                BoxShadow(
                                  color: const Color(0xFF111827).withValues(alpha: 0.06),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ]),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: context.isDarkMode
                                        ? AppColors.welcomeAccent.withValues(alpha: 0.16)
                                        : const Color(0xFFE7F0FF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.hotel_rounded,
                                    size: 30,
                                    color: AppColors.welcomeAccent,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        akomodasi.kabupatenKota, // 🟢 Kabupaten Dinamis
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: context.appTextColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Jawa Timur, Indonesia',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: context.appMutedTextColor,
                                        ),
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

                    // DETAIL INFO & AMENITIES
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 34),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🟢 Rating & Info Harga Ringkas
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Colors.orange, size: 24),
                              const SizedBox(width: 6),
                              Text(
                                '${akomodasi.rating} / 5.0',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: context.appTextColor,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                akomodasi.harga, // 🟢 Harga Dinamis
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.welcomeAccent,
                                ),
                              ),
                              Text(
                                ' /malam',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  color: context.appMutedTextColor,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 40),

                          // TENTANG RESORT
                          Text(
                            'Tentang Penginapan',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: context.appTextColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            akomodasi.deskripsi, // 🟢 Deskripsi Fasilitas Utama Dinamis dari DB Seeder
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.75,
                              color: context.appMutedTextColor,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // FASILITAS UTAMA (MAPPING CHIPS DARI DATABASE SEEDER)
                          Text(
                            'Fasilitas Populer',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: context.appTextColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          akomodasi.fasilitasPopuler.isNotEmpty
                              ? Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: akomodasi.fasilitasPopuler.map((fasilitas) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.welcomeAccent.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.check_circle_outline_rounded, size: 20, color: AppColors.welcomeAccent),
                                    const SizedBox(width: 8),
                                    Text(
                                      fasilitas, // 🟢 Nama Fasilitas Dinamis
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.welcomeAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          )
                              : Text(
                            'Fasilitas standar tersedia.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              color: context.appMutedTextColor,
                            ),
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