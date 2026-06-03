import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../home/presentation/controllers/home_service_installation.dart';

class BapendaJatimPage extends StatelessWidget {
  const BapendaJatimPage({super.key});

  static const _benefits = [
    _BenefitItem(
      icon: Icons.receipt_long_rounded,
      title: 'Informasi Pajak Kendaraan Bermotor (PKB)',
      description:
          'Cek status pajak dan estimasi biaya secara real-time. Tidak perlu lagi menebak jumlah yang harus dibayar.',
    ),
    _BenefitItem(
      icon: Icons.directions_car_filled_rounded,
      title: 'Info Nilai Jual Kendaraan Bermotor (NJKB)',
      description:
          'Temukan nilai pasar resmi kendaraan terbaru untuk keperluan administrasi dan transparansi transaksi.',
    ),
  ];

  static const _steps = [
    _ProcedureStep(
      number: '1',
      title: 'Masukan No. Polisi',
      description:
          'Identifikasi kendaraan Anda melalui sistem database terintegrasi Samsat Jatim.',
      isActive: true,
    ),
    _ProcedureStep(
      number: '2',
      title: 'Verifikasi Data',
      description:
          'Cek kesesuaian data kendaraan, masa berlaku STNK, dan detail pajak terhutang.',
    ),
    _ProcedureStep(
      number: '3',
      title: 'Pembayaran',
      description:
          'Gunakan berbagai kanal pembayaran elektronik untuk pelunasan pajak tanpa antri.',
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
    installHomeService(context, 'bapenda-jatim');
    context.pushNamed(RouteNames.homeBapendaJatimMain);
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
                      'BAPENDA JATIM',
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
                      'Memudahkan warga Jawa Timur mengurus kewajiban pajak dengan transparansi penuh.',
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
          Icon(item.icon, size: 30, color: AppColors.welcomeAccent),
          const SizedBox(height: 22),
          Text(
            item.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              height: 1.45,
              color: const Color(0xFF2E3138),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            item.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.8,
              color: AppColors.textMuted,
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
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF262B33),
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
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          for (var index = 0; index < steps.length; index++)
            _ProcedureStepRow(
              step: steps[index],
              showConnector: index != steps.length - 1,
            ),
        ],
      ),
    );
  }
}

class _ProcedureStepRow extends StatelessWidget {
  const _ProcedureStepRow({required this.step, required this.showConnector});

  final _ProcedureStep step;
  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 58,
            child: Column(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: step.isActive
                        ? AppColors.welcomeAccent
                        : const Color(0xFFDCE9FF),
                    boxShadow: step.isActive
                        ? [
                            BoxShadow(
                              color: AppColors.welcomeAccent.withValues(
                                alpha: 0.28,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    step.number,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: step.isActive
                          ? Colors.white
                          : AppColors.welcomeAccent,
                    ),
                  ),
                ),
                if (showConnector)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      color: const Color(0xFFDCE6F8),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      height: 1.35,
                      color: const Color(0xFF243058),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    step.description,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.7,
                      color: const Color(0xFF59647C),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
