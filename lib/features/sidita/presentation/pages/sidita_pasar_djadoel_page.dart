import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class SiditaPasarDjadoelPage extends StatelessWidget {
  const SiditaPasarDjadoelPage({super.key});

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
                      'Pasar Djadoel Ahad Legi',
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
                          height: 660,
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
                                      Colors.white.withValues(alpha: 0.95),
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
                          bottom: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.welcomeAccent,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(
                                  'HERITAGE',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.6,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 22),
                              Text(
                                'Pasar Djadoel\nAhad Legi',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                  height: 1.15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 24,
                          right: 24,
                          bottom: 22,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF111827,
                                  ).withValues(alpha: 0.08),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 82,
                                      height: 82,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFE7F0FF),
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
                                              color: const Color(0xFF2A2E35),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Jawa Timur, Indonesia',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.textMuted,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                Text(
                                  'JADWAL',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.8,
                                    color: const Color(0xFF8D93A1),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '01 Jan - 31 Dec 2024',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF2A2E35),
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
                      padding: const EdgeInsets.fromLTRB(24, 30, 24, 34),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tentang Pasar Djadoel',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF20232B),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Pasar Djadoel Ahad Legi bukan sekadar pasar, tapi seperti museum hidup budaya Jawa yang ada di Ngawi. Diadakan setiap Ahad Legi, pasar ini menghadirkan suasana pasar zaman dulu dengan berbagai tradisi dan kerajinan khas.\n\nPengunjung bisa merasakan kembali suasana masa lalu dengan menggunakan koin kayu untuk berbelanja makanan tradisional, kain buatan tangan, dan kerajinan lokal. Suasananya semakin terasa dengan aroma makanan bakar dan alunan musik gamelan, membuat pengalaman yang unik dan berkesan.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.85,
                              color: AppColors.textMuted,
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
