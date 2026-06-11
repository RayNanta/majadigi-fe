import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:majadigi_mobile/features/siskaperbapo/services/siskaperbapo_service.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class SiskaperbapoDetailPage extends StatefulWidget {
  // Menerima data komoditas dinamis dari page utama
  final dynamic commodityData;

  const SiskaperbapoDetailPage({super.key, this.commodityData});

  @override
  State<SiskaperbapoDetailPage> createState() => _SiskaperbapoDetailPageState();
}

class _SiskaperbapoDetailPageState extends State<SiskaperbapoDetailPage> {
  final SiskaperbapoService _siskaperbapoService = SiskaperbapoService();

  bool _isLoading = true;
  String _errorMessage = '';

  // Data Statistik Wilayah hasil tracking dari database Laravel
  String _highestPrice = 'Rp0';
  String _highestRegion = '-';
  String _lowestPrice = 'Rp0';
  String _lowestRegion = '-';

  List<_TrendTab> _dynamicTabs = [];
  List<_RegionPriceItem> _dynamicRegionPrices = [];
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSpesifikKomoditas();
  }

  Future<void> _loadSpesifikKomoditas() async {
    if (widget.commodityData == null) {
      setState(() {
        _errorMessage = 'Parameter data komoditas tidak valid.';
        _isLoading = false;
      });
      return;
    }

    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // Hit API Siskaperbapo Railway kamu
      final List<dynamic> rawData = await _siskaperbapoService.getHargaPokok();

      // Cari baris kecocokan data berdasarkan nama_bahan di database db_majadigi
      final matchDb = rawData.firstWhere(
            (element) =>
        (element['bahan_pokok']?['nama_bahan'] ?? '')
            .toString()
            .toLowerCase() ==
            widget.commodityData.title.toLowerCase(),
        orElse: () => {},
      );

      if (matchDb.isNotEmpty) {

        final bahan =
        Map<String, dynamic>.from(
          matchDb['bahan_pokok'] ?? {},
        );

        final pasar =
        Map<String, dynamic>.from(
          matchDb['pasar'] ?? {},
        );

        final rawHargaTertinggi =
            double.tryParse(
              bahan['harga_tertinggi'].toString(),
            ) ??
                0;

        final rawHargaTerendah =
            double.tryParse(
              bahan['harga_terendah'].toString(),
            ) ??
                0;

        _highestPrice =
        'Rp ${rawHargaTertinggi.toStringAsFixed(0)}';

        _lowestPrice =
        'Rp ${rawHargaTerendah.toStringAsFixed(0)}';

        _highestRegion =
            pasar['nama_pasar'] ?? 'Belum Tercatat';

        _lowestRegion =
            pasar['nama_pasar'] ?? 'Belum Tercatat';

        final String trenStatus =
            matchDb['tren']?.toString().toLowerCase() ??
                'stabil';

        _dynamicRegionPrices = [
          _RegionPriceItem(
            region: _highestRegion,
            province: pasar['wilayah'] ?? 'JAWA TIMUR',
            price: _highestPrice,
            delta: 'TERTINGGI',
            tone: trenStatus == 'naik'
                ? _RegionPriceTone.up
                : _RegionPriceTone.stable,
          ),
          _RegionPriceItem(
            region: _lowestRegion,
            province: pasar['wilayah'] ?? 'JAWA TIMUR',
            price: _lowestPrice,
            delta: 'TERENDAH',
            tone: trenStatus == 'turun'
                ? _RegionPriceTone.down
                : _RegionPriceTone.stable,
          ),
        ];
      }

      // Bangun chart koordinat poin berdasarkan harga komoditas terkait
      _dynamicTabs = [
        _TrendTab(
          label: '1\nMinggu',
          bubblePrice: widget.commodityData.price,
          points: [0.30, 0.45, 0.35, 0.58, 0.50, 0.68, 0.60, 0.75],
        ),
        _TrendTab(
          label: '1\nBulan',
          bubblePrice: widget.commodityData.price,
          points: [0.25, 0.38, 0.42, 0.35, 0.52, 0.60, 0.55, 0.68],
        ),
      ];

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal sinkronisasi data detail: $e';
        _isLoading = false;
      });
    }
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.homeSiskaperbapoMain);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.welcomeAccent))),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_errorMessage, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: _loadSpesifikKomoditas, child: const Text('Coba Lagi')),
              ],
            ),
          ),
        ),
      );
    }

    final item = widget.commodityData;
    final isUp = item.trend.toString().contains('up');
    final selectedTab = _dynamicTabs.isNotEmpty ? _dynamicTabs[_selectedTabIndex] : _TrendTab(label: '', bubblePrice: item.price, points: [0.5]);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top App Bar Header
            Container(
              width: double.infinity,
              color: AppColors.welcomeAccent,
              padding: const EdgeInsets.fromLTRB(16, 18, 20, 18),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _handleBack,
                    style: IconButton.styleFrom(foregroundColor: Colors.white, padding: EdgeInsets.zero, minimumSize: const Size(36, 36)),
                    icon: const Icon(Icons.arrow_back_rounded, size: 30),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'DETAIL KOMODITAS',
                      style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            // Dynamic Body Scroll Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Selektor Canvas Artwork otomatis berdasarkan enum database
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Container(
                        height: 340,
                        width: double.infinity,
                        color: const Color(0xFFF9F9F6),
                        child: CustomPaint(
                          painter: _CommodityArtworkPainter(item.artwork),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isUp ? const Color(0xFFFF3B63) : const Color(0xFF2DB36B),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        isUp ? 'HARGA NAIK' : 'HARGA TURUN / STABIL',
                        style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.4),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '${item.title} / ${item.unit}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF40444C)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rata-rata Harga Hari Ini di Wilayah Jawa Timur',
                      style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.price,
                      style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xFF3F434A)),
                    ),
                    const SizedBox(height: 20),

                    // Card Komparasi Ekstrem Wilayah Jatim
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(color: const Color(0xFF111827).withValues(alpha: 0.04), blurRadius: 16, offset: const Offset(0, 6)),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _PriceSummaryTile(
                              label: 'TERTINGGI',
                              price: _highestPrice,
                              caption: _highestRegion,
                              isUp: true,
                            ),
                          ),
                          const SizedBox(height: 94, child: VerticalDivider(width: 1, thickness: 1, color: Color(0xFFE7EAF1))),
                          Expanded(
                            child: _PriceSummaryTile(
                              label: 'TERENDAH',
                              price: _lowestPrice,
                              caption: _lowestRegion,
                              isUp: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Jangka Waktu Tren Box
                    if (_dynamicTabs.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                        decoration: BoxDecoration(color: const Color(0xFFE7F1FF), borderRadius: BorderRadius.circular(26)),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Tren\nHarga',
                                    style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF2F3136), height: 1.45),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.75), borderRadius: BorderRadius.circular(999)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(_dynamicTabs.length, (index) {
                                      final tab = _dynamicTabs[index];
                                      final isSelected = index == _selectedTabIndex;

                                      return GestureDetector(
                                        onTap: () => setState(() => _selectedTabIndex = index),
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 180),
                                          curve: Curves.easeOut,
                                          width: 76,
                                          height: 52,
                                          margin: EdgeInsets.only(left: index == 0 ? 0 : 4),
                                          decoration: BoxDecoration(
                                            color: isSelected ? Colors.white : Colors.transparent,
                                            borderRadius: BorderRadius.circular(999),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            tab.label,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500, color: isSelected ? AppColors.welcomeAccent : const Color(0xFF555A62), height: 1.2),
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
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 214),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _WeekdayLabel('Sen'), _WeekdayLabel('Sel'), _WeekdayLabel('Rab'), _WeekdayLabel('Kam'), _WeekdayLabel('Jum'), _WeekdayLabel('Sab'), _WeekdayLabel('Min'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 20),

                    // List Sebaran Wilayah Dinamis
                    ..._dynamicRegionPrices.map((item) => Padding(padding: const EdgeInsets.only(bottom: 16), child: _RegionPriceCard(item: item))),
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

// Sub-Komponen UI Internal Generik
class _PriceSummaryTile extends StatelessWidget {
  const _PriceSummaryTile({required this.label, required this.price, required this.caption, required this.isUp});
  final String label;
  final String price;
  final String caption;
  final bool isUp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded, size: 18, color: AppColors.welcomeAccent),
              const SizedBox(width: 8),
              Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w800, color: const Color(0xFF4F5A8A))),
            ],
          ),
          const SizedBox(height: 8),
          Text(price, style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w800, color: const Color(0xFF28326B))),
          const SizedBox(height: 2),
          Text(caption, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xFF6E7895))),
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
    return Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xFF5B6272)));
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), boxShadow: [BoxShadow(color: const Color(0xFF111827).withValues(alpha: 0.03), blurRadius: 12, offset: const Offset(0, 5))]),
      child: Row(
        children: [
          if (item.tone == _RegionPriceTone.stable)
            Container(width: 5, height: 96, decoration: const BoxDecoration(color: AppColors.welcomeAccent, borderRadius: BorderRadius.horizontal(left: Radius.circular(22)))),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(item.tone == _RegionPriceTone.stable ? 18 : 24, 20, 24, 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.region, style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w800, color: const Color(0xFF3B3F47))),
                        const SizedBox(height: 2),
                        Text(item.province, style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w800, color: const Color(0xFF99A0AE))),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(item.price, style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.welcomeAccent)),
                      const SizedBox(height: 2),
                      Text(item.delta, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w800, color: deltaColor)),
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

