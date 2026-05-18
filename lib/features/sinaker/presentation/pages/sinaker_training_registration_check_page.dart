import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class SinakerTrainingRegistrationCheckPage extends StatelessWidget {
  const SinakerTrainingRegistrationCheckPage({super.key});

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeSinakerMain);
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
                      'Cek Pendaftaran',
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
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF111827,
                            ).withValues(alpha: 0.04),
                            blurRadius: 22,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 116,
                                height: 116,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEAF2FF),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.person_outline_rounded,
                                  size: 54,
                                  color: AppColors.welcomeAccent,
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bambang Pamungkas',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF3B3F47),
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'NIK: 3578021908920001',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF606596),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 26),
                          const Divider(color: Color(0xFFE9EEFB), height: 1),
                          const SizedBox(height: 28),
                          Row(
                            children: [
                              Expanded(
                                child: _InfoColumn(
                                  label: 'GELOMBANG',
                                  value: 'Batch 24 - 2024',
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: _InfoColumn(
                                  label: 'LOKASI',
                                  value: 'UPT BLK\nSurabaya',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(28, 30, 28, 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF111827,
                            ).withValues(alpha: 0.04),
                            blurRadius: 22,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          _StatusStep(
                            title: 'Pendaftaran Diterima',
                            description:
                                'Formulir pendaftaran telah masuk ke sistem pada 12 Oktober 2023.',
                            footer: '12 Okt, 09:42 WIB',
                            icon: Icons.check_rounded,
                            state: _StatusStepState.completed,
                            isLast: false,
                          ),
                          SizedBox(height: 34),
                          _StatusStep(
                            title: 'Verifikasi Berkas',
                            description:
                                'Tim admin sedang meninjau dokumen pendukung Anda.',
                            footer: 'Sedang Berjalan',
                            icon: Icons.sync_rounded,
                            state: _StatusStepState.active,
                            isLast: false,
                          ),
                          SizedBox(height: 34),
                          _StatusStep(
                            title: 'Pengumuman Seleksi',
                            description:
                                'Hasil akhir seleksi akan diumumkan pada tanggal 25 Oktober 2023.',
                            icon: Icons.campaign_outlined,
                            state: _StatusStepState.upcoming,
                            isLast: true,
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

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF606596),
            letterSpacing: 2.2,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: AppColors.welcomeAccent,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

enum _StatusStepState { completed, active, upcoming }

class _StatusStep extends StatelessWidget {
  const _StatusStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.state,
    required this.isLast,
    this.footer,
  });

  final String title;
  final String description;
  final String? footer;
  final IconData icon;
  final _StatusStepState state;
  final bool isLast;

  Color get _lineColor => switch (state) {
    _StatusStepState.completed => AppColors.welcomeAccent,
    _StatusStepState.active => const Color(0xFFD6E7FF),
    _StatusStepState.upcoming => const Color(0xFFE8EEFF),
  };

  Color get _circleColor => switch (state) {
    _StatusStepState.completed => AppColors.welcomeAccent,
    _StatusStepState.active => const Color(0xFFEAF2FF),
    _StatusStepState.upcoming => const Color(0xFFF2F6FF),
  };

  Color get _iconColor => switch (state) {
    _StatusStepState.completed => Colors.white,
    _StatusStepState.active => AppColors.welcomeAccent,
    _StatusStepState.upcoming => const Color(0xFF8DBAFF),
  };

  Color get _titleColor => switch (state) {
    _StatusStepState.upcoming => const Color(0xFFC7CBD5),
    _ => const Color(0xFF333842),
  };

  Color get _bodyColor => switch (state) {
    _StatusStepState.upcoming => const Color(0xFFB4B8C2),
    _ => const Color(0xFF606596),
  };

  Color get _footerColor => switch (state) {
    _StatusStepState.completed => AppColors.welcomeAccent,
    _StatusStepState.active => AppColors.welcomeAccent,
    _StatusStepState.upcoming => const Color(0xFFB4B8C2),
  };

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 86,
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: _circleColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: state == _StatusStepState.active
                          ? Colors.white
                          : state == _StatusStepState.completed
                          ? AppColors.welcomeAccent
                          : const Color(0xFFF5F8FF),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(icon, size: 28, color: _iconColor),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: _lineColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: _bodyColor,
                      height: 1.7,
                    ),
                  ),
                  if (footer != null) ...[
                    const SizedBox(height: 18),
                    Text(
                      footer!,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _footerColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
