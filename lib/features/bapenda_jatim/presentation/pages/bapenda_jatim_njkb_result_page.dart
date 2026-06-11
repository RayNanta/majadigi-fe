import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class BapendaJatimNjkbResultPage extends StatelessWidget {
  const BapendaJatimNjkbResultPage({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;


  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeBapendaJatimNjkb);
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

    final spesifikasi = Map<String, dynamic>.from(data?['spesifikasi'] ?? {});
    final tarif = Map<String, dynamic>.from(data?['tarif_pajak_kepemilikan'] ?? {});
    final pnbp = Map<String, dynamic>.from(data?['pnbp_polri'] ?? {});

    final vehicleIdentity = [
      _InfoRow(
        label: 'Model',
        value: spesifikasi['model'].toString(),
      ),
      _InfoRow(
        label: 'Merk',
        value: spesifikasi['merk'].toString(),
      ),
      _InfoRow(
        label: 'Tipe',
        value: spesifikasi['tipe_spesifik'].toString(),
      ),
      _InfoRow(
        label: 'CC',
        value: spesifikasi['cc'].toString(),
      ),
      _InfoRow(
        label: 'Tahun Dibuat',
        value: spesifikasi['tahun_dibuat'].toString(),
      ),
      _InfoRow(
        label: 'Nilai Jual Dasar',
        value: 'Rp ${spesifikasi['nilai_jual_dasar']}',
      ),
      _InfoRow(
        label: 'PKB Plat Hitam',
        value: tarif['plat_hitam_pribadi'].toString(),
      ),
      _InfoRow(
        label: 'PKB Plat Hitam Progresif',
        value: tarif['plat_hitam_progresif'].toString(),
      ),
      _InfoRow(
        label: 'PKB Plat Merah',
        value: tarif['plat_merah_dinas'].toString(),
      ),
      _InfoRow(
        label: 'PKB Plat Kuning',
        value: tarif['plat_kuning_umum'].toString(),
      ),
      _InfoRow(
        label: 'BBN 1',
        value: tarif['bbn_1'].toString(),
      ),
      _InfoRow(
        label: 'BBN 2',
        value: tarif['bbn_2'].toString(),
      ),
    ];

    final nonTaxRevenue = [
      _InfoRow(
        label: 'PNBP BPKB',
        value: 'Rp ${pnbp['penerbitan_bpkb']}',
      ),
      _InfoRow(
        label: 'PNBP STNK',
        value: 'Rp ${pnbp['penerbitan_stnk']}',
      ),
      _InfoRow(
        label: 'PNBP TNKB',
        value: 'Rp ${pnbp['penerbitan_tnkb']}',
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