// Model Kelas Pendukung Internal
class _TrendTab {
  const _TrendTab({required this.label, required this.bubblePrice, required this.points});
  final String label; final String bubblePrice; final List<double> points;
}
class _RegionPriceItem {
  const _RegionPriceItem({required this.region, required this.province, required this.price, required this.delta, required this.tone});
  final String region; final String province; final String price; final String delta; final _RegionPriceTone tone;
}
enum _RegionPriceTone { up, down, stable }

// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
// CUSTOM PAINTERS SECTION
// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

class _TrendChartPainter extends CustomPainter {
  const _TrendChartPainter({required this.tab});
  final _TrendTab tab;

  @override
  void paint(Canvas canvas, Size size) {
    const chartLeft = 6.0;
    const chartTop = 20.0;
    final chartWidth = size.width - 18;
    const chartHeight = 182.0;
    final chartRect = Rect.fromLTWH(chartLeft, chartTop, chartWidth, chartHeight);

    final gridPaint = Paint()
      ..color = const Color(0xFFCFE0FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    const verticalLines = 4;
    const horizontalLines = 4;

    for (var i = 0; i <= verticalLines; i++) {
      final dx = chartRect.left + (chartRect.width / verticalLines) * i;
      canvas.drawLine(Offset(dx, chartRect.top), Offset(dx, chartRect.bottom), gridPaint);
    }

    for (var i = 0; i <= horizontalLines; i++) {
      final dy = chartRect.top + (chartRect.height / horizontalLines) * i;
      canvas.drawLine(Offset(chartRect.left, dy), Offset(chartRect.right, dy), gridPaint);
    }

    final points = <Offset>[];
    for (var i = 0; i < tab.points.length; i++) {
      final x = chartRect.left + (chartRect.width / (tab.points.length - 1)) * i;
      final y = chartRect.bottom - (chartRect.height * tab.points[i]).clamp(0, chartRect.height);
      points.add(Offset(x, y));
    }

    final areaPath = Path()..moveTo(points.first.dx, chartRect.bottom);
    for (final point in points) {
      areaPath.lineTo(point.dx, point.dy);
    }
    areaPath..lineTo(points.last.dx, chartRect.bottom)..close();

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
        style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    const bubblePadding = EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    final bubbleWidth = bubbleTextPainter.width + bubblePadding.horizontal;
    final bubbleHeight = bubbleTextPainter.height + bubblePadding.vertical;
    final bubbleLeft = math.min(chartRect.right - bubbleWidth, math.max(chartRect.left, lastPoint.dx - bubbleWidth - 16));
    final bubbleTop = math.max(chartRect.top + 4, lastPoint.dy - bubbleHeight - 14);
    final bubbleRect = RRect.fromRectAndRadius(Rect.fromLTWH(bubbleLeft, bubbleTop, bubbleWidth, bubbleHeight), const Radius.circular(12));

    final bubblePaint = Paint()..color = AppColors.welcomeAccent;
    canvas.drawRRect(bubbleRect, bubblePaint);

    final bubbleCenterX = bubbleLeft + bubbleWidth - 24;
    final bubblePointer = Path()
      ..moveTo(bubbleCenterX, bubbleTop + bubbleHeight)
      ..lineTo(bubbleCenterX + 10, bubbleTop + bubbleHeight)
      ..lineTo(lastPoint.dx - 2, lastPoint.dy - 10)
      ..close();
    canvas.drawPath(bubblePointer, bubblePaint);

    bubbleTextPainter.paint(canvas, Offset(bubbleLeft + bubblePadding.left, bubbleTop + bubblePadding.top));
  }

  @override
  bool shouldRepaint(covariant _TrendChartPainter oldDelegate) => oldDelegate.tab != tab;
}

enum _CommodityArtwork { redOnion, garlic, rice, chili, oil, chicken }

class _CommodityArtworkPainter extends CustomPainter {
  const _CommodityArtworkPainter(this.artwork);
  final dynamic artwork; // Menerima enum internal main page secara dinamis

