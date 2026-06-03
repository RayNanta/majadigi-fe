import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../home/presentation/controllers/home_service_installation.dart';

class KhasJatimPage extends StatelessWidget {
  const KhasJatimPage({super.key});

  static const _benefits = [
    _BenefitItem(
      icon: Icons.fact_check_outlined,
      title: 'Pendataan\nTerpadu',
      description:
          'Terdata jumlah dan kondisi fisik naskah kuno di Jawa Timur secara sistematis.',
    ),
    _BenefitItem(
      icon: Icons.school_outlined,
      title: 'Nilai Akademik',
      description:
          'Meningkatkan nilai akademik, riset, dan edukasi budaya bagi sivitas akademika.',
    ),
    _BenefitItem(
      icon: Icons.public_outlined,
      title: 'Standar\nUNESCO',
      description:
          'Menyiapkan naskah untuk pendaftaran ke Memory of the World UNESCO.',
    ),
    _BenefitItem(
      icon: Icons.park_outlined,
      title: 'Pelestarian\nLokal',
      description:
          'Mendukung pelestarian pengetahuan lokal dan tradisi turun-temurun.',
    ),
  ];

  static const _steps = [
    _ProcedureStep(
      number: '1',
      title: 'Pilih Layanan',
      description:
          'Akses portal Khas Jatim dan tentukan kategori layanan repositori yang Anda butuhkan.',
      isActive: true,
    ),
    _ProcedureStep(
      number: '2',
      title: 'Telusuri Tipe Naskah',
      description:
          'Gunakan fitur filter cerdas untuk menemukan naskah berdasarkan wilayah, usia, atau subjek.',
    ),
    _ProcedureStep(
      number: '3',
      title: 'Lihat Koleksi Digital',
      description:
          'Akses naskah dalam format digital resolusi tinggi untuk kebutuhan riset atau edukasi.',
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
    installHomeService(context, 'khas-jatim');
    context.pushNamed(RouteNames.homeKhasJatimMain);
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
                      'KHAS JATIM',
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
                      'Akses koleksi naskah kuno dan repository Jawa Timur untuk melestarikan khazanah pemikiran leluhur di era digital.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 1.8,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const _SectionHeading(title: 'Manfaat'),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            mainAxisExtent: 272,
                          ),
                      itemCount: _benefits.length,
                      itemBuilder: (context, index) {
                        return _BenefitCard(item: _benefits[index]);
                      },
                    ),
                    const SizedBox(height: 24),
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
        color: const Color(0xFF20232B),
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
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
      decoration: BoxDecoration(
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, size: 30, color: AppColors.welcomeAccent),
          const SizedBox(height: 22),
          Text(
            item.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF2E3139),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            item.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textMuted,
              height: 1.65,
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
        color: Colors.white,
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
                          color: AppColors.textMuted,
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
