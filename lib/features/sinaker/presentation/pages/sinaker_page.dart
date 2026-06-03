import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../home/presentation/controllers/home_service_installation.dart';

class SinakerPage extends StatelessWidget {
  const SinakerPage({super.key});

  static const _benefitCards = [
    _BenefitCardItem(
      icon: Icons.verified_user_outlined,
      title: 'Legalitas Terjamin',
      description:
          'Seluruh program pelatihan terakreditasi dan diakui secara nasional oleh kementerian terkait.',
    ),
    _BenefitCardItem(
      icon: Icons.trending_up_rounded,
      title: 'Peningkatan Skill',
      description:
          'Kurikulum yang disesuaikan dengan kebutuhan industri masa kini.',
    ),
    _BenefitCardItem(
      icon: Icons.storage_rounded,
      title: 'Akses Data',
      description:
          'Kemudahan dalam memantau riwayat pelatihan dan sertifikasi digital.',
    ),
  ];

  static const _steps = [
    _ProcedureStep(
      number: '1',
      title: 'Pendaftaran Akun',
      description:
          'Lakukan registrasi melalui platform SINAKER dengan melengkapi data NIK dan Profil Lengkap.',
      isActive: true,
    ),
    _ProcedureStep(
      number: '2',
      title: 'Pemilihan Pelatihan',
      description:
          'Pilih jenis kejuruan atau pelatihan yang sesuai dengan minat dan kualifikasi dasar Anda.',
    ),
    _ProcedureStep(
      number: '3',
      title: 'Verifikasi & Seleksi',
      description:
          'Tim verifikator akan memeriksa dokumen. Ikuti tes seleksi jika dipersyaratkan oleh penyedia.',
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
    installHomeService(context, 'sinaker');
    context.pushNamed(RouteNames.homeSinakerMain);
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
                      'SINAKER',
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
                    const _HeroBadge(),
                    const SizedBox(height: 24),
                    Text(
                      'Sistem Informasi Ketenagakerjaan merupakan solusi digital terpadu untuk memfasilitasi kebutuhan pelatihan dan informasi kerja di wilayah Anda.',
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
                    _WideBenefitCard(item: _benefitCards[0]),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _BenefitCard(item: _benefitCards[1])),
                        const SizedBox(width: 18),
                        Expanded(child: _BenefitCard(item: _benefitCards[2])),
                      ],
                    ),
                    const SizedBox(height: 28),
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

class _HeroBadge extends StatelessWidget {
  const _HeroBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
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
        aspectRatio: 1,
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Transform.translate(
                      offset: const Offset(6, 6),
                      child: Text(
                        'Disnakertrans',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 54,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF041B56),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(4, 4),
                      child: Text(
                        'Disnakertrans',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 54,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFE11D48),
                        ),
                      ),
                    ),
                    Text(
                      'Disnakertrans',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 54,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF11D7FF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Transform(
                  transform: Matrix4.skewX(-0.22),
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE11D48),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Provinsi Jawa Timur',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.25,
                      ),
                    ),
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

class _WideBenefitCard extends StatelessWidget {
  const _WideBenefitCard({required this.item});

  final _BenefitCardItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, size: 34, color: AppColors.welcomeAccent),
          const SizedBox(height: 16),
          Text(
            item.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF2F3563),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.7,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  const _BenefitCard({required this.item});

  final _BenefitCardItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 22, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, size: 32, color: AppColors.welcomeAccent),
          const SizedBox(height: 18),
          Text(
            item.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF2F3563),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            item.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.55,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcedureCard extends StatelessWidget {
  const _ProcedureCard({required this.steps});

  final List<_ProcedureStep> steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
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
                width: 70,
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: step.isActive
                            ? AppColors.welcomeAccent
                            : const Color(0xFFDCEAFF),
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
                        width: 3,
                        height: 96,
                        color: const Color(0xFFD5E3FF),
                      ),
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
                          color: const Color(0xFF30343C),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        step.description,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.6,
                          color: AppColors.textMuted,
                        ),
                      ),
                      if (!isLast) const SizedBox(height: 18),
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

class _BenefitCardItem {
  const _BenefitCardItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
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
