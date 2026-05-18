import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class HoaxClinicPage extends StatelessWidget {
  const HoaxClinicPage({super.key});

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.home);
  }

  void _handleDownload(BuildContext context) {
    context.pushNamed(RouteNames.homeHoaxClinicMain);
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
                      'Klinik Hoaks',
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
                    const _HoaxHeroCard(),
                    const SizedBox(height: 28),
                    Text(
                      'Layanan verifikasi informasi untuk memerangi hoaks, '
                      'disinformasi, dan ujaran kebencian di masyarakat.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 1.85,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const _SectionHeading(title: 'Fitur Utama'),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        Expanded(
                          child: _FeatureCard(
                            icon: Icons.speed_rounded,
                            title: 'Fast verification',
                            subtitle: 'Cepat & Responsif',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _FeatureCard(
                            icon: Icons.bar_chart_rounded,
                            title: 'Accurate data',
                            subtitle: 'Data Terpercaya',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const _WideFeatureCard(
                      icon: Icons.psychology_rounded,
                      title: 'Expert-reviewed',
                      subtitle:
                          'Ditinjau langsung oleh tenaga ahli profesional',
                    ),
                    const SizedBox(height: 28),
                    const _SectionHeading(title: 'Cara Kerja'),
                    const SizedBox(height: 16),
                    const _TimelineCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 18),
          child: SizedBox(
            height: 66,
            child: FilledButton(
              onPressed: () => _handleDownload(context),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.welcomeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('Unduh Layanan'),
            ),
          ),
        ),
      ),
    );
  }
}

class _HoaxHeroCard extends StatelessWidget {
  const _HoaxHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 1.03,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 8,
              child: Icon(
                Icons.shield_rounded,
                size: 210,
                color: const Color(0xFF1EA6E8).withValues(alpha: 0.18),
              ),
            ),
            Positioned(
              top: 58,
              child: Container(
                width: 178,
                height: 178,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F7AFF), Color(0xFF1A6BFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1A6BFF).withValues(alpha: 0.24),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.fact_check_rounded,
                  color: Colors.white,
                  size: 78,
                ),
              ),
            ),
            Positioned(
              left: 24,
              bottom: 20,
              child: _FloatingBadge(
                icon: Icons.check_circle_rounded,
                label: 'Valid',
                color: const Color(0xFF16A34A),
                background: const Color(0xFFEFFBF2),
              ),
            ),
            Positioned(
              right: 24,
              bottom: 20,
              child: _FloatingBadge(
                icon: Icons.report_gmailerrorred_rounded,
                label: 'Hoaks',
                color: const Color(0xFFEF4444),
                background: const Color(0xFFFFEEF1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  const _FloatingBadge({
    required this.icon,
    required this.label,
    required this.color,
    required this.background,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF16181D),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F0FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.welcomeAccent, size: 24),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.welcomeAccent,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _WideFeatureCard extends StatelessWidget {
  const _WideFeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F0FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: AppColors.welcomeAccent, size: 28),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.welcomeAccent,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: AppColors.textMuted,
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

class _TimelineCard extends StatelessWidget {
  const _TimelineCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 72,
              child: Column(
                children: const [
                  _TimelineMarker(label: '1'),
                  Expanded(child: _TimelineLine(color: Color(0xFFD7D9DF))),
                  _TimelineMarker(label: '2'),
                  Expanded(child: _TimelineLine(color: Color(0xFFD7D9DF))),
                  _TimelineMarker(icon: Icons.check_rounded, filled: true),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TimelineStep(
                    title: 'Input Link/Teks',
                    description:
                        'Masukkan tautan berita atau unggah tangkapan layar yang ingin Anda verifikasi.',
                  ),
                  SizedBox(height: 42),
                  _TimelineStep(
                    title: 'Analisis Sistem & Ahli',
                    description:
                        'AI kami melakukan pemindaian awal diikuti validasi manual oleh tim pemeriksa fakta.',
                  ),
                  SizedBox(height: 42),
                  _TimelineStep(
                    title: 'Hasil Verifikasi',
                    description:
                        'Dapatkan laporan lengkap mengenai kredibilitas informasi tersebut dalam hitungan menit.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineMarker extends StatelessWidget {
  const _TimelineMarker({this.label, this.icon, this.filled = false});

  final String? label;
  final IconData? icon;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? AppColors.welcomeAccent : const Color(0xFFE7F0FF),
      ),
      alignment: Alignment.center,
      child: icon != null
          ? Icon(icon, color: Colors.white, size: 24)
          : Text(
              label!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: filled ? Colors.white : AppColors.welcomeAccent,
              ),
            ),
    );
  }
}

class _TimelineLine extends StatelessWidget {
  const _TimelineLine({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(width: 2, color: color));
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF21242C),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.7,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
