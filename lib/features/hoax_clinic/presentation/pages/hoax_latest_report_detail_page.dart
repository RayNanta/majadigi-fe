import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../services/hoax_models.dart';

class HoaxLatestReportDetailPage extends StatelessWidget {
  // 🟢 Terima objek model dinamis dari GoRouter extra argumen rill
  final HoaxReportModel item;

  const HoaxLatestReportDetailPage({
    super.key,
    required this.item,
  });

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.homeHoaxClinicMain);
  }

  // Helper dinamis warna status
  Color _getAccentColor(String status) {
    switch (status.toLowerCase()) {
      case 'valid':
      case 'fakta':
        return AppColors.welcomeAccent;
      case 'edukasi':
        return const Color(0xFF9B4FB5);
      case 'hoax':
        return const Color(0xFFC61B2E);
      default:
        return const Color(0xFF6E7395);
    }
  }

  // Helper background status chip
  Color _getBgStatusColor(BuildContext context, String status) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (status.toLowerCase()) {
      case 'valid':
      case 'fakta':
        return isDark ? const Color(0xFF0F3A20) : const Color(0xFFE2F6E9);
      case 'edukasi':
        return isDark ? const Color(0xFF381440) : const Color(0xFFF3E4F9);
      case 'hoax':
        return isDark ? const Color(0xFF4A1720) : const Color(0xFFFBE4EA);
      default:
        return isDark ? const Color(0xFF232533) : const Color(0xFFECEFF5);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color currentAccent = _getAccentColor(item.status);
    final String formattedDate = item.createdAt.length > 19
        ? item.createdAt.substring(0, 19)
        : item.createdAt;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // APP BAR LAYOUT
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
                      'Detail Laporan rill',
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

            // DETAIL BODY CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 34, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // STATUS BADGE CHIP
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: _getBgStatusColor(context, item.status),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        item.status.toUpperCase(),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: currentAccent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // DESKRIPSI UTAMA SEBAGAI JUDUL
                    Text(
                      item.deskripsiLaporan,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        height: 1.42,
                        color: context.appTextColor,
                      ),
                    ),
                    const SizedBox(height: 34),

                    // META INFO DARI BACKEND
                    Wrap(
                      spacing: 26,
                      runSpacing: 14,
                      children: [
                        _MetaInfoChip(
                          icon: Icons.calendar_today_outlined,
                          label: formattedDate,
                        ),
                        _MetaInfoChip(
                          icon: Icons.confirmation_number_outlined,
                          label: item.nomorTiket,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // CUSTOM POSTER PREVIEW (Dinamis Data Model)
                    _HoaxPosterPreview(item: item, accentColor: currentAccent),
                    const SizedBox(height: 34),

                    // LINK RUJUKAN BUKTI
                    Text(
                      'Link Rujukan Bukti',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: context.appTextColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
                      decoration: BoxDecoration(
                        color: context.appSurfaceColor,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: context.appThemedCardShadows([
                          BoxShadow(
                            color: const Color(0xFF111827).withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ]),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.isDarkMode
                                  ? AppColors.welcomeAccent.withValues(alpha: 0.18)
                                  : const Color(0xFFDDEBFF),
                            ),
                            child: Icon(
                              Icons.link_rounded,
                              size: 30,
                              color: AppColors.welcomeAccent,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Text(
                              item.urlBukti != null && item.urlBukti!.isNotEmpty
                                  ? item.urlBukti!
                                  : 'Tidak ada lampiran link rujukan rill.',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: item.urlBukti != null && item.urlBukti!.isNotEmpty
                                    ? AppColors.welcomeAccent
                                    : context.appMutedTextColor,
                              ),
                            ),
                          ),
                          if (item.urlBukti != null && item.urlBukti!.isNotEmpty) ...[
                            const SizedBox(width: 12),
                            Icon(
                              Icons.open_in_new_rounded,
                              size: 34,
                              color: context.appMutedTextColor,
                            ),
                          ],
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

class _MetaInfoChip extends StatelessWidget {
  const _MetaInfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: context.appMutedTextColor),
        const SizedBox(width: 12),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: context.appMutedTextColor,
          ),
        ),
      ],
    );
  }
}

class _HoaxPosterPreview extends StatelessWidget {
  final HoaxReportModel item;
  final Color accentColor;

  const _HoaxPosterPreview({
    required this.item,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _PosterLogo(
                label: 'KOMINFO JATIM',
                accent: AppColors.welcomeAccent,
              ),
              const SizedBox(width: 8),
              _PosterLogo(label: 'MAJADIGI APP', accent: const Color(0xFF0E7B34)),
              const Spacer(),
              _PosterLogo(
                label: 'KLINIK HOAKS',
                accent: const Color(0xFFC61B2E),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accentColor, accentColor.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                item.status.toUpperCase(),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Isi Pengaduan Masuk:',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.deskripsiLaporan,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.65,
              color: context.appTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Pelapor: ',
                style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                item.namaPelapor,
                style: GoogleFonts.plusJakartaSans(fontSize: 13, color: context.appMutedTextColor),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0B3A93), Color(0xFF70A7FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Validitas Sistem',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.nomorTiket,
                      style: GoogleFonts.robotoMono(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // BOX CONTAINER PLACEHOLDER BUKTI GAMBAR JIKA ADA
                Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: accentColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.urlBukti != null && item.urlBukti!.isNotEmpty
                              ? Icons.image_outlined
                              : Icons.gavel_rounded,
                          color: Colors.white70,
                          size: 36,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'ID Laporan: #${item.id}',
                          style: GoogleFonts.robotoMono(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: const [
                    Expanded(
                      flex: 4,
                      child: _FooterStrip(color: Color(0xFFDF1C25)),
                    ),
                    Expanded(
                      flex: 4,
                      child: _FooterStrip(color: Color(0xFF2FC5F3)),
                    ),
                    Expanded(
                      flex: 3,
                      child: _FooterStrip(color: Color(0xFF2E3192)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PosterLogo extends StatelessWidget {
  const _PosterLogo({required this.label, required this.accent});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_rounded, size: 14, color: accent),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterStrip extends StatelessWidget {
  const _FooterStrip({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(height: 4, color: color);
  }
}