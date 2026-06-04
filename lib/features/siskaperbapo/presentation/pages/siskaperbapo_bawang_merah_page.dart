import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class SiskaperbapoBawangMerahPage extends StatefulWidget {
  const SiskaperbapoBawangMerahPage({super.key});

  @override
  State<SiskaperbapoBawangMerahPage> createState() =>
      _SiskaperbapoBawangMerahPageState();
}

class _SiskaperbapoBawangMerahPageState
    extends State<SiskaperbapoBawangMerahPage> {
  static const _tabs = [
    _TrendTab(
      label: '1\nMinggu',
      bubblePrice: 'Rp36.118',
      points: [0.28, 0.39, 0.31, 0.58, 0.47, 0.73, 0.62, 0.78],
    ),
    _TrendTab(
      label: '1\nBulan',
      bubblePrice: 'Rp37.240',
      points: [0.25, 0.32, 0.42, 0.38, 0.54, 0.6, 0.57, 0.69],
    ),
    _TrendTab(
      label: '3\nBulan',
      bubblePrice: 'Rp35.950',
      points: [0.33, 0.29, 0.36, 0.44, 0.39, 0.52, 0.48, 0.64],
    ),
  ];

  static const _regionPrices = [
    _RegionPriceItem(
      region: 'Kab. Pamekasan',
      province: 'JAWA TIMUR',
      price: 'Rp45.000',
      delta: '~-2.4%',
      tone: _RegionPriceTone.down,
    ),
    _RegionPriceItem(
      region: 'Kota Madiun',
      province: 'JAWA TIMUR',
      price: 'Rp42.666',
      delta: '~1.1%',
      tone: _RegionPriceTone.up,
    ),
    _RegionPriceItem(
      region: 'Kota Surabaya',
      province: 'JAWA TIMUR',
      price: 'Rp36.200',
      delta: 'STABIL',
      tone: _RegionPriceTone.stable,
    ),
    _RegionPriceItem(
      region: 'Kab. Nganjuk',
      province: 'JAWA TIMUR',
      price: 'Rp26.000',
      delta: '~4.8%',
      tone: _RegionPriceTone.up,
    ),
  ];

  int _selectedTabIndex = 0;

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeSiskaperbapoMain);
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = _tabs[_selectedTabIndex];

    return Scaffold(
      backgroundColor: context.appThemedScaffoldColor(const Color(0xFFF6F9FF)),
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
                    onPressed: _handleBack,
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
                      'SISKAPERBAPO',
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
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Container(
                        height: 340,
                        width: double.infinity,
                        color: const Color(0xFFF9F9F6),
                        child: CustomPaint(
                          painter: const _RedOnionHeroPainter(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC93C46),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'HARGA TURUN',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Bawang Merah/kg',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: context.appThemedTextColor(
                          const Color(0xFF40444C),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rata-rata Harga Hari Ini per kilogram (kg)',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: context.appMutedTextColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Rp36.118',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: context.appThemedTextColor(
                          const Color(0xFF3F434A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: context.appSurfaceColor,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: context.appThemedCardShadows([
                          BoxShadow(
                            color: const Color(
                              0xFF111827,
                            ).withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ]),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _PriceSummaryTile(
                              label: 'TERTINGGI',
                              price: 'Rp45.000',
                              caption: 'Kab. Pamekasan',
                              trend: _CommodityTrend.up,
                            ),
                          ),
                          SizedBox(
                            height: 94,
                            child: VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: context.appBorderColor,
                            ),
                          ),
                          Expanded(
                            child: _PriceSummaryTile(
                              label: 'TERENDAH',
                              price: 'Rp26.000',
                              caption: 'Kab. Nganjuk',
                              trend: _CommodityTrend.down,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? context.appSurfaceColor
                            : const Color(0xFFE7F1FF),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Tren\nHarga',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: context.appThemedTextColor(
                                      const Color(0xFF2F3136),
                                    ),
                                    height: 1.45,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: context.isDarkMode
                                      ? context.appSubtleSurfaceColor
                                      : Colors.white.withValues(alpha: 0.75),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(_tabs.length, (
                                    index,
                                  ) {
                                    final tab = _tabs[index];
                                    final isSelected =
                                        index == _selectedTabIndex;

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedTabIndex = index;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 180,
                                        ),
                                        curve: Curves.easeOut,
                                        width: 76,
                                        height: 52,
                                        margin: EdgeInsets.only(
                                          left: index == 0 ? 0 : 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? context.appSurfaceColor
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                          boxShadow: isSelected
                                              ? [
                                                  BoxShadow(
                                                    color: const Color(
                                                      0xFF2563EB,
                                                    ).withValues(alpha: 0.08),
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ]
                                              : null,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          tab.label,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 13,
                                            fontWeight: isSelected
                                                ? FontWeight.w800
                                                : FontWeight.w500,
                                            color: isSelected
                                                ? AppColors.welcomeAccent
                                                : context
                                                      .appThemedMutedTextColor(
                                                        const Color(0xFF555A62),
                                                      ),
                                            height: 1.2,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            height: 258,
                            child: CustomPaint(
                              painter: _TrendChartPainter(tab: selectedTab),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  0,
                                  214,
                                  0,
                                  0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    _WeekdayLabel('Sen'),
                                    _WeekdayLabel('Sel'),
                                    _WeekdayLabel('Rab'),
                                    _WeekdayLabel('Kam'),
                                    _WeekdayLabel('Jum'),
                                    _WeekdayLabel('Sab'),
                                    _WeekdayLabel('Min'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ..._regionPrices.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _RegionPriceCard(item: item),
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

class _PriceSummaryTile extends StatelessWidget {
  const _PriceSummaryTile({
    required this.label,
    required this.price,
    required this.caption,
    required this.trend,
  });

  final String label;
  final String price;
  final String caption;
  final _CommodityTrend trend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                trend == _CommodityTrend.up
                    ? Icons.trending_up_rounded
                    : Icons.trending_down_rounded,
                size: 18,
                color: AppColors.welcomeAccent,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: context.appThemedMutedTextColor(
                    const Color(0xFF4F5A8A),
                  ),
                  letterSpacing: 0.35,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: context.appThemedTextColor(const Color(0xFF28326B)),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            caption,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: context.appThemedMutedTextColor(const Color(0xFF6E7895)),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  const _WeekdayLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: context.appThemedMutedTextColor(const Color(0xFF5B6272)),
      ),
    );
  }
}

class _RegionPriceCard extends StatelessWidget {
  const _RegionPriceCard({required this.item});

  final _RegionPriceItem item;

  @override
  Widget build(BuildContext context) {
    final deltaColor = switch (item.tone) {
      _RegionPriceTone.up => AppColors.welcomeAccent,
      _RegionPriceTone.down => const Color(0xFFFF3B63),
      _RegionPriceTone.stable => const Color(0xFF8F96A6),
    };

    return Container(
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ]),
      ),
      child: Row(
        children: [
          if (item.tone == _RegionPriceTone.stable)
            Container(
              width: 5,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.welcomeAccent,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(22),
                ),
              ),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                item.tone == _RegionPriceTone.stable ? 18 : 24,
                20,
                24,
                20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.region,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: context.appThemedTextColor(
                              const Color(0xFF3B3F47),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.province,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: context.appThemedMutedTextColor(
                              const Color(0xFF99A0AE),
                            ),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.price,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.welcomeAccent,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.delta,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: deltaColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendChartPainter extends CustomPainter {
  const _TrendChartPainter({required this.tab});

  final _TrendTab tab;

  @override
  void paint(Canvas canvas, Size size) {
    const chartLeft = 6.0;
    const chartTop = 20.0;
    final chartWidth = size.width - 18;
    const chartHeight = 182.0;
    final chartRect = Rect.fromLTWH(
      chartLeft,
      chartTop,
      chartWidth,
      chartHeight,
    );

    final gridPaint = Paint()
      ..color = const Color(0xFFCFE0FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final verticalLines = 4;
    final horizontalLines = 4;

    for (var i = 0; i <= verticalLines; i++) {
      final dx = chartRect.left + (chartRect.width / verticalLines) * i;
      canvas.drawLine(
        Offset(dx, chartRect.top),
        Offset(dx, chartRect.bottom),
        gridPaint,
      );
    }

    for (var i = 0; i <= horizontalLines; i++) {
      final dy = chartRect.top + (chartRect.height / horizontalLines) * i;
      canvas.drawLine(
        Offset(chartRect.left, dy),
        Offset(chartRect.right, dy),
        gridPaint,
      );
    }

    final points = <Offset>[];
    for (var i = 0; i < tab.points.length; i++) {
      final x =
          chartRect.left + (chartRect.width / (tab.points.length - 1)) * i;
      final y =
          chartRect.bottom -
          (chartRect.height * tab.points[i]).clamp(0, chartRect.height);
      points.add(Offset(x, y));
    }

    final areaPath = Path()..moveTo(points.first.dx, chartRect.bottom);
    for (final point in points) {
      areaPath.lineTo(point.dx, point.dy);
    }
    areaPath
      ..lineTo(points.last.dx, chartRect.bottom)
      ..close();

    final areaPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x663B82F6), Color(0x143B82F6)],
      ).createShader(chartRect);
    canvas.drawPath(areaPath, areaPaint);

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }

    final linePaint = Paint()
      ..color = AppColors.welcomeAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(linePath, linePaint);

    final lastPoint = points.last;
    final dotFillPaint = Paint()..color = AppColors.welcomeAccent;
    final dotStrokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(lastPoint, 7.5, dotFillPaint);
    canvas.drawCircle(lastPoint, 7.5, dotStrokePaint);

    final bubbleTextPainter = TextPainter(
      text: TextSpan(
        text: tab.bubblePrice,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final bubblePadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    );
    final bubbleWidth = bubbleTextPainter.width + bubblePadding.horizontal;
    final bubbleHeight = bubbleTextPainter.height + bubblePadding.vertical;
    final bubbleLeft = math.min(
      chartRect.right - bubbleWidth,
      math.max(chartRect.left, lastPoint.dx - bubbleWidth - 16),
    );
    final bubbleTop = math.max(
      chartRect.top + 4,
      lastPoint.dy - bubbleHeight - 14,
    );
    final bubbleRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(bubbleLeft, bubbleTop, bubbleWidth, bubbleHeight),
      const Radius.circular(12),
    );

    final bubblePaint = Paint()..color = AppColors.welcomeAccent;
    canvas.drawRRect(bubbleRect, bubblePaint);

    final bubbleCenterX = bubbleLeft + bubbleWidth - 24;
    final bubblePointer = Path()
      ..moveTo(bubbleCenterX, bubbleTop + bubbleHeight)
      ..lineTo(bubbleCenterX + 10, bubbleTop + bubbleHeight)
      ..lineTo(lastPoint.dx - 2, lastPoint.dy - 10)
      ..close();
    canvas.drawPath(bubblePointer, bubblePaint);

    bubbleTextPainter.paint(
      canvas,
      Offset(bubbleLeft + bubblePadding.left, bubbleTop + bubblePadding.top),
    );
  }

  @override
  bool shouldRepaint(covariant _TrendChartPainter oldDelegate) {
    return oldDelegate.tab != tab;
  }
}

class _RedOnionHeroPainter extends CustomPainter {
  const _RedOnionHeroPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final shadowPaint = Paint()
      ..color = const Color(0x22000000)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.9),
        width: size.width * 0.42,
        height: 18,
      ),
      shadowPaint,
    );

    final bulbPath = Path()
      ..moveTo(size.width * 0.24, size.height * 0.72)
      ..cubicTo(
        size.width * 0.18,
        size.height * 0.48,
        size.width * 0.3,
        size.height * 0.22,
        size.width * 0.47,
        size.height * 0.2,
      )
      ..cubicTo(
        size.width * 0.63,
        size.height * 0.18,
        size.width * 0.78,
        size.height * 0.34,
        size.width * 0.76,
        size.height * 0.54,
      )
      ..cubicTo(
        size.width * 0.74,
        size.height * 0.7,
        size.width * 0.6,
        size.height * 0.84,
        size.width * 0.45,
        size.height * 0.83,
      )
      ..cubicTo(
        size.width * 0.31,
        size.height * 0.82,
        size.width * 0.21,
        size.height * 0.78,
        size.width * 0.24,
        size.height * 0.72,
      )
      ..close();

    final bulbPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.28, -0.46),
        radius: 1.08,
        colors: [Color(0xFFFAD1E8), Color(0xFFB42C5D), Color(0xFF6D0B2C)],
        stops: [0.0, 0.42, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(bulbPath, bulbPaint);

    final glossPaint = Paint()
      ..shader =
          RadialGradient(
            center: const Alignment(-0.3, -0.5),
            radius: 0.7,
            colors: [
              Colors.white.withValues(alpha: 0.72),
              Colors.white.withValues(alpha: 0.0),
            ],
          ).createShader(
            Rect.fromLTWH(
              size.width * 0.18,
              size.height * 0.2,
              size.width * 0.4,
              size.height * 0.36,
            ),
          );
    canvas.drawOval(
      Rect.fromLTWH(
        size.width * 0.22,
        size.height * 0.28,
        size.width * 0.26,
        size.height * 0.22,
      ),
      glossPaint,
    );

    final rootPaint = Paint()
      ..color = const Color(0xFF6D401D)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 6; i++) {
      final x = size.width * 0.38 + (i * 7);
      canvas.drawLine(
        Offset(x, size.height * 0.79),
        Offset(x - 6 + (i % 2) * 4, size.height * 0.84),
        rootPaint,
      );
    }

    final neckPath = Path()
      ..moveTo(size.width * 0.55, size.height * 0.29)
      ..cubicTo(
        size.width * 0.63,
        size.height * 0.14,
        size.width * 0.78,
        size.height * 0.18,
        size.width * 0.76,
        size.height * 0.34,
      )
      ..cubicTo(
        size.width * 0.74,
        size.height * 0.43,
        size.width * 0.7,
        size.height * 0.46,
        size.width * 0.62,
        size.height * 0.44,
      )
      ..close();
    final neckPaint = Paint()
      ..shader =
          const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE37AA4), Color(0xFF7A122F)],
          ).createShader(
            Rect.fromLTWH(
              size.width * 0.55,
              size.height * 0.16,
              size.width * 0.22,
              size.height * 0.3,
            ),
          );
    canvas.drawPath(neckPath, neckPaint);

    final leafPaint = Paint()
      ..shader =
          const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFF2F7A35), Color(0xFF91D65A)],
          ).createShader(
            Rect.fromLTWH(
              size.width * 0.32,
              size.height * 0.05,
              size.width * 0.28,
              size.height * 0.25,
            ),
          );

    for (final leaf in [
      [
        Offset(size.width * 0.45, size.height * 0.23),
        Offset(size.width * 0.39, size.height * 0.05),
        Offset(size.width * 0.33, size.height * 0.09),
      ],
      [
        Offset(size.width * 0.5, size.height * 0.2),
        Offset(size.width * 0.5, size.height * 0.03),
        Offset(size.width * 0.44, size.height * 0.08),
      ],
      [
        Offset(size.width * 0.55, size.height * 0.21),
        Offset(size.width * 0.61, size.height * 0.05),
        Offset(size.width * 0.57, size.height * 0.11),
      ],
    ]) {
      final path = Path()
        ..moveTo(leaf[0].dx, leaf[0].dy)
        ..quadraticBezierTo(leaf[1].dx, leaf[1].dy, leaf[2].dx, leaf[2].dy)
        ..quadraticBezierTo(
          leaf[0].dx - 8,
          leaf[0].dy - 10,
          leaf[0].dx,
          leaf[0].dy,
        );
      canvas.drawPath(path, leafPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrendTab {
  const _TrendTab({
    required this.label,
    required this.bubblePrice,
    required this.points,
  });

  final String label;
  final String bubblePrice;
  final List<double> points;
}

class _RegionPriceItem {
  const _RegionPriceItem({
    required this.region,
    required this.province,
    required this.price,
    required this.delta,
    required this.tone,
  });

  final String region;
  final String province;
  final String price;
  final String delta;
  final _RegionPriceTone tone;
}

enum _CommodityTrend { up, down }

enum _RegionPriceTone { up, down, stable }