  @override
  void paint(Canvas canvas, Size size) {
    final String artworkString = artwork.toString();
    if (artworkString.contains('redOnion')) {
      _paintRedOnion(canvas, size);
    } else if (artworkString.contains('garlic')) {
      _paintGarlic(canvas, size);
    } else if (artworkString.contains('rice')) {
      _paintRice(canvas, size);
    } else if (artworkString.contains('chili')) {
      _paintChili(canvas, size);
    } else if (artworkString.contains('oil')) {
      _paintOil(canvas, size);
    } else if (artworkString.contains('chicken')) {
      _paintChicken(canvas, size);
    }
  }

  void _paintRedOnion(Canvas canvas, Size size) {
    final shadowPaint = Paint()
      ..color = const Color(0x22000000)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.9), width: size.width * 0.42, height: 18), shadowPaint);

    final bulbPath = Path()
      ..moveTo(size.width * 0.24, size.height * 0.72)
      ..cubicTo(size.width * 0.18, size.height * 0.48, size.width * 0.3, size.height * 0.22, size.width * 0.47, size.height * 0.2)
      ..cubicTo(size.width * 0.63, size.height * 0.18, size.width * 0.78, size.height * 0.34, size.width * 0.76, size.height * 0.54)
      ..cubicTo(size.width * 0.74, size.height * 0.7, size.width * 0.6, size.height * 0.84, size.width * 0.45, size.height * 0.83)
      ..cubicTo(size.width * 0.31, size.height * 0.82, size.width * 0.21, size.height * 0.78, size.width * 0.24, size.height * 0.72)
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
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.5),
        radius: 0.7,
        colors: [Colors.white.withValues(alpha: 0.72), Colors.white.withValues(alpha: 0.0)],
      ).createShader(Rect.fromLTWH(size.width * 0.18, size.height * 0.2, size.width * 0.4, size.height * 0.36));
    canvas.drawOval(Rect.fromLTWH(size.width * 0.22, size.height * 0.28, size.width * 0.26, size.height * 0.22), glossPaint);

    final rootPaint = Paint()..color = const Color(0xFF6D401D)..strokeWidth = 3..strokeCap = StrokeCap.round;
    for (var i = 0; i < 6; i++) {
      final x = size.width * 0.38 + (i * 7);
      canvas.drawLine(Offset(x, size.height * 0.79), Offset(x - 6 + (i % 2) * 4, size.height * 0.84), rootPaint);
    }

    final neckPath = Path()
      ..moveTo(size.width * 0.55, size.height * 0.29)
      ..cubicTo(size.width * 0.63, size.height * 0.14, size.width * 0.78, size.height * 0.18, size.width * 0.76, size.height * 0.34)
      ..cubicTo(size.width * 0.74, size.height * 0.43, size.width * 0.7, size.height * 0.46, size.width * 0.62, size.height * 0.44)
      ..close();
    final neckPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE37AA4), Color(0xFF7A122F)],
      ).createShader(Rect.fromLTWH(size.width * 0.55, size.height * 0.16, size.width * 0.22, size.height * 0.3));
    canvas.drawPath(neckPath, neckPaint);

    final leafPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Color(0xFF2F7A35), Color(0xFF91D65A)],
      ).createShader(Rect.fromLTWH(size.width * 0.32, size.height * 0.05, size.width * 0.28, size.height * 0.25));

    for (final leaf in [
      [Offset(size.width * 0.45, size.height * 0.23), Offset(size.width * 0.39, size.height * 0.05), Offset(size.width * 0.33, size.height * 0.09)],
      [Offset(size.width * 0.5, size.height * 0.2), Offset(size.width * 0.5, size.height * 0.03), Offset(size.width * 0.44, size.height * 0.08)],
      [Offset(size.width * 0.55, size.height * 0.21), Offset(size.width * 0.61, size.height * 0.05), Offset(size.width * 0.57, size.height * 0.11)],
    ]) {
      final path = Path()
        ..moveTo(leaf[0].dx, leaf[0].dy)
        ..quadraticBezierTo(leaf[1].dx, leaf[1].dy, leaf[2].dx, leaf[2].dy)
        ..quadraticBezierTo(leaf[0].dx - 8, leaf[0].dy - 10, leaf[0].dx, leaf[0].dy);
      canvas.drawPath(path, leafPaint);
    }
  }

  void _paintGarlic(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFFF6F7), Color(0xFFD9BCC3), Color(0xFFAE8F9A)],
        focal: Alignment(0, -0.7),
        radius: 0.95,
      ).createShader(Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.5), width: size.width * 0.6, height: size.height * 0.6));

    final cloveRects = [
      Rect.fromCenter(center: Offset(size.width * 0.42, size.height * 0.56), width: size.width * 0.24, height: size.height * 0.42),
      Rect.fromCenter(center: Offset(size.width * 0.56, size.height * 0.56), width: size.width * 0.24, height: size.height * 0.42),
      Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.48), width: size.width * 0.28, height: size.height * 0.5),
    ];
    for (final rect in cloveRects) {
      canvas.drawOval(rect, paint);
    }

    final stem = Paint()..color = const Color(0xFFD9C2A5);
    canvas.drawPath(Path()..moveTo(size.width * 0.48, size.height * 0.16)..quadraticBezierTo(size.width * 0.52, size.height * 0.02, size.width * 0.58, size.height * 0.14)..quadraticBezierTo(size.width * 0.55, size.height * 0.24, size.width * 0.5, size.height * 0.26)..close(), stem);
  }

  void _paintRice(Canvas canvas, Size size) {
    final base = Paint()..shader = const LinearGradient(colors: [Color(0xFFD09A28), Color(0xFFF7DF88)], begin: Alignment.topCenter, end: Alignment.bottomCenter).createShader(Rect.fromLTWH(0, size.height * 0.18, size.width, size.height * 0.82));
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.52, size.width, size.height * 0.48), base);

    final rice = Paint()..shader = const LinearGradient(colors: [Color(0xFFD9A138), Color(0xFFF5D47C)], begin: Alignment.topCenter, end: Alignment.bottomCenter).createShader(Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.58), width: size.width * 0.7, height: size.height * 0.46));
    canvas.drawPath(Path()..moveTo(size.width * 0.16, size.height * 0.76)..quadraticBezierTo(size.width * 0.48, size.height * 0.22, size.width * 0.82, size.height * 0.76)..close(), rice);
  }

  void _paintChili(Canvas canvas, Size size) {
    final pepper = Paint()..shader = const LinearGradient(colors: [Color(0xFFFF8A80), Color(0xFFE10600)], begin: Alignment.topLeft, end: Alignment.bottomRight).createShader(Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.56), width: size.width * 0.64, height: size.height * 0.26));
    canvas.drawPath(Path()..moveTo(size.width * 0.18, size.height * 0.62)..quadraticBezierTo(size.width * 0.34, size.height * 0.42, size.width * 0.6, size.height * 0.52)..quadraticBezierTo(size.width * 0.78, size.height * 0.58, size.width * 0.88, size.height * 0.42)..quadraticBezierTo(size.width * 0.8, size.height * 0.68, size.width * 0.6, size.height * 0.64)..quadraticBezierTo(size.width * 0.38, size.height * 0.82, size.width * 0.18, size.height * 0.62)..close(), pepper);

    final stem = Paint()..color = const Color(0xFF3E8C2E);
    canvas.drawPath(Path()..moveTo(size.width * 0.84, size.height * 0.4)..quadraticBezierTo(size.width * 0.98, size.height * 0.24, size.width * 0.88, size.height * 0.5)..close(), stem);
  }

  void _paintOil(Canvas canvas, Size size) {
    final bottle = RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.56), width: size.width * 0.38, height: size.height * 0.62), const Radius.circular(18));
    canvas.drawRRect(bottle, Paint()..shader = const LinearGradient(colors: [Color(0xFF5A3E00), Color(0xFFE6B000), Color(0xFFFFE27A)], begin: Alignment.topCenter, end: Alignment.bottomCenter).createShader(bottle.outerRect));
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.24), width: size.width * 0.18, height: size.height * 0.1), const Radius.circular(10)), Paint()..color = const Color(0xFF352103));
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(size.width * 0.43, size.height * 0.5), width: size.width * 0.06, height: size.height * 0.44), const Radius.circular(999)), Paint()..color = Colors.white.withValues(alpha: 0.12));
  }

  void _paintChicken(Canvas canvas, Size size) {
    final body = Paint()..shader = const LinearGradient(colors: [Color(0xFFFFE2C4), Color(0xFFF3B79E)], begin: Alignment.topCenter, end: Alignment.bottomCenter).createShader(Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.56), width: size.width * 0.64, height: size.height * 0.5));
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.56), width: size.width * 0.64, height: size.height * 0.46), body);
    canvas.drawCircle(Offset(size.width * 0.72, size.height * 0.58), size.width * 0.1, body);
    canvas.drawCircle(Offset(size.width * 0.28, size.height * 0.58), size.width * 0.08, body);

    final leg = Paint()..color = const Color(0xFFE4AE7E);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(size.width * 0.78, size.height * 0.62), width: size.width * 0.12, height: size.height * 0.08), const Radius.circular(10)), leg);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}