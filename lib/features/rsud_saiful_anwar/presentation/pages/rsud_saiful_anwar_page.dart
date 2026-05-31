import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class RsudSaifulAnwarPage extends StatelessWidget {
  const RsudSaifulAnwarPage({super.key});

  static const _benefits = [
    _BenefitItem(
      icon: Icons.sync_rounded,
      title: 'Pembaruan Real-time',
      description:
          'Sinkronisasi langsung dengan database rumah sakit memastikan Anda melihat ketersediaan tempat tidur terbaru tanpa penundaan.',
    ),
    _BenefitItem(
      icon: Icons.timer_outlined,
      title: 'Hemat Waktu & Tenaga',
      description:
          'Tidak perlu lagi kunjungan fisik hanya untuk mengecek ketersediaan. Rencanakan perjalanan Anda dengan tenang.',
    ),
  ];

  static const _steps = [
    _ProcedureStep(
      number: '1',
      title: 'Pilih Layanan',
      description:
          'Temukan ikon layanan RSUD Saiful Anwar di dasbor utama Anda.',
      isActive: true,
    ),
    _ProcedureStep(
      number: '2',
      title: 'Telusuri Tipe Kamar',
      description:
          'Filter melalui berbagai kategori kamar untuk menemukan yang sesuai dengan kebutuhan Anda.',
    ),
    _ProcedureStep(
      number: '3',
      title: 'Lihat Hitungan Real-time',
      description:
          'Lihat tepatnya berapa banyak tempat tidur yang tersedia untuk setiap kategori secara real-time.',
    ),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.home);
  }

  void _handleDownload(BuildContext context) {
    context.pushNamed(RouteNames.homeRsudSaifulAnwarMain);
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
                      'RSUD SAIFUL ANWAR',
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
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(36),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF111827,
                            ).withValues(alpha: 0.04),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Image.asset(
                          'assets/images/dummy_image.png',
                          height: 320,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Nikmati transparansi dalam layanan kesehatan. Pantau okupansi tempat tidur di semua bangsal termasuk VIP, Kelas 1, 2, 3, serta unit ICU khusus langsung dari basis data pusat rumah sakit.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 1.85,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const _SectionHeading(title: 'Manfaat'),
                    const SizedBox(height: 14),
                    ..._benefits.map(
                      (benefit) => Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: _BenefitCard(item: benefit),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const _SectionHeading(
                      title: 'Sistem, Mekanisme, dan Prosedur',
                    ),
                    const SizedBox(height: 14),
                    const _ProcedureCard(steps: _steps),
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

class _BenefitItem {
  const _BenefitItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class _BenefitCard extends StatelessWidget {
  const _BenefitCard({required this.item});

  final _BenefitItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, size: 28, color: AppColors.welcomeAccent),
          const SizedBox(height: 24),
          Text(
            item.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2A2E35),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            item.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.65,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcedureStep {
  const _ProcedureStep({
    required this.number,
    required this.title,
    required this.description,
    this.isActive = false,
  });

  final String number;
  final String title;
  final String description;
  final bool isActive;
}

class _ProcedureCard extends StatelessWidget {
  const _ProcedureCard({required this.steps});

  final List<_ProcedureStep> steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          final isLast = index == steps.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: step.isActive
                            ? AppColors.welcomeAccent
                            : const Color(0xFFDCEBFF),
                        boxShadow: step.isActive
                            ? [
                                BoxShadow(
                                  color: AppColors.welcomeAccent.withValues(
                                    alpha: 0.26,
                                  ),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        step.number,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: step.isActive
                              ? Colors.white
                              : AppColors.welcomeAccent,
                        ),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          color: const Color(0xFFD6DFF2),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2A2E35),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          step.description,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.6,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
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
