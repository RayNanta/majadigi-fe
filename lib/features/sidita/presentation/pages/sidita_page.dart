import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../../home/presentation/controllers/home_service_installation.dart';

class SiditaPage extends StatelessWidget {
  const SiditaPage({super.key});

  static const _benefits = [
    _BenefitItem(
      icon: Icons.verified_outlined,
      title: 'Data dan informasi valid',
      description:
          'Seluruh data diverifikasi secara resmi oleh dinas terkait untuk keamanan perjalanan Anda.',
    ),
    _BenefitItem(
      icon: Icons.near_me_outlined,
      title: 'Fitur maps dan direction',
      description:
          'Navigasi presisi langsung ke pintu masuk destinasi tujuan tanpa tersesat.',
    ),
    _BenefitItem(
      icon: Icons.autorenew_rounded,
      title: 'Data diperbarui secara real time',
      description:
          'Update kondisi terkini, jam operasional, dan ketersediaan fasilitas secara instan.',
    ),
  ];

  static const _steps = [
    _ProcedureStep(
      number: '1',
      title: 'Registrasi Akun',
      description:
          'Daftar menggunakan email atau nomor telepon aktif untuk personalisasi layanan.',
      isActive: true,
    ),
    _ProcedureStep(
      number: '2',
      title: 'Pilih Destinasi',
      description:
          'Telusuri katalog daya tarik wisata berdasarkan kategori atau lokasi geografis.',
    ),
    _ProcedureStep(
      number: '3',
      title: 'Akses Layanan',
      description:
          'Dapatkan panduan lengkap, rute, dan informasi fasilitas secara komprehensif.',
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
    installHomeService(context, 'destinasi-wisata');
    context.pushNamed(RouteNames.homeSiditaMain);
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
                      'SIDITA',
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
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _HeroCard(),
                    const SizedBox(height: 24),
                    Text(
                      'SIDITA menyediakan akses mudah dan transparan ke seluruh potensi daya tarik wisata daerah dengan akurasi data yang terjamin.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 1.8,
                        color: context.appMutedTextColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const _SectionHeading(title: 'Manfaat'),
                    const SizedBox(height: 16),
                    ..._benefits.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _BenefitCard(item: item),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const _SectionHeading(
                      title: 'Sistem, Mekanisme, dan Prosedur',
                    ),
                    const SizedBox(height: 16),
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

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
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
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            'assets/images/dummy_image.png',
            fit: BoxFit.cover,
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
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: context.appThemedTextColor(const Color(0xFF20232B)),
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
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(item.icon, size: 28, color: AppColors.welcomeAccent),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: context.appThemedTextColor(const Color(0xFF2E3139)),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.appMutedTextColor,
                    height: 1.65,
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
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 10),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          final isLast = index == steps.length - 1;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 44,
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: step.isActive
                            ? AppColors.welcomeAccent
                            : const Color(0xFFEAF2FF),
                        shape: BoxShape.circle,
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
                      Container(
                        width: 2,
                        height: 102,
                        color: const Color(0xFFE3E8F3),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF41444C),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        step.description,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: context.appMutedTextColor,
                          height: 1.6,
                        ),
                      ),
                      SizedBox(height: isLast ? 14 : 22),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
