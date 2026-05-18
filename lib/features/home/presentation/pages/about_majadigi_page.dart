import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class AboutMajadigiPage extends StatelessWidget {
  const AboutMajadigiPage({super.key});

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeProfile);
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
              color: AppColors.splashBackground,
              padding: const EdgeInsets.fromLTRB(18, 22, 24, 28),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _handleBack(context),
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(44, 44),
                    ),
                    icon: const Icon(Icons.arrow_back_rounded, size: 34),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tentang Majadigi',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
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
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(22, 26, 22, 28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF111827).withValues(alpha: 0.05),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDDEBFF),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'SEKILAS MAJADIGI',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.4,
                            color: AppColors.welcomeAccent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 26),
                      Text(
                        'Inovasi Layanan Publik\nBerbasis Digital Jawa\nTimur',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          height: 1.24,
                          letterSpacing: -0.7,
                          color: AppColors.brandNavy,
                        ),
                      ),
                      const SizedBox(height: 34),
                      Text(
                        'Majadigi merupakan platform layanan publik digital terpadu (berbasis web dan mobile) yang diluncurkan pada Oktober 2024 oleh Pemerintah Provinsi Jawa Timur.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          height: 1.8,
                          color: const Color(0xFF636A96),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Platform ini dirancang untuk menyederhanakan akses masyarakat terhadap berbagai kebutuhan administratif dan informasi dalam satu pintu.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          height: 1.8,
                          color: const Color(0xFF636A96),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
