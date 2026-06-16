import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../../../shared/widgets/lazy_load_states.dart';
import '../../services/hoax_models.dart';
import '../../services/hoax_provider.dart';
import '../../services/hoax_services.dart';

class HoaxLatestReportsPage extends ConsumerStatefulWidget {
  const HoaxLatestReportsPage({super.key});

  @override
  ConsumerState<HoaxLatestReportsPage> createState() =>
      _HoaxLatestReportsPageState();
}

class _HoaxLatestReportsPageState extends ConsumerState<HoaxLatestReportsPage> {
  late final TextEditingController _searchController;
  String _searchQuery = '';

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

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.homeHoaxClinicMain);
  }

  void _openDetail(BuildContext context, HoaxReportModel item) {
    context.pushNamed(RouteNames.homeHoaxClinicLatestReport, extra: item);
  }

  // 🟢 Fungsi pembantu untuk memetakan ikon footer secara dinamis dari BE status rill
  IconData _getFooterIcon(String status) {
    switch (status.toLowerCase()) {
      case 'valid':
      case 'fakta':
        return Icons.verified_rounded;
      case 'edukasi':
        return Icons.visibility_outlined;
      case 'hoax':
        return Icons.warning_amber_rounded;
      default:
        return Icons.workspace_premium_outlined;
    }
  }

  Color _getAccentColor(String status) {
    switch (status.toLowerCase()) {
      case 'valid':
      case 'fakta':
        return AppColors.welcomeAccent;
      case 'edukasi':
        return const Color(0xFF9B4FB5);
      case 'hoax':
        return const Color(0xFFC61B2E);
      default:
        return const Color(0xFF6E7395);
    }
  }

  // 🟢 Logika filter internal client-side dari teks controller pencarian rill
  List<HoaxReportModel> _filterReports(List<dynamic> reports) {
    final typedReports = reports.map((e) => HoaxReportModel.fromJson(e as Map<String, dynamic>)).toList();

    if (_searchQuery.isEmpty) return typedReports;

    return typedReports.where((item) {
      return item.deskripsiLaporan.toLowerCase().contains(_searchQuery) ||
          item.status.toLowerCase().contains(_searchQuery) ||
          item.nomorTiket.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // 🟢 Memantau data reaktif secara async dari provider Klinik Hoaks Laravel rill
    final reportsAsync = ref.watch(hoaxReportsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // APP BAR LAYOUT
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

            // MAIN BODY SCROLL
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(hoaxReportsProvider.future),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TEXTFIELD SEARCH BAR
                      TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.trim().toLowerCase();
                          });
                        },
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: context.appTextColor,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Cari Laporan',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: context.appMutedTextColor,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.search_rounded,
                              size: 36,
                              color: context.appMutedTextColor,
                            ),
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            minWidth: 60,
                          ),
                          filled: true,
                          fillColor: context.isDarkMode
                              ? context.appSearchSurfaceColor
                              : const Color(0xFFF0F0F2),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // HANDLING ASYNC STATE FROM LARAVEL DATA
                      reportsAsync.when(
                        loading: () => const Column(
                          children: [
                            LazyCardSkeleton(height: 148),
                            SizedBox(height: 22),
                            LazyCardSkeleton(height: 148),
                            SizedBox(height: 22),
                            LazyCardSkeleton(height: 148),
                          ],
                        ),
                        error: (error, stackTrace) => Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: LazyLoadErrorState(
                              message: 'Gagal memuat daftar berita terkini dari database rill.',
                              onRetry: () => ref.invalidate(hoaxReportsProvider),
                            ),
                          ),
                        ),
                        data: (allReports) {
                          final filteredList = _filterReports(allReports);

                          if (filteredList.isEmpty) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 28,
                              ),
                              decoration: BoxDecoration(
                                color: context.appSurfaceColor,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: context.appThemedCardShadows([
                                  BoxShadow(
                                    color: const Color(0xFF111827).withValues(alpha: 0.035),
                                    blurRadius: 14,
                                    offset: const Offset(0, 6),
                                  ),
                                ]),
                              ),
                              child: Text(
                                'Belum ada laporan klinik hoaks yang cocok rill.',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6,
                                  color: context.appMutedTextColor,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final report = filteredList[index];
                              final imageStyle = _ReportImageStyle.values[index % _ReportImageStyle.values.length];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 22),
                                child: _CompactReportCard(
                                  item: report,
                                  accent: _getAccentColor(report.status),
                                  footerIcon: _getFooterIcon(report.status),
                                  imageStyle: imageStyle,
                                  onTap: () => _openDetail(context, report),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactReportCard extends StatelessWidget {
  const _CompactReportCard({
    required this.item,
    required this.accent,
    required this.footerIcon,
    required this.imageStyle,
    required this.onTap,
  });
  final HoaxReportModel item;
  final Color accent;
  final IconData footerIcon;
  final _ReportImageStyle imageStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final String formattedDate = item.createdAt.length > 10
        ? item.createdAt.substring(0, 10)
        : 'Baru Saja';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.appSurfaceColor,
            borderRadius: BorderRadius.circular(28),
            boxShadow: context.appThemedCardShadows([
              BoxShadow(
                color: const Color(0xFF111827).withValues(alpha: 0.035),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ]),
          ),
          child: Row(
            children: [
              _CompactReportArtwork(style: imageStyle),
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
                            item.status.toUpperCase(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: accent,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          formattedDate,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: context.appMutedTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.deskripsiLaporan,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        height: 1.35,
                        color: context.appTextColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(footerIcon, size: 22, color: accent),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.nomorTiket,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.robotoMono(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: accent,
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

// ==================== CUSTOM PAINTER COMPONENT ARTWORKS ====================

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
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.34, size.height * 0.66), width: size.width * 0.34, height: size.height * 0.72), handPaint);

    final phoneRect = RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(size.width * 0.53, size.height * 0.5), width: size.width * 0.34, height: size.height * 0.58), const Radius.circular(14));
    canvas.drawRRect(phoneRect, Paint()..color = const Color(0xFFF7FAFF));
    canvas.drawRRect(phoneRect.deflate(6), Paint()..color = const Color(0xFFE8F0FF));

    final accent = Paint()..color = const Color(0xFFFF5757);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.36), 12, accent);
    final mark = Paint()..color = Colors.white..strokeWidth = 3..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.32), Offset(size.width * 0.5, size.height * 0.39), mark);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.42), 1.8, Paint()..color = Colors.white);
  }

  void _paintWave(Canvas canvas, Size size) {
    final wavePaint = Paint()..color = const Color(0xFF79B8FF).withValues(alpha: 0.7)..strokeWidth = 2..style = PaintingStyle.stroke;
    for (int i = 0; i < 7; i++) {
      final offsetY = size.height * 0.22 + (i * 12);
      final path = Path()
        ..moveTo(0, offsetY)
        ..quadraticBezierTo(size.width * 0.25, offsetY - 10, size.width * 0.5, offsetY)
        ..quadraticBezierTo(size.width * 0.75, offsetY + 10, size.width, offsetY - 4);
      canvas.drawPath(path, wavePaint);
    }
  }

  void _paintSilhouette(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xAA0A0D12));
    final glow = Paint()..shader = const RadialGradient(colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)]).createShader(Rect.fromCircle(center: Offset(size.width * 0.5, size.height * 0.34), radius: size.width * 0.6));
    canvas.drawRect(Offset.zero & size, glow);

    final bodyPaint = Paint()..color = const Color(0xFF111111);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.34), 16, bodyPaint);
    final bodyPath = Path()
      ..moveTo(size.width * 0.34, size.height * 0.92)
      ..quadraticBezierTo(size.width * 0.45, size.height * 0.44, size.width * 0.5, size.height * 0.46)
      ..quadraticBezierTo(size.width * 0.55, size.height * 0.44, size.width * 0.66, size.height * 0.92)
      ..close();
    canvas.drawPath(bodyPath, bodyPaint);
    canvas.drawLine(Offset(size.width * 0.58, size.height * 0.54), Offset(size.width * 0.8, size.height * 0.42), bodyPaint..strokeWidth = 6);
  }

  void _paintPlanet(Canvas canvas, Size size) {
    final planetPaint = Paint()..shader = const RadialGradient(colors: [Color(0xFF67D6FF), Color(0xFF0E5BAF), Color(0xFF12335E)]).createShader(Rect.fromCircle(center: Offset(size.width * 0.48, size.height * 0.5), radius: size.width * 0.32));
    canvas.drawCircle(Offset(size.width * 0.48, size.height * 0.5), size.width * 0.31, planetPaint);

    final orbitPaint = Paint()..color = const Color(0xFF9EE7FF).withValues(alpha: 0.6)..style = PaintingStyle.stroke..strokeWidth = 2;
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.48, size.height * 0.5), width: size.width * 0.74, height: size.height * 0.34), orbitPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.48, size.height * 0.5), width: size.width * 0.48, height: size.height * 0.68), orbitPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}