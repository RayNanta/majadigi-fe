import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class BapendaJatimNjkbResultPage extends StatelessWidget {
  const BapendaJatimNjkbResultPage({
    super.key,
    this.vehicleType,
    this.brand,
    this.year,
    this.model,
    this.trim,
  });

  final String? vehicleType;
  final String? brand;
  final String? year;
  final String? model;
  final String? trim;

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeBapendaJatimNjkb);
  }

  String get _displayVehicleType =>
      _normalizedOrDefault(vehicleType, 'SEPEDA MOTOR');

  String get _displayBrand => _normalizedOrDefault(brand, 'HONDA');

  String get _displayYear => _normalizedOrDefault(year, '1980');

  String get _displayTypeValue {
    final normalizedModel = (model ?? '').trim().toLowerCase();

    switch (normalizedModel) {
      case 'beat':
        return '110CC';
      case 'vario':
        return '125CC';
      case 'avanza':
        return '1300CC';
      case 'nmax':
        return '155CC';
      default:
        final fallbackTrim = (trim ?? '').trim();
        if (fallbackTrim.isNotEmpty) {
          return fallbackTrim.toUpperCase();
        }

        return '110CC';
    }
  }

  static String _normalizedOrDefault(String? value, String fallback) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) {
      return fallback;
    }

    return normalized.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final vehicleIdentity = [
      _InfoRow(label: 'Model', value: _displayVehicleType),
      _InfoRow(label: 'Merk', value: _displayBrand),
      _InfoRow(label: 'Tipe', value: _displayTypeValue),
      _InfoRow(label: 'Tahun Dibuat', value: _displayYear),
      const _InfoRow(label: 'PKB Plat Hitam', value: '16.500'),
      const _InfoRow(label: 'Opsen PKB Plat Hitam', value: '11.000'),
      const _InfoRow(label: 'PKB Plat Merah', value: '5.500'),
      const _InfoRow(label: 'Opsen PKB Plat Merah', value: '4.000'),
      const _InfoRow(label: 'PKB Plat Kuning', value: '9.000'),
      const _InfoRow(label: 'Opsen PKB Plat Kuning', value: '6.000'),
      const _InfoRow(label: 'BBN 1', value: '136.000'),
      const _InfoRow(label: 'BBN 2', value: '0'),
    ];

    const nonTaxRevenue = [
      _InfoRow(label: 'PNBP BPKB', value: '225.000'),
      _InfoRow(label: 'PNBP STNK', value: '100.000'),
      _InfoRow(label: 'PNBP TNKB', value: '60.000'),
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
                      'Informasi NJKB',
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
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionCard(
                      title: 'Identitas Kendaraan',
                      child: Column(
                        children: [
                          for (final item in vehicleIdentity)
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: item == vehicleIdentity.last ? 0 : 28,
                              ),
                              child: _InfoRowWidget(item: item),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _SectionCard(
                      title: 'Penerimaan Negara Bukan Pajak',
                      child: Column(
                        children: [
                          for (final item in nonTaxRevenue)
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: item == nonTaxRevenue.last ? 0 : 28,
                              ),
                              child: _InfoRowWidget(item: item),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
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

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 30, 28, 28),
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
          const SizedBox(height: 34),
          child,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            item.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: context.appThemedMutedTextColor(const Color(0xFF9A9A9A)),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Flexible(
          child: Text(
            item.value,
            textAlign: TextAlign.right,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: context.appThemedTextColor(const Color(0xFF2A2E35)),
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;
}
