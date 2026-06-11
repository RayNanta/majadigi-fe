import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class BapendaJatimPkbResultPage extends StatelessWidget {
  const BapendaJatimPkbResultPage({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeBapendaJatimPkb);
  }

  @override
  Widget build(BuildContext context) {

    final identitas = data['identitas'] ?? {};
    final tahunan = data['rincian_tahunan'] ?? {};
    final limaTahunan = data['rincian_lima_tahunan'] ?? {};
    final biayaStnk =
        limaTahunan['biaya_cetak_stnk_baru'] ?? 0;

    final biayaTnkb =
        limaTahunan['biaya_cetak_tnkb_baru'] ?? 0;

    final statusAktif =
        identitas['status_keaktifan']?.toString() == 'Aktif';

    final keamananAlert =
        data['keamanan_alert']?.toString() ?? '';

    final vehicleIdentity = [
      _InfoRow(
        label: 'Nopol',
        value: identitas['nomor_polisi'] ?? '-',
      ),
      _InfoRow(
        label: 'Warna',
        value: identitas['warna'] ?? '-',
      ),
      _InfoRow(
        label: 'Model',
        value: identitas['model'] ?? '-',
      ),
      _InfoRow(
        label: 'Tipe',
        value: identitas['tipe'] ?? '-',
      ),
      _InfoRow(
        label: 'Tahun Dibuat',
        value: identitas['tahun_pembuatan']?.toString() ?? '-',
      ),
      _InfoRow(
        label: 'Masa Pajak',
        value: identitas['jatuh_tempo_pajak'] ?? '-',
        highlight: true,
      ),
    ];

    final annualFees = [
      _InfoRow(
        label: 'PKB',
        value: tahunan['pkb_dasar']?.toString() ?? '0',
      ),
      _InfoRow(
        label: 'PKB Progresif',
        value: tahunan['pkb_progresif']?.toString() ?? '0',
      ),
      _InfoRow(
        label: 'Opsen PKB',
        value: tahunan['opsen_pkb']?.toString() ?? '0',
      ),
      _InfoRow(
        label: 'SWDKLLJ',
        value: tahunan['swdkllj']?.toString() ?? '0',
      ),
      _InfoRow(
        label: 'Parkir Berlangganan',
        value: tahunan['parkir_berlangganan']?.toString() ?? '0',
      ),
      _InfoRow(
        label: 'Pengesahan STNK',
        value: tahunan['biaya_pengesahan_stnk']?.toString() ?? '0',
      ),
      _InfoRow(
        label: 'Denda',
        value: tahunan['total_denda']?.toString() ?? '0',
      ),
      _InfoRow(
        label: 'Total/Jumlah',
        value: tahunan['total_keseluruhan_tahunan']?.toString() ?? '0',
        isTotal: true,
      ),
    ];

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
                    _PlateStatusCard(
                      plateNumber: identitas['nomor_polisi'] ?? '-',
                      isActive: statusAktif,
                    ),                    const SizedBox(height: 24),
                    _SectionCard(
                      title: 'Identitas Kendaraan',
                      child: Column(
                        children: [
                          for (final item in vehicleIdentity)                            Padding(
                              padding: EdgeInsets.only(
                                bottom: item == vehicleIdentity.last ? 0 : 22,
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
                          for (final item in annualFees)                            Padding(
                              padding: EdgeInsets.only(
                                bottom: item == annualFees.last ? 0 : 18,
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
                        children: [
                          Expanded(
                            child: _FiveYearFeeCard(
                              title: 'Cetak STNK',
                              value: biayaStnk.toString(),
                            ),
                          ),
                          const SizedBox(width: 16),
                           Expanded(
                            child: _FiveYearFeeCard(
                              title: 'Cetak TNKB',
                              value: biayaTnkb.toString(),
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
                                    keamananAlert,
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
  const _PlateStatusCard({
    required this.plateNumber,
    required this.isActive,
  });

  final String plateNumber;
  final bool isActive;

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
              isActive ? 'AKTIF' : 'MATI',
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
