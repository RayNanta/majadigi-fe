import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../services/sidita_models.dart'; // 🟢 Import model event

class SiditaPasarDjadoelPage extends StatelessWidget {
  // 🟢 1. Terima objek event secara dinamis dari GoRouter extra
  final EventWisataModel event;

  const SiditaPasarDjadoelPage({
    super.key,
    required this.event,
  });

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.homeSiditaEvents);
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
            // APP BAR
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
                      event.namaEvent, // 🟢 Nama Event Dinamis di App Bar
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
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 600,
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
                                      Colors.black.withValues(alpha: 0.12),
                                      Colors.black.withValues(alpha: 0.40),
                                      context.isDarkMode
                                          ? Theme.of(context).scaffoldBackgroundColor
                                          : Colors.white,
                                    ],
                                    stops: const [0.0, 0.45, 0.78, 1.0],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 24,
                          right: 24,
                          bottom: 160,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.welcomeAccent,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(
                                  event.isBerbayar ? 'TICKETED' : 'FREE EVENT', // 🟢 Label status tiket dinamis
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.6,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                event.namaEvent, // 🟢 Nama Event Dinamis
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 24,
                          right: 24,
                          bottom: 12,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
                            decoration: BoxDecoration(
                              color: context.appSurfaceColor,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: context.appThemedCardShadows([
                                BoxShadow(
                                  color: const Color(0xFF111827).withValues(alpha: 0.08),
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
                                      width: 68,
                                      height: 68,
                                      decoration: BoxDecoration(
                                        color: context.isDarkMode
                                            ? AppColors.welcomeAccent.withValues(alpha: 0.16)
                                            : const Color(0xFFE7F0FF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.festival_rounded, // Ganti icon lebih match rill
                                        size: 32,
                                        color: AppColors.welcomeAccent,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            event.kabupatenKota, // 🟢 Kota Dinamis
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: context.appTextColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            event.namaTempatLokasi, // 🟢 Lokasi spesifik dinamis
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: context.appMutedTextColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'JADWAL & OPERASIONAL',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.8,
                                    color: context.appMutedTextColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${event.tanggalMulai} s/d ${event.tanggalSelesai}\n(${event.jamOperasional})', // 🟢 Tanggal & Jam Dinamis rill
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: context.appTextColor,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => _showPlaceholder(context, 'Open in Maps'),
                                      borderRadius: BorderRadius.circular(12),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Maps',
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.welcomeAccent,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            const Icon(Icons.open_in_new_rounded, size: 18, color: AppColors.welcomeAccent),
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
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 34),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tentang Acara',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: context.appTextColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            event.deskripsiAcara, // 🟢 Deskripsi Riil dari Seeder
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.80,
                              color: context.appMutedTextColor,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Ekstra Detail: Penyelenggara & HTM rill
                          Text(
                            'Informasi Tambahan',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: context.appTextColor,
                            ),
                          ),
                          const SizedBox(height: 14),
                          _InfoRow(label: 'Penyelenggara', value: event.penyelenggara),
                          const SizedBox(height: 10),
                          _InfoRow(label: 'Harga Tiket (HTM)', value: event.hargaTiket),
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

// Komponen Pembantu Informasi Tambahan rill
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600, color: context.appTextColor)),
        Expanded(child: Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w500, color: context.appMutedTextColor))),
      ],
    );
  }
}