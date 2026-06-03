import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../home/presentation/controllers/home_service_installation.dart';

class SiskaperbapoPage extends StatelessWidget {
  const SiskaperbapoPage({super.key});

  static const _benefits = [
    _BenefitItem(
      number: '01',
      title: 'Akses Informasi Harian',
      description:
          'Informasi harga bahan pokok secara harian dan transparan untuk seluruh wilayah.',
    ),
    _BenefitItem(
      number: '02',
      title: 'Pemantauan Mudah',
      description:
          'Cek ketersediaan bahan pokok dengan mudah kapan saja melalui perangkat Anda.',
    ),
    _BenefitItem(
      number: '03',
      title: 'Stabilitas Harga',
      description:
          'Mendukung pengendalian inflasi dan menjaga stabilitas harga bahan pokok nasional.',
    ),
  ];

  static const _steps = [
    _ProcedureStep(
      icon: Icons.search_rounded,
      title: 'Pencarian Data',
      description:
          'Pilih kategori bahan pokok atau lokasi pasar yang ingin dipantau.',
    ),
    _ProcedureStep(
      icon: Icons.insert_chart_outlined_rounded,
      title: 'Analisis Harga',
      description:
          'Sistem menampilkan grafik tren harga dan perbandingan antar wilayah.',
    ),
    _ProcedureStep(
      icon: Icons.notifications_none_rounded,
      title: 'Notifikasi Update',
      description:
          'Dapatkan pembaruan langsung jika terjadi fluktuasi harga yang signifikan.',
    ),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }

    context.goNamed(RouteNames.home);
  }

  void _handleDownload(BuildContext context) {
    installHomeService(context, 'siskaper-bapo');
    context.pushNamed(RouteNames.homeSiskaperbapoMain);
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
                      'SISKAPERBAPO',
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
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _HeroBadge(),
                    const SizedBox(height: 24),
                    Text(
                      'Sistem Informasi Ketersediaan dan Perkembangan Harga Bahan Pokok',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 1.8,
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
                    _ProcedureCard(steps: _steps),
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

class _HeroBadge extends StatelessWidget {
  const _HeroBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
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
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const LinearGradient(
                colors: [Color(0xFFF8FBFF), Color(0xFFF2F7FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 28,
                  child: Icon(
                    Icons.shield_rounded,
                    size: 224,
                    color: AppColors.welcomeAccent.withValues(alpha: 0.08),
                  ),
                ),
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF45C2FF), Color(0xFF1785FF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1785FF).withValues(alpha: 0.24),
                        blurRadius: 28,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 24,
                        child: Icon(
                          Icons.star_rounded,
                          size: 42,
                          color: const Color(0xFFFFD54F),
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 128,
                        height: 168,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: const Color(0xFF3A3A3A),
                            width: 6,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 12,
                              height: 70,
                              decoration: BoxDecoration(
                                color: const Color(0xFFECEFF5),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 70,
                              height: 14,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1EC96B),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 78,
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD84C),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 28,
                        bottom: 34,
                        child: Transform.rotate(
                          angle: -0.4,
                          child: Container(
                            width: 14,
                            height: 86,
                            decoration: BoxDecoration(
                              color: const Color(0xFF22C55E),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 30,
                        bottom: 34,
                        child: Transform.rotate(
                          angle: 0.28,
                          child: Container(
                            width: 14,
                            height: 92,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFACC15),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
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

class _BenefitItem {
  const _BenefitItem({
    required this.number,
    required this.title,
    required this.description,
  });

  final String number;
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
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFDDEBFF),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              item.number,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.welcomeAccent,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF2B2F38),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
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

class _ProcedureStep {
  const _ProcedureStep({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class _ProcedureCard extends StatelessWidget {
  const _ProcedureCard({required this.steps});

  final List<_ProcedureStep> steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
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
      child: Column(
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          final isLast = index == steps.length - 1;

          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: _ProcedureStepRow(step: step, isLast: isLast),
          );
        }),
      ),
    );
  }
}

class _ProcedureStepRow extends StatelessWidget {
  const _ProcedureStepRow({required this.step, required this.isLast});

  final _ProcedureStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 62,
          child: Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFDDEBFF),
                ),
                child: Icon(
                  step.icon,
                  color: AppColors.welcomeAccent,
                  size: 28,
                ),
              ),
              if (!isLast)
                Container(width: 2, height: 88, color: const Color(0xFFD7DCE6)),
            ],
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF2B2F38),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  step.description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
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
    );
  }
}
