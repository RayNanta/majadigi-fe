import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class HoaxTrackResultPage extends StatelessWidget {
  const HoaxTrackResultPage({super.key, required this.ticketNumber});

  final String ticketNumber;

  static const _timelineItems = [
    _TrackingTimelineItem(
      title: 'Laporan Diterima',
      description: 'Admin sedang memverifikasi detail laporan Anda.',
      timestamp: '12 April 2026, 09:30',
      isCompleted: true,
    ),
    _TrackingTimelineItem(
      title: 'Penugasan Petugas',
      description: 'Laporan telah diteruskan ke tim lapangan wilayah Barat.',
      timestamp: '13 April 2026, 14:15',
    ),
    _TrackingTimelineItem(
      title: 'Penyelesaian',
      description: 'Tahap akhir perbaikan dan dokumentasi hasil.',
    ),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeHoaxClinicTrack);
  }

  @override
  Widget build(BuildContext context) {
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
                      'Lacak Pelaporan',
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
                padding: const EdgeInsets.fromLTRB(24, 30, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            'Hasil Pencarian',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: context.appThemedTextColor(
                                const Color(0xFF2A3466),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Menampilkan 1 hasil',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: context.appThemedMutedTextColor(
                              const Color(0xFF7A80A8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(28, 30, 28, 30),
                      decoration: BoxDecoration(
                        color: context.appSurfaceColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: context.appThemedCardShadows([
                          BoxShadow(
                            color: const Color(
                              0xFF111827,
                            ).withValues(alpha: 0.04),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ]),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TIKET AKTIF',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.welcomeAccent,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 26),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final useColumn = constraints.maxWidth < 620;

                              if (useColumn) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ticketNumber,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 34,
                                        fontWeight: FontWeight.w800,
                                        color: context.appThemedTextColor(
                                          const Color(0xFF23262D),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    const _TrackingStatusPill(),
                                    const SizedBox(height: 18),
                                    const _TrackingDateCard(),
                                  ],
                                );
                              }

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ticketNumber,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 34,
                                            fontWeight: FontWeight.w800,
                                            color: context.appThemedTextColor(
                                              const Color(0xFF23262D),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 18),
                                        const _TrackingStatusPill(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  const SizedBox(
                                    width: 190,
                                    child: _TrackingDateCard(),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 34),
                          ...List.generate(_timelineItems.length, (index) {
                            final item = _timelineItems[index];
                            final isLast = index == _timelineItems.length - 1;

                            return Padding(
                              padding: EdgeInsets.only(bottom: isLast ? 0 : 34),
                              child: _TrackingTimelineRow(
                                item: item,
                                isLast: isLast,
                              ),
                            );
                          }),
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

class _TrackingStatusPill extends StatelessWidget {
  const _TrackingStatusPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? const Color(0xFF332713)
            : const Color(0xFFFFEAC2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.circle, size: 14, color: Color(0xFFF07A00)),
          const SizedBox(width: 10),
          Text(
            'Dalam Proses',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFF07A00),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackingDateCard extends StatelessWidget {
  const _TrackingDateCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? context.appSubtleSurfaceColor
            : const Color(0xFFDCEAFF),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tanggal Laporan',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: context.appThemedMutedTextColor(const Color(0xFF7E869D)),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '12 April 2026',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: context.appThemedTextColor(const Color(0xFF23262D)),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackingTimelineRow extends StatelessWidget {
  const _TrackingTimelineRow({required this.item, required this.isLast});

  final _TrackingTimelineItem item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final lineColor = item.isCompleted
        ? const Color(0xFF8AB7FF)
        : const Color(0xFF9FC2FF);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 58,
          child: Column(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: item.isCompleted
                      ? AppColors.welcomeAccent
                      : const Color(0xFFD4E6FF),
                  shape: BoxShape.circle,
                ),
                child: item.isCompleted
                    ? const Icon(Icons.check_rounded, color: Colors.white)
                    : const Center(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.welcomeAccent,
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(width: 14, height: 14),
                        ),
                      ),
              ),
              if (!isLast) Container(width: 4, height: 138, color: lineColor),
            ],
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: context.appThemedTextColor(const Color(0xFF23262D)),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                    color: context.appThemedMutedTextColor(
                      const Color(0xFF373B43),
                    ),
                  ),
                ),
                if (item.timestamp != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    item.timestamp!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: context.appThemedMutedTextColor(
                        const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TrackingTimelineItem {
  const _TrackingTimelineItem({
    required this.title,
    required this.description,
    this.timestamp,
    this.isCompleted = false,
  });

  final String title;
  final String description;
  final String? timestamp;
  final bool isCompleted;
}
