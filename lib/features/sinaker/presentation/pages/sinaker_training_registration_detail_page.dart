import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../data/sinaker_training_registration_store.dart';

class SinakerTrainingRegistrationDetailPage extends StatelessWidget {
  const SinakerTrainingRegistrationDetailPage({super.key, this.registrationId});

  final String? registrationId;

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeSinakerTrainingRegistrationCheck);
  }

  @override
  Widget build(BuildContext context) {
    final registration =
        SinakerTrainingRegistrationStore.findById(registrationId) ??
        SinakerTrainingRegistrationStore.registrations.value.first;
    final steps = _buildSteps(registration);

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
                      'Detail Pendaftaran',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _RegistrationStatusBadge(status: registration.status),
                          const SizedBox(height: 18),
                          Text(
                            registration.trainingTitle,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF2D3162),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Divider(color: Color(0xFFE9EEFB), height: 1),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 92,
                                height: 92,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEAF2FF),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.person_outline_rounded,
                                  size: 44,
                                  color: AppColors.welcomeAccent,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        registration.applicantName,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF3B3F47),
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'NIK: ${registration.nik}',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 15,
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
                          Row(
                            children: [
                              Expanded(
                                child: _InfoColumn(
                                  label: 'GELOMBANG',
                                  value: registration.batch,
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: _InfoColumn(
                                  label: 'LOKASI',
                                  value: registration.location,
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
                      child: Column(
                        children: [
                          for (
                            var index = 0;
                            index < steps.length;
                            index++
                          ) ...[
                            _StatusStep(
                              title: steps[index].title,
                              description: steps[index].description,
                              footer: steps[index].footer,
                              icon: steps[index].icon,
                              state: steps[index].state,
                              isLast: index == steps.length - 1,
                            ),
                            if (index != steps.length - 1)
                              const SizedBox(height: 34),
                          ],
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

  List<_ProgressStepData> _buildSteps(
    SinakerTrainingRegistrationRecord registration,
  ) {
    final received = _ProgressStepData(
      title: 'Pendaftaran Diterima',
      description:
          'Formulir pendaftaran telah masuk ke sistem pada ${registration.submittedAt}.',
      footer: registration.submittedAt,
      icon: Icons.check_rounded,
      state: _StatusStepState.completed,
    );

    return switch (registration.status) {
      SinakerRegistrationStatus.waiting => [
        received,
        const _ProgressStepData(
          title: 'Verifikasi Berkas',
          description: 'Tim admin sedang meninjau dokumen pendukung Anda.',
          footer: 'Sedang Berjalan',
          icon: Icons.sync_rounded,
          state: _StatusStepState.active,
        ),
        const _ProgressStepData(
          title: 'Pengumuman Seleksi',
          description:
              'Hasil akhir seleksi akan diumumkan setelah proses verifikasi selesai.',
          icon: Icons.campaign_outlined,
          state: _StatusStepState.upcoming,
        ),
      ],
      SinakerRegistrationStatus.accepted => [
        received,
        const _ProgressStepData(
          title: 'Verifikasi Berkas',
          description:
              'Berkas dinyatakan lengkap dan memenuhi persyaratan administrasi.',
          footer: 'Selesai diverifikasi',
          icon: Icons.fact_check_outlined,
          state: _StatusStepState.completed,
        ),
        _ProgressStepData(
          title: 'Lulus Seleksi',
          description:
              'Anda dinyatakan diterima untuk mengikuti ${registration.trainingTitle}.',
          footer: registration.updatedAt,
          icon: Icons.verified_user_rounded,
          state: _StatusStepState.active,
        ),
      ],
      SinakerRegistrationStatus.rejected => [
        received,
        const _ProgressStepData(
          title: 'Verifikasi Berkas',
          description:
              'Berkas telah selesai diverifikasi oleh admin pelatihan.',
          footer: 'Selesai diverifikasi',
          icon: Icons.fact_check_outlined,
          state: _StatusStepState.completed,
        ),
        _ProgressStepData(
          title: 'Pendaftaran Ditolak',
          description:
              'Pendaftaran belum dapat dilanjutkan karena berkas belum memenuhi persyaratan seleksi.',
          footer: registration.updatedAt,
          icon: Icons.close_rounded,
          state: _StatusStepState.rejected,
        ),
      ],
    };
  }
}

class _RegistrationStatusBadge extends StatelessWidget {
  const _RegistrationStatusBadge({required this.status});

  final SinakerRegistrationStatus status;

  String get _label => switch (status) {
    SinakerRegistrationStatus.waiting => 'Menunggu',
    SinakerRegistrationStatus.rejected => 'Ditolak',
    SinakerRegistrationStatus.accepted => 'Diterima',
  };

  Color get _backgroundColor => switch (status) {
    SinakerRegistrationStatus.waiting => const Color(0xFFFFF3D8),
    SinakerRegistrationStatus.rejected => const Color(0xFFFFE4E6),
    SinakerRegistrationStatus.accepted => const Color(0xFFE2F7EC),
  };

  Color get _textColor => switch (status) {
    SinakerRegistrationStatus.waiting => const Color(0xFFD08400),
    SinakerRegistrationStatus.rejected => const Color(0xFFE33B52),
    SinakerRegistrationStatus.accepted => const Color(0xFF1F9A5F),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        _label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: _textColor,
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
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF606596),
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.welcomeAccent,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

enum _StatusStepState { completed, active, upcoming, rejected }

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
    _StatusStepState.rejected => const Color(0xFFFDA4AF),
    _StatusStepState.upcoming => const Color(0xFFE8EEFF),
  };

  Color get _circleColor => switch (state) {
    _StatusStepState.completed => AppColors.welcomeAccent,
    _StatusStepState.active => const Color(0xFFEAF2FF),
    _StatusStepState.rejected => const Color(0xFFFFE4E6),
    _StatusStepState.upcoming => const Color(0xFFF2F6FF),
  };

  Color get _innerCircleColor => switch (state) {
    _StatusStepState.completed => AppColors.welcomeAccent,
    _StatusStepState.active => Colors.white,
    _StatusStepState.rejected => Colors.white,
    _StatusStepState.upcoming => const Color(0xFFF5F8FF),
  };

  Color get _iconColor => switch (state) {
    _StatusStepState.completed => Colors.white,
    _StatusStepState.active => AppColors.welcomeAccent,
    _StatusStepState.rejected => const Color(0xFFE33B52),
    _StatusStepState.upcoming => const Color(0xFF8DBAFF),
  };

  Color get _titleColor => switch (state) {
    _StatusStepState.upcoming => const Color(0xFFC7CBD5),
    _StatusStepState.rejected => const Color(0xFFE33B52),
    _ => const Color(0xFF333842),
  };

  Color get _bodyColor => switch (state) {
    _StatusStepState.upcoming => const Color(0xFFB4B8C2),
    _ => const Color(0xFF606596),
  };

  Color get _footerColor => switch (state) {
    _StatusStepState.completed => AppColors.welcomeAccent,
    _StatusStepState.active => AppColors.welcomeAccent,
    _StatusStepState.rejected => const Color(0xFFE33B52),
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
                      color: _innerCircleColor,
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

class _ProgressStepData {
  const _ProgressStepData({
    required this.title,
    required this.description,
    required this.icon,
    required this.state,
    this.footer,
  });

  final String title;
  final String description;
  final String? footer;
  final IconData icon;
  final _StatusStepState state;
}
