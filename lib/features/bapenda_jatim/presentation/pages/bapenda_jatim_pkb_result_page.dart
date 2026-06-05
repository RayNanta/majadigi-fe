import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class BapendaJatimPkbResultPage extends StatelessWidget {
  const BapendaJatimPkbResultPage({super.key, this.plateNumber});

  final String? plateNumber;

  static const _vehicleIdentity = [
    _InfoRow(label: 'Nopol', value: 'N 3315 TAK'),
    _InfoRow(label: 'Warna', value: 'HITAM'),
    _InfoRow(label: 'Model', value: 'SEPEDA MOTOR'),
    _InfoRow(label: 'Tipe', value: 'X1B02N04L0'),
    _InfoRow(label: 'Tahun Dibuat', value: '2015'),
    _InfoRow(label: 'Masa Pajak', value: '29-06-2026', highlight: true),
  ];

  static const _annualFees = [
    _InfoRow(label: 'PKB', value: '101.500'),
    _InfoRow(label: 'PKB Progresif', value: '0'),
    _InfoRow(label: 'Opsen PKB', value: '67.000'),
    _InfoRow(label: 'Opsen PKB Progresif', value: '0'),
    _InfoRow(label: 'SWDKLLJ', value: '35.000'),
    _InfoRow(label: 'Parkir Berlangganan', value: '20.000'),
    _InfoRow(label: 'Pengesahan STNK', value: '0'),
    _InfoRow(label: 'Total/Jumlah', value: '223.500', isTotal: true),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeBapendaJatimPkb);
  }

  @override
  Widget build(BuildContext context) {
    final displayedPlate = plateNumber?.trim().isNotEmpty == true
        ? plateNumber!.trim().toUpperCase()
        : 'N 3315 TAK';

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
                      'Informasi PKB',
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
                    _PlateStatusCard(plateNumber: displayedPlate),
                    const SizedBox(height: 24),
                    _SectionCard(
                      title: 'Identitas Kendaraan',
                      child: Column(
                        children: [
                          for (final item in _vehicleIdentity)
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: item == _vehicleIdentity.last ? 0 : 22,
                              ),
                              child: _InfoRowWidget(item: item),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _SectionCard(
                      title: 'Biaya Penul Tahunan',
                      child: Column(
                        children: [
                          for (final item in _annualFees)
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: item == _annualFees.last ? 0 : 18,
                              ),
                              child: _InfoRowWidget(item: item),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _SectionCard(
                      title: 'Biaya Penul 5 Tahunan',
                      child: Row(
                        children: const [
                          Expanded(
                            child: _FiveYearFeeCard(
                              title: 'Cetak STNK',
                              value: '100.000',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _FiveYearFeeCard(
                              title: 'Cetak TNKB',
                              value: '60.000',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(26, 24, 24, 24),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? const Color(0xFF321B27)
                            : const Color(0xFFFFF4F5),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: context.isDarkMode
                              ? const Color(0xFF632739)
                              : const Color(0xFFFFE3E6),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 4,
                            height: 168,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF2D55),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.info_outline_rounded,
                                    color: const Color(0xFFFF2D55),
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    'Apabila masa berlaku STNK anda telah habis (Mati), harap segera melakukan pendaftaran ulang di kantor Samsat terdekat untuk menghindari denda administratif dan kendala operasional kendaraan.',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 1.85,
                                      color: const Color(0xFFFF2D55),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
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

class _PlateStatusCard extends StatelessWidget {
  const _PlateStatusCard({required this.plateNumber});

  final String plateNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 22, 28, 22),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFDDF8E8),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'AKTIF',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF2AA952),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            plateNumber,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: context.appThemedTextColor(const Color(0xFF2A2E35)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: context.appThemedTextColor(const Color(0xFF2A2E35)),
            ),
          ),
          const SizedBox(height: 28),
          child,
        ],
      ),
    );
  }
}

class _FiveYearFeeCard extends StatelessWidget {
  const _FiveYearFeeCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: context.appElevatedSurfaceColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: context.isDarkMode
              ? context.appBorderColor
              : const Color(0xFFD7D7D7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: context.appThemedMutedTextColor(const Color(0xFF8A8A8A)),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: context.appThemedTextColor(const Color(0xFF2A2E35)),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRowWidget extends StatelessWidget {
  const _InfoRowWidget({required this.item});

  final _InfoRow item;

  @override
  Widget build(BuildContext context) {
    final valueColor = item.highlight
        ? AppColors.welcomeAccent
        : context.appThemedTextColor(const Color(0xFF2A2E35));

    final valueWeight = item.isTotal ? FontWeight.w800 : FontWeight.w700;
    final labelWeight = item.isTotal ? FontWeight.w600 : FontWeight.w500;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            item.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: labelWeight,
              color: context.appThemedMutedTextColor(const Color(0xFF9A9A9A)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            item.value,
            textAlign: TextAlign.right,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: valueWeight,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow {
  const _InfoRow({
    required this.label,
    required this.value,
    this.highlight = false,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool highlight;
  final bool isTotal;
}
