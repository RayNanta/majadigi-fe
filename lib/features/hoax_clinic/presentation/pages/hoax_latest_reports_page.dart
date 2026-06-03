import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/lazy_load_states.dart';

final _hoaxLatestReportsProvider =
    FutureProvider.autoDispose<List<_LatestReportItem>>((ref) async {
      await Future<void>.delayed(Duration.zero);
      return _HoaxLatestReportsPageState._reports;
    });

class HoaxLatestReportsPage extends ConsumerStatefulWidget {
  const HoaxLatestReportsPage({super.key});

  @override
  ConsumerState<HoaxLatestReportsPage> createState() =>
      _HoaxLatestReportsPageState();
}

class _HoaxLatestReportsPageState extends ConsumerState<HoaxLatestReportsPage> {
  static const _featuredReport = _FeaturedHoaxReport(
    badge: 'HOAKS',
    meta: '10 Menit yang lalu • 12 Okt 2023',
    title:
        '[HOAKS] Pendaftaran Vaksinasi Gratis Menggunakan Data Rekening Bank',
    description:
        'Telah beredar pesan berantai di WhatsApp mengenai link pendaftaran vaksinasi yang...',
  );

  static const _reports = [
    _LatestReportItem(
      category: 'FAKTA',
      title: 'Klarifikasi: Video Fenomena Langit Merah Bukan Tanda...',
      metaRight: '2 Jam lalu',
      footer: 'Diverifikasi Tim Ahli',
      footerIcon: Icons.verified_rounded,
      accent: AppColors.welcomeAccent,
      imageStyle: _ReportImageStyle.phone,
    ),
    _LatestReportItem(
      category: 'EDUKASI',
      title: '5 Cara Mudah Mengenali Tautan Phishing di Media...',
      metaRight: '5 Jam lalu',
      footer: '1.2k Pembaca',
      footerIcon: Icons.visibility_outlined,
      accent: Color(0xFF9B4FB5),
      imageStyle: _ReportImageStyle.wave,
    ),
    _LatestReportItem(
      category: 'HOAKS',
      title: '[HOAKS] Kabar Donald Trump Sekarat Setelah...',
      metaRight: 'Kemarin',
      footer: 'Berita Palsu',
      footerIcon: Icons.warning_amber_rounded,
      accent: Color(0xFFC61B2E),
      imageStyle: _ReportImageStyle.silhouette,
      opensDetail: true,
    ),
    _LatestReportItem(
      category: 'FAKTA',
      title: 'NASA Konfirmasi Tidak Ada Asteroid Berbahaya di Bula...',
      metaRight: '11 Okt',
      footer: 'Sumber Resmi',
      footerIcon: Icons.workspace_premium_outlined,
      accent: AppColors.welcomeAccent,
      imageStyle: _ReportImageStyle.planet,
    ),
  ];

  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String get _query => _searchController.text.trim().toLowerCase();

  List<_LatestReportItem> _filteredReports(List<_LatestReportItem> reports) {
    if (_query.isEmpty) {
      return reports;
    }

    return reports.where((item) {
      return item.title.toLowerCase().contains(_query) ||
          item.category.toLowerCase().contains(_query) ||
          item.footer.toLowerCase().contains(_query);
    }).toList();
  }

  bool get _showFeatured {
    if (_query.isEmpty) {
      return true;
    }

    return _featuredReport.title.toLowerCase().contains(_query) ||
        _featuredReport.description.toLowerCase().contains(_query);
  }

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeHoaxClinicMain);
  }

  void _openDetail(BuildContext context) {
    context.pushNamed(RouteNames.homeHoaxClinicLatestReport);
  }

  void _showPlaceholder(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title akan kita lanjutkan berikutnya.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reportsAsync = ref.watch(_hoaxLatestReportsProvider);

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
                      'Laporan Terkini',
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
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2F3136),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Cari Laporan',
                        hintStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF7B7B81),
                        ),
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.search_rounded,
                            size: 36,
                            color: Color(0xFF6B6B72),
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 60,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF0F0F2),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: const BorderSide(
                            color: AppColors.welcomeAccent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    if (_showFeatured) ...[
                      _FeaturedReportCard(
                        report: _featuredReport,
                        onTap: () => _showPlaceholder(
                          context,
                          'Detail laporan vaksinasi',
                        ),
                      ),
                      const SizedBox(height: 22),
                    ],
                    ...reportsAsync.when<List<Widget>>(
                      loading: () => const [
                        LazyCardSkeleton(height: 148),
                        SizedBox(height: 22),
                        LazyCardSkeleton(height: 148),
                        SizedBox(height: 22),
                        LazyCardSkeleton(height: 148),
                      ],
                      error: (error, stackTrace) => [
                        LazyLoadErrorState(
                          message:
                              'Laporan terkini belum berhasil dimuat. Silakan coba lagi.',
                          onRetry: () =>
                              ref.invalidate(_hoaxLatestReportsProvider),
                        ),
                      ],
                      data: (reports) {
                        final filteredReports = _filteredReports(reports);

                        if (filteredReports.isEmpty) {
                          return [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 28,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF111827,
                                    ).withValues(alpha: 0.035),
                                    blurRadius: 14,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Text(
                                'Belum ada laporan yang cocok dengan pencarianmu.',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),
                          ];
                        }

                        return filteredReports
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 22),
                                child: _CompactReportCard(
                                  item: item,
                                  onTap: () {
                                    if (item.opensDetail) {
                                      _openDetail(context);
                                      return;
                                    }

                                    _showPlaceholder(context, 'Detail laporan');
                                  },
                                ),
                              ),
                            )
                            .toList();
                      },
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

