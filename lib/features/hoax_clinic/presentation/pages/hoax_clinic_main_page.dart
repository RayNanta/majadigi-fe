import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../services/hoax_provider.dart';

class HoaxClinicMainPage extends ConsumerWidget {
  const HoaxClinicMainPage({super.key});

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.homeHoaxClinic);
  }

  void _openHoaxReport(BuildContext context) {
    context.pushNamed(RouteNames.homeHoaxClinicReport);
  }

  void _openHoaxTracking(BuildContext context) {
    context.pushNamed(RouteNames.homeHoaxClinicTrack);
  }

  void _openLatestReportDetail(BuildContext context) {
    context.pushNamed(RouteNames.homeHoaxClinicLatestReport);
  }

  void _openLatestReports(BuildContext context) {
    context.pushNamed(RouteNames.homeHoaxClinicLatestReports);
  }

  // ✅ Hitung stats dinamis dari list laporan
  Map<String, int> _computeStats(List<dynamic> reports) {
    int hoaks = 0, disinformasi = 0, fakta = 0, hateSpeech = 0;
    for (final r in reports) {
      final status = (r['status'] ?? '').toString().toLowerCase();
      if (status == 'hoax') hoaks++;
      else if (status == 'disinformasi') disinformasi++;
      else if (status == 'valid' || status == 'fakta') fakta++;
      else if (status == 'hate_speech') hateSpeech++;
    }
    return {
      'hoaks': hoaks,
      'disinformasi': disinformasi,
      'fakta': fakta,
      'hate_speech': hateSpeech,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(hoaxReportsProvider);

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
                      'Klinik Hoaks',
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
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(hoaxReportsProvider.future),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 30, 24, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ DINAMIS: Stats grid dari data real
                      reportsAsync.when(
                        loading: () => GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1,
                          children: const [
                            _StatSkeleton(),
                            _StatSkeleton(),
                            _StatSkeleton(),
                            _StatSkeleton(),
                          ],
                        ),
                        error: (_, __) => _buildStatsGrid(context, 0, 0, 0, 0),
                        data: (reports) {
                          final stats = _computeStats(reports);
                          return _buildStatsGrid(
                            context,
                            stats['hoaks']!,
                            stats['disinformasi']!,
                            stats['fakta']!,
                            stats['hate_speech']!,
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Fitur Utama',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: context.appThemedTextColor(const Color(0xFF16181D)),
                        ),
                      ),
                      const SizedBox(height: 18),
                      _FeatureActionCard(
                        title: 'Laporan Hoaks',
                        description: 'Kirim info yang Kamu temukan, Kami bantu klarifikasi dalam 1×24 jam.',
                        illustration: const _DocumentOutlineIcon(),
                        onPressed: () => _openHoaxReport(context),
                      ),
                      const SizedBox(height: 18),
                      _FeatureActionCard(
                        title: 'Lacak Tiket Laporan',
                        description: 'Pantau status permohonan klarifikasi yang telah diajukan secara real time.',
                        illustration: const _SearchOutlineIcon(),
                        onPressed: () => _openHoaxTracking(context),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Laporan Terkini',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: context.appThemedTextColor(const Color(0xFF23262D)),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Update klarifikasi terbaru',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: context.appMutedTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () => _openLatestReports(context),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.welcomeAccent,
                              textStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            child: const Text('Lihat Semua'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      SizedBox(
                        height: 410,
                        child: reportsAsync.when(
                          loading: () => const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.welcomeAccent,
                            ),
                          ),
                          error: (err, stack) => Center(
                            child: Text(
                              'Gagal mengambil data dari server.',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          data: (rawReports) {
                            if (rawReports.isEmpty) {
                              return Center(
                                child: Text(
                                  'Belum ada laporan aduan hoaks.',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    color: context.appMutedTextColor,
                                  ),
                                ),
                              );
                            }
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: rawReports.length,
                              separatorBuilder: (_, __) =>
                              const SizedBox(width: 18),
                              itemBuilder: (context, index) {
                                final report = rawReports[index];
                                return _ReportCard(
                                  reportData: report,
                                  onTap: () => _openLatestReportDetail(context),
                                );
                              },
                            );
                          },
                        ),
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

  // ✅ Helper build stats grid dengan nilai dinamis
  Widget _buildStatsGrid(
      BuildContext context,
      int hoaks,
      int disinformasi,
      int fakta,
      int hateSpeech,
      ) {
    final stats = [
      _HoaxStatItem(
        title: 'Berita Hoaks',
        value: '$hoaks',
        icon: Icons.cancel_outlined,
        iconColor: const Color(0xFFFF175A),
        iconBackground: const Color(0xFFFFE2EB),
      ),
      _HoaxStatItem(
        title: 'Disinformasi',
        value: '$disinformasi',
        icon: Icons.wifi_tethering_error_rounded,
        iconColor: const Color(0xFFFF175A),
        iconBackground: const Color(0xFFFFE2EB),
      ),
      _HoaxStatItem(
        title: 'Fakta',
        value: '$fakta',
        icon: Icons.verified_rounded,
        iconColor: AppColors.welcomeAccent,
        iconBackground: const Color(0xFFE7F0FF),
      ),
      _HoaxStatItem(
        title: 'Hate Speech',
        value: '$hateSpeech',
        icon: Icons.warning_amber_rounded,
        iconColor: const Color(0xFFFF175A),
        iconBackground: const Color(0xFFFFE2EB),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => _HoaxStatCard(item: stats[index]),
    );
  }
}

// ==================== SUB-WIDGETS ====================

class _StatSkeleton extends StatelessWidget {
  const _StatSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white12
                  : const Color(0xFFE8EAED),
              shape: BoxShape.circle,
            ),
          ),
          const Spacer(),
          Container(
            height: 14,
            width: 80,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white12
                  : const Color(0xFFE8EAED),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 28,
            width: 50,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white12
                  : const Color(0xFFE8EAED),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}

class _HoaxStatItem {
  const _HoaxStatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
}

class _HoaxStatCard extends StatelessWidget {
  const _HoaxStatCard({required this.item});
  final _HoaxStatItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.isDarkMode
                  ? item.iconColor.withValues(alpha: 0.16)
                  : item.iconBackground,
            ),
            child: Icon(item.icon, color: item.iconColor, size: 30),
          ),
          const Spacer(),
          Text(
            item.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.welcomeAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: context.appThemedTextColor(const Color(0xFF2A2F63)),
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureActionCard extends StatelessWidget {
  const _FeatureActionCard({
    required this.title,
    required this.description,
    required this.illustration,
    required this.onPressed,
  });

  final String title;
  final String description;
  final Widget illustration;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
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
      child: Stack(
        children: [
          Positioned(
            right: -4,
            bottom: 0,
            child: Opacity(opacity: 0.1, child: illustration),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.welcomeAccent,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 280,
                child: Text(
                  description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.65,
                    color: context.appThemedMutedTextColor(
                      const Color(0xFF4E525A),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              SizedBox(
                height: 58,
                child: FilledButton(
                  onPressed: onPressed,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.welcomeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    textStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Selengkapnya'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.reportData, required this.onTap});

  final dynamic reportData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final String ticket = reportData['nomor_tiket'] ?? 'KH-0000';
    final String status =
    (reportData['status'] ?? 'PROSES').toString().toUpperCase();
    final String content =
        reportData['deskripsi_laporan'] ?? 'Tidak ada deskripsi laporan.';
    final String rawDate = reportData['created_at'] ?? '';
    final String formattedDate =
    rawDate.length > 10 ? rawDate.substring(0, 10) : 'Baru Saja';

    return SizedBox(
      width: 340,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: context.appSurfaceColor,
              borderRadius: BorderRadius.circular(28),
              boxShadow: context.appThemedCardShadows([
                BoxShadow(
                  color: const Color(0xFF111827).withValues(alpha: 0.04),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ]),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 252,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF111827), Color(0xFF3B2C5A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 18,
                        top: 18,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: status == 'VALID' || status == 'FAKTA'
                                ? const Color(0xFF10B981)
                                : status == 'PROSES'
                                ? const Color(0xFFFFA928)
                                : const Color(0xFFC61B2E),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            status,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 18,
                        bottom: 12,
                        child: Icon(
                          Icons.campaign_rounded,
                          size: 138,
                          color: Colors.white.withValues(alpha: 0.14),
                        ),
                      ),
                      Positioned(
                        left: 22,
                        right: 22,
                        bottom: 28,
                        child: Container(
                          height: 116,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.all(12),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            ticket,
                            style: GoogleFonts.robotoMono(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.welcomeAccent,
                          ),
                          children: [
                            const TextSpan(text: 'KLINIK HOAKS'),
                            TextSpan(
                              text: '  •  $formattedDate',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: context.appThemedMutedTextColor(
                                  const Color(0xFF6E7395),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          height: 1.45,
                          color: context.appThemedTextColor(
                            const Color(0xFF2B315E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DocumentOutlineIcon extends StatelessWidget {
  const _DocumentOutlineIcon();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: CustomPaint(painter: _DocumentPainter()),
    );
  }
}

class _SearchOutlineIcon extends StatelessWidget {
  const _SearchOutlineIcon();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: CustomPaint(painter: _SearchPainter()),
    );
  }
}

class _DocumentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..color = const Color(0xFFD6DAE3);
    final path = Path()
      ..moveTo(size.width * 0.18, size.height * 0.08)
      ..lineTo(size.width * 0.64, size.height * 0.08)
      ..lineTo(size.width * 0.86, size.height * 0.3)
      ..lineTo(size.width * 0.86, size.height * 0.9)
      ..lineTo(size.width * 0.18, size.height * 0.9)
      ..close();
    canvas.drawPath(path, paint);
    canvas.drawLine(
      Offset(size.width * 0.62, size.height * 0.08),
      Offset(size.width * 0.62, size.height * 0.32),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.62, size.height * 0.32),
      Offset(size.width * 0.86, size.height * 0.32),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SearchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..color = const Color(0xFFD6DAE3);
    canvas.drawCircle(
      Offset(size.width * 0.45, size.height * 0.45),
      size.width * 0.24,
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.62, size.height * 0.62),
      Offset(size.width * 0.84, size.height * 0.84),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}