import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class HoaxLatestReportDetailPage extends StatelessWidget {
  const HoaxLatestReportDetailPage({super.key});

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeHoaxClinicMain);
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
                      'Laporan Terkini',
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
                padding: const EdgeInsets.fromLTRB(24, 34, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBE4EA),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'HOAKS',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFB81A2D),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Kabar Donald Trump\nSekarat Akibat Melawan\nIran',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        height: 1.42,
                        color: const Color(0xFF2B315E),
                      ),
                    ),
                    const SizedBox(height: 34),
                    Wrap(
                      spacing: 26,
                      runSpacing: 14,
                      children: const [
                        _MetaInfoChip(
                          icon: Icons.calendar_today_outlined,
                          label: '2026-04-11 10:51:13',
                        ),
                        _MetaInfoChip(
                          icon: Icons.visibility_outlined,
                          label: '28 Views',
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const _HoaxPosterPreview(),
                    const SizedBox(height: 34),
                    Text(
                      'Link Rujukan',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2B315E),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF111827,
                            ).withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 62,
                            height: 62,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFDDEBFF),
                            ),
                            child: const Icon(
                              Icons.link_rounded,
                              size: 30,
                              color: AppColors.welcomeAccent,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Text(
                              'https://tirto.id/',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.welcomeAccent,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.open_in_new_rounded,
                            size: 34,
                            color: Color(0xFF9E9EA6),
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

class _MetaInfoChip extends StatelessWidget {
  const _MetaInfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 28, color: const Color(0xFF9A9A9D)),
        const SizedBox(width: 12),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9A9A9D),
          ),
        ),
      ],
    );
  }
}

class _HoaxPosterPreview extends StatelessWidget {
  const _HoaxPosterPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
              const SizedBox(width: 10),
              _PosterLogo(label: 'JAWA TIMUR', accent: const Color(0xFF0E7B34)),
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
                gradient: const LinearGradient(
                  colors: [Color(0xFFD81B2C), Color(0xFF6E131D)],
                ),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'HOAX',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: Text(
              'KABAR DONALD TRUMP SEKARAT\nAKIBAT MELAWAN IRAN',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                height: 1.25,
                color: const Color(0xFF1A2261),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Sebuah unggahan menyebar dengan foto yang menampilkan Donald Trump terbaring di atas brankar, dikelilingi personel medis. Narasi yang menyertainya mengklaim Trump sedang sekarat dan mengalami stroke berat akibat kekalahan dalam perang melawan Iran.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.65,
              color: const Color(0xFF3A3E48),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Setelah ditelusuri, fotonya bukan foto nyata, ini hasil rekayasa AI. Ada sejumlah kejanggalan pada gambar seperti para personel medis tampak tidak natural dan mirip satu sama lain.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.65,
              color: const Color(0xFF3A3E48),
            ),
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
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '11 April 2026',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '085141169526',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.42),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFE11D2E),
                      width: 4,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF7D583A),
                                      Color(0xFF1E293B),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(color: const Color(0xFF24262D)),
                            ),
                          ],
                        ),
                      ),
                      const Positioned(
                        right: 14,
                        bottom: 14,
                        child: _MiniHoaxBadge(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
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
                const SizedBox(height: 10),
                Text(
                  'Tautan Rujukan : https://tirto.id/hoaks-kabar-donald-trump-sekarat-akibat-melawan-iran-htvw',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
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
          Icon(Icons.verified_rounded, size: 18, color: accent),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniHoaxBadge extends StatelessWidget {
  const _MiniHoaxBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFD81B2C),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'HOAX',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
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