class _FeaturedHoaxReport {
  const _FeaturedHoaxReport({
    required this.badge,
    required this.meta,
    required this.title,
    required this.description,
  });

  final String badge;
  final String meta;
  final String title;
  final String description;
}

class _LatestReportItem {
  const _LatestReportItem({
    required this.category,
    required this.title,
    required this.metaRight,
    required this.footer,
    required this.footerIcon,
    required this.accent,
    required this.imageStyle,
    this.opensDetail = false,
  });

  final String category;
  final String title;
  final String metaRight;
  final String footer;
  final IconData footerIcon;
  final Color accent;
  final _ReportImageStyle imageStyle;
  final bool opensDetail;
}

class _FeaturedReportCard extends StatelessWidget {
  const _FeaturedReportCard({required this.report, required this.onTap});

  final _FeaturedHoaxReport report;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          width: double.infinity,
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
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  const SizedBox(
                    height: 360,
                    width: double.infinity,
                    child: _FeaturedReportGraphic(),
                  ),
                  Positioned(
                    left: 24,
                    top: 24,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC61B2E),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        report.badge,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 22,
                          color: Color(0xFF6570A6),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            report.meta,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6570A6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      report.title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.35,
                        color: const Color(0xFF2B315E),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      report.description,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 1.45,
                        color: const Color(0xFF5E658A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompactReportCard extends StatelessWidget {
  const _CompactReportCard({required this.item, required this.onTap});

  final _LatestReportItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF111827).withValues(alpha: 0.035),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              _CompactReportArtwork(style: item.imageStyle),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.category,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: item.accent,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.metaRight,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6570A6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        height: 1.35,
                        color: const Color(0xFF2B315E),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(item.footerIcon, size: 22, color: item.accent),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.footer,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: item.accent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedReportGraphic extends StatelessWidget {
  const _FeaturedReportGraphic();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF061A24), Color(0xFF0A3A4B), Color(0xFF0A1F39)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _DashboardLinesPainter()),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: Container(
              height: 116,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactReportArtwork extends StatelessWidget {
  const _CompactReportArtwork({required this.style});

  final _ReportImageStyle style;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        width: 122,
        height: 122,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: switch (style) {
              _ReportImageStyle.phone => const LinearGradient(
                colors: [Color(0xFF081A25), Color(0xFF1B5457)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              _ReportImageStyle.wave => const LinearGradient(
                colors: [Color(0xFF1B102C), Color(0xFF082A45)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              _ReportImageStyle.silhouette => const RadialGradient(
                colors: [Color(0xFFF3F4F6), Color(0xFF0D1117)],
              ),
              _ReportImageStyle.planet => const RadialGradient(
                colors: [Color(0xFF0F3A69), Color(0xFF051728)],
              ),
            },
          ),
          child: CustomPaint(painter: _CompactArtworkPainter(style)),
        ),
      ),
    );
  }
}

enum _ReportImageStyle { phone, wave, silhouette, planet }

class _DashboardLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF5AD7E8).withValues(alpha: 0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;

    for (double i = 0; i < size.width; i += 22) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += 24) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    final glowPaint = Paint()
      ..shader =
          const RadialGradient(
            colors: [Color(0xAA4FE0FF), Color(0x004FE0FF)],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.55, size.height * 0.52),
              radius: size.width * 0.42,
            ),
          );
    canvas.drawRect(Offset.zero & size, glowPaint);

    final linePaint = Paint()
      ..color = const Color(0xFF4FE0FF).withValues(alpha: 0.55)
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke;

    final chartPath = Path()
      ..moveTo(size.width * 0.1, size.height * 0.72)
      ..quadraticBezierTo(
        size.width * 0.22,
        size.height * 0.48,
        size.width * 0.34,
        size.height * 0.6,
      )
      ..quadraticBezierTo(
        size.width * 0.48,
        size.height * 0.8,
        size.width * 0.62,
        size.height * 0.52,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.3,
        size.width * 0.9,
        size.height * 0.45,
      );
    canvas.drawPath(chartPath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CompactArtworkPainter extends CustomPainter {
  const _CompactArtworkPainter(this.style);

  final _ReportImageStyle style;

  @override
  void paint(Canvas canvas, Size size) {
    switch (style) {
      case _ReportImageStyle.phone:
        _paintPhone(canvas, size);
        return;
      case _ReportImageStyle.wave:
        _paintWave(canvas, size);
        return;
      case _ReportImageStyle.silhouette:
        _paintSilhouette(canvas, size);
        return;
      case _ReportImageStyle.planet:
        _paintPlanet(canvas, size);
        return;
    }
  }

  void _paintPhone(Canvas canvas, Size size) {
    final handPaint = Paint()..color = const Color(0xFFE6BEA3);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.34, size.height * 0.66),
        width: size.width * 0.34,
        height: size.height * 0.72,
      ),
      handPaint,
    );

    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 0.53, size.height * 0.5),
        width: size.width * 0.34,
        height: size.height * 0.58,
      ),
      const Radius.circular(14),
    );
    canvas.drawRRect(phoneRect, Paint()..color = const Color(0xFFF7FAFF));
    canvas.drawRRect(
      phoneRect.deflate(6),
      Paint()..color = const Color(0xFFE8F0FF),
    );

    final accent = Paint()..color = const Color(0xFFFF5757);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.36), 12, accent);
    final mark = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.32),
      Offset(size.width * 0.5, size.height * 0.39),
      mark,
    );
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.42),
      1.8,
      Paint()..color = Colors.white,
    );
  }

  void _paintWave(Canvas canvas, Size size) {
    final wavePaint = Paint()
      ..color = const Color(0xFF79B8FF).withValues(alpha: 0.7)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 7; i++) {
      final offsetY = size.height * 0.22 + (i * 12);
      final path = Path()
        ..moveTo(0, offsetY)
        ..quadraticBezierTo(
          size.width * 0.25,
          offsetY - 10,
          size.width * 0.5,
          offsetY,
        )
        ..quadraticBezierTo(
          size.width * 0.75,
          offsetY + 10,
          size.width,
          offsetY - 4,
        );
      canvas.drawPath(path, wavePaint);
    }
  }

  void _paintSilhouette(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xAA0A0D12),
    );
    final glow = Paint()
      ..shader =
          const RadialGradient(
            colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.5, size.height * 0.34),
              radius: size.width * 0.6,
            ),
          );
    canvas.drawRect(Offset.zero & size, glow);

    final bodyPaint = Paint()..color = const Color(0xFF111111);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.34),
      16,
      bodyPaint,
    );
    final bodyPath = Path()
      ..moveTo(size.width * 0.34, size.height * 0.92)
      ..quadraticBezierTo(
        size.width * 0.45,
        size.height * 0.44,
        size.width * 0.5,
        size.height * 0.46,
      )
      ..quadraticBezierTo(
        size.width * 0.55,
        size.height * 0.44,
        size.width * 0.66,
        size.height * 0.92,
      )
      ..close();
    canvas.drawPath(bodyPath, bodyPaint);
    canvas.drawLine(
      Offset(size.width * 0.58, size.height * 0.54),
      Offset(size.width * 0.8, size.height * 0.42),
      bodyPaint..strokeWidth = 6,
    );
  }

  void _paintPlanet(Canvas canvas, Size size) {
    final planetPaint = Paint()
      ..shader =
          const RadialGradient(
            colors: [Color(0xFF67D6FF), Color(0xFF0E5BAF), Color(0xFF12335E)],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.48, size.height * 0.5),
              radius: size.width * 0.32,
            ),
          );

    canvas.drawCircle(
      Offset(size.width * 0.48, size.height * 0.5),
      size.width * 0.31,
      planetPaint,
    );

    final orbitPaint = Paint()
      ..color = const Color(0xFF9EE7FF).withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.48, size.height * 0.5),
        width: size.width * 0.74,
        height: size.height * 0.34,
      ),
      orbitPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.48, size.height * 0.5),
        width: size.width * 0.48,
        height: size.height * 0.68,
      ),
      orbitPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
