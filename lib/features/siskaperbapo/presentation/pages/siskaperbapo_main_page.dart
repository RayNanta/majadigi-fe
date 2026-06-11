import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:majadigi_mobile/features/siskaperbapo/services/siskaperbapo_service.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
// 1. IMPORT SERVICE KAMU DI SINI

class SiskaperbapoMainPage extends StatefulWidget {
  const SiskaperbapoMainPage({super.key});

  @override
  State<SiskaperbapoMainPage> createState() => _SiskaperbapoMainPageState();
}

class _SiskaperbapoMainPageState extends State<SiskaperbapoMainPage> {
  final SiskaperbapoService _siskaperbapoService = SiskaperbapoService();

  static const _categories = [
    'Semua',
    'Bumbu Dapur',
    'Sembako',
    'Protein Hewani',
    'Minyak',
  ];

  // Data master dari API akan disimpan di sini
  List<_CommodityItem> _allTemplatesAndItems = [];
  bool _isLoading = true;
  String _errorMessage = '';

  late final TextEditingController _searchController;
  String _selectedCategory = _categories.first;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()..addListener(_refreshState);
    _loadHargaPokokData();
  }

  // Fungsi mengambil data secara asinkron dari service
  Future<void> _loadHargaPokokData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final rawData = await _siskaperbapoService.getHargaPokok();

      setState(() {
        _allTemplatesAndItems = rawData.map((json) => _CommodityItem.fromJson(json)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat data pangan: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refreshState)
      ..dispose();
    super.dispose();
  }

  void _refreshState() {
    setState(() {});
  }

  // Logika pencarian dan filter kategori lokal tetap dipertahankan secara reaktif
  List<_CommodityItem> get _visibleItems {
    final query = _searchController.text.trim().toLowerCase();

    return _allTemplatesAndItems.where((item) {
      final matchesCategory =
          _selectedCategory == 'Semua' || item.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesQuery =
          query.isEmpty ||
              item.title.toLowerCase().contains(query) ||
              item.category.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.homeSiskaperbapo);
  }

  void _showCommodityDetail(_CommodityItem item) {
    context.pushNamed(
      RouteNames.homeSiskaperbapoBawangMerah,
      extra: item,
    );
  }


@override
Widget build(BuildContext context) {
  final items = _visibleItems;

  return Scaffold(
    backgroundColor: const Color(0xFFF7F9FF),
    body: SafeArea(
      bottom: false,
      child: Column(
        children: [
          // Top Header Bar
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

          // Konten Utama Berdasarkan State API
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
                    child: Column(
                      children: [
                        // Search Field
                        Material(
                          color: const Color(0xFFF0F0F2),
                          borderRadius: BorderRadius.circular(22),
                          child: TextField(
                            controller: _searchController,
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
                                color: const Color(0xFF66666D),
                              ),
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(right: 14),
                                child: Icon(
                                  Icons.search_rounded,
                                  size: 36,
                                  color: Color(0xFF66666D),
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: 56,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
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
                        ),
                        const SizedBox(height: 18),

                        // Category Selector List
                        SizedBox(
                          height: 54,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _categories.length,
                            separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final category = _categories[index];
                              final isSelected =
                                  category == _selectedCategory;

                              return _CategoryChip(
                                label: category,
                                isSelected: isSelected,
                                onTap: () {
                                  setState(() {
                                    _selectedCategory = category;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Menangani Loading, Error, Kosong, atau Menampilkan Data Grid
                if (_isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.welcomeAccent),
                      ),
                    ),
                  )
                else if (_errorMessage.isNotEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_errorMessage, textAlign: TextAlign.center),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: _loadHargaPokokData,
                              child: const Text('Coba Lagi'),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                else if (items.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            'Komoditas untuk pencarian ini belum tersedia.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 6, 24, 28),
                      sliver: SliverGrid.builder(
                        itemCount: items.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 18,
                          mainAxisExtent: 348,
                        ),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return _CommodityCard(
                            item: item,
                            onTap: () => _showCommodityDetail(item),
                          );
                        },
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.welcomeAccent
                : const Color(0xFFE7E7EA),
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF3F434A),
            ),
          ),
        ),
      ),
    );
  }
}

// 2. MODIFIKASI MODEL AGAR BERSIFAT DINAMIS DARI JSON BACKEND
class _CommodityItem {
  const _CommodityItem({
    required this.id,
    required this.title,
    required this.unit,
    required this.price,
    required this.category,
    required this.trend,
    required this.artwork,
  });
  final int id;
  final String title;
  final String unit;
  final String price;
  final String category;
  final _CommodityTrend trend;
  final _CommodityArtwork artwork;

  // Factory constructor untuk mapping data dari skema Laravel database db_majadigi kamu
  factory _CommodityItem.fromJson(Map<String, dynamic> json) {
    final bahanPokok =
    Map<String, dynamic>.from(json['bahan_pokok'] ?? {});

    final nama = bahanPokok['nama_bahan'] ?? '';

    _CommodityTrend trendValue = _CommodityTrend.down;

    if (json['tren'] == 'naik') {
      trendValue = _CommodityTrend.up;
    }

    _CommodityArtwork artworkValue = _CommodityArtwork.rice;

    final namaLower = nama.toLowerCase();

    if (namaLower.contains('bawang merah')) {
      artworkValue = _CommodityArtwork.redOnion;
    } else if (namaLower.contains('bawang putih')) {
      artworkValue = _CommodityArtwork.garlic;
    } else if (namaLower.contains('cabai') ||
        namaLower.contains('cabe')) {
      artworkValue = _CommodityArtwork.chili;
    } else if (namaLower.contains('minyak')) {
      artworkValue = _CommodityArtwork.oil;
    } else if (namaLower.contains('ayam') ||
        namaLower.contains('daging')) {
      artworkValue = _CommodityArtwork.chicken;
    }

    final rawHarga = json['harga_sekarang'] ?? 0;

    final formattedPrice =
        'Rp ${(double.tryParse(rawHarga.toString()) ?? 0).toStringAsFixed(0)}';

    return _CommodityItem(
      id: json['id'] ?? 0,
      title: nama,
      unit: bahanPokok['satuan'] ?? '',
      price: formattedPrice,
      category: 'Sembako',
      trend: trendValue,
      artwork: artworkValue,
    );
  }
}

enum _CommodityTrend { up, down }

enum _CommodityArtwork { redOnion, garlic, rice, chili, oil, chicken }

class _CommodityCard extends StatelessWidget {
  const _CommodityCard({required this.item, required this.onTap});

  final _CommodityItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isUp = item.trend == _CommodityTrend.up;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 196,
                  color: switch (item.artwork) {
                    _CommodityArtwork.redOnion => const Color(0xFFF7F7F4),
                    _CommodityArtwork.garlic => const Color(0xFF1C1C1E),
                    _CommodityArtwork.rice => const Color(0xFFF8E7B6),
                    _CommodityArtwork.chili => const Color(0xFFF8F8F6),
                    _CommodityArtwork.oil => const Color(0xFF19160E),
                    _CommodityArtwork.chicken => const Color(0xFF1A2630),
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        top: 12,
                        right: 12,
                        child: _TrendBadge(isUp: isUp),
                      ),
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _CommodityArtworkPainter(item.artwork),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                item.title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF44484F),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.unit,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.price,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.welcomeAccent,
                      ),
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFDDEBFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      size: 28,
                      color: AppColors.welcomeAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrendBadge extends StatelessWidget {
  const _TrendBadge({required this.isUp});

  final bool isUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 28,
      decoration: BoxDecoration(
        color: isUp ? const Color(0xFFFFE3EE) : const Color(0xFFEAF2FF),
        borderRadius: BorderRadius.circular(999),
      ),
      alignment: Alignment.center,
      child: Icon(
        isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded,
        size: 20,
        color: isUp ? const Color(0xFFFF3B86) : AppColors.welcomeAccent,
      ),
    );
  }
}

// Custom Painter `_CommodityArtworkPainter` tetap dipertahankan persis di bawah sini tanpa perubahan demi estetika ilustrasi vektor lokal kamu...
class _CommodityArtworkPainter extends CustomPainter {
  const _CommodityArtworkPainter(this.artwork);

  final _CommodityArtwork artwork;

  @override
  void paint(Canvas canvas, Size size) {
    switch (artwork) {
      case _CommodityArtwork.redOnion:
        _paintRedOnion(canvas, size);
        return;
      case _CommodityArtwork.garlic:
        _paintGarlic(canvas, size);
        return;
      case _CommodityArtwork.rice:
        _paintRice(canvas, size);
        return;
      case _CommodityArtwork.chili:
        _paintChili(canvas, size);
        return;
      case _CommodityArtwork.oil:
        _paintOil(canvas, size);
        return;
      case _CommodityArtwork.chicken:
        _paintChicken(canvas, size);
        return;
    }
  }

  void _paintRedOnion(Canvas canvas, Size size) {
    final shadow = Paint()
      ..color = Colors.black.withValues(alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.45, size.height * 0.82),
        width: size.width * 0.56,
        height: 22,
      ),
      shadow,
    );

    final body = Paint()
      ..shader =
      const RadialGradient(
        colors: [Color(0xFFFFC4E0), Color(0xFF66102B), Color(0xFF2B0011)],
        focal: Alignment(-0.2, -0.5),
        radius: 0.9,
      ).createShader(
        Rect.fromCenter(
          center: Offset(size.width * 0.45, size.height * 0.52),
          width: size.width * 0.62,
          height: size.height * 0.7,
        ),
      );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.45, size.height * 0.52),
        width: size.width * 0.62,
        height: size.height * 0.68,
      ),
      body,
    );

    final neckPath = Path()
      ..moveTo(size.width * 0.43, size.height * 0.18)
      ..quadraticBezierTo(
        size.width * 0.46,
        size.height * 0.08,
        size.width * 0.54,
        size.height * 0.16,
      )
      ..quadraticBezierTo(
        size.width * 0.58,
        size.height * 0.26,
        size.width * 0.49,
        size.height * 0.34,
      )
      ..quadraticBezierTo(
        size.width * 0.42,
        size.height * 0.28,
        size.width * 0.43,
        size.height * 0.18,
      )
      ..close();
    canvas.drawPath(neckPath, Paint()..color = const Color(0xFF7E1A38));

    final leaf = Paint()..color = const Color(0xFF4C8A37);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.35, size.height * 0.18)
        ..quadraticBezierTo(
          size.width * 0.26,
          size.height * 0.04,
          size.width * 0.3,
          size.height * 0.22,

        )
        ..close(),
      leaf,
    );
  }

  void _paintGarlic(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader =
      const RadialGradient(
        colors: [Color(0xFFFFF6F7), Color(0xFFD9BCC3), Color(0xFFAE8F9A)],
        focal: Alignment(0, -0.7),
        radius: 0.95,
      ).createShader(
        Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.5),
          width: size.width * 0.6,
          height: size.height * 0.6,
        ),
      );

    final cloveRects = [
      Rect.fromCenter(
        center: Offset(size.width * 0.42, size.height * 0.56),
        width: size.width * 0.24,
        height: size.height * 0.42,
      ),
      Rect.fromCenter(
        center: Offset(size.width * 0.56, size.height * 0.56),
        width: size.width * 0.24,
        height: size.height * 0.42,
      ),
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.48),
        width: size.width * 0.28,
        height: size.height * 0.5,
      ),
    ];

    for (final rect in cloveRects) {
      canvas.drawOval(rect, paint);
    }

    final stem = Paint()..color = const Color(0xFFD9C2A5);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.48, size.height * 0.16)
        ..quadraticBezierTo(
          size.width * 0.52,
          size.height * 0.02,
          size.width * 0.58,
          size.height * 0.14,
        )
        ..quadraticBezierTo(
          size.width * 0.55,
          size.height * 0.24,
          size.width * 0.5,
          size.height * 0.26,
        )
        ..close(),
      stem,
    );
  }

  void _paintRice(Canvas canvas, Size size) {
    final base = Paint()
      ..shader =
      const LinearGradient(
        colors: [Color(0xFFD09A28), Color(0xFFF7DF88)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(
        Rect.fromLTWH(
          0,
          size.height * 0.18,
          size.width,
          size.height * 0.82,
        ),
      );
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.52, size.width, size.height * 0.48),
      base,
    );

    final rice = Paint()
      ..shader =
      const LinearGradient(
        colors: [Color(0xFFD9A138), Color(0xFFF5D47C)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(
        Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.58),
          width: size.width * 0.7,
          height: size.height * 0.46,
        ),
      );
    final mound = Path()
      ..moveTo(size.width * 0.16, size.height * 0.76)
      ..quadraticBezierTo(
        size.width * 0.48,
        size.height * 0.22,
        size.width * 0.82,
        size.height * 0.76,
      )
      ..close();
    canvas.drawPath(mound, rice);
  }

  void _paintChili(Canvas canvas, Size size) {
    final pepper = Paint()
      ..shader =
      const LinearGradient(
        colors: [Color(0xFFFF8A80), Color(0xFFE10600)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(
        Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.56),
          width: size.width * 0.64,
          height: size.height * 0.26,
        ),
      );

    final path = Path()
      ..moveTo(size.width * 0.18, size.height * 0.62)
      ..quadraticBezierTo(
        size.width * 0.34,
        size.height * 0.42,
        size.width * 0.6,
        size.height * 0.52,
      )
      ..quadraticBezierTo(
        size.width * 0.78,
        size.height * 0.58,
        size.width * 0.88,
        size.height * 0.42,
      )
      ..quadraticBezierTo(
        size.width * 0.8,
        size.height * 0.68,
        size.width * 0.6,
        size.height * 0.64,
      )
      ..quadraticBezierTo(
        size.width * 0.38,
        size.height * 0.82,
        size.width * 0.18,
        size.height * 0.62,
      )
      ..close();
    canvas.drawPath(path, pepper);

    final stem = Paint()..color = const Color(0xFF3E8C2E);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.84, size.height * 0.4)
        ..quadraticBezierTo(
          size.width * 0.98,
          size.height * 0.24,
          size.width * 0.88,
          size.height * 0.5,
        )
        ..close(),
      stem,
    );
  }

  void _paintOil(Canvas canvas, Size size) {
    final bottle = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.56),
        width: size.width * 0.38,
        height: size.height * 0.62,
      ),
      const Radius.circular(18),
    );
    canvas.drawRRect(
      bottle,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFF5A3E00), Color(0xFFE6B000), Color(0xFFFFE27A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bottle.outerRect),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.24),
          width: size.width * 0.18,
          height: size.height * 0.1,
        ),
        const Radius.circular(10),
      ),
      Paint()..color = const Color(0xFF352103),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * 0.43, size.height * 0.5),
          width: size.width * 0.06,
          height: size.height * 0.44,
        ),
        const Radius.circular(999),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.12),
    );
  }

  void _paintChicken(Canvas canvas, Size size) {
    final body = Paint()
      ..shader =
      const LinearGradient(
        colors: [Color(0xFFFFE2C4), Color(0xFFF3B79E)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(
        Rect.fromCenter(
          center: Offset(size.width * 0.5, size.height * 0.56),
          width: size.width * 0.64,
          height: size.height * 0.5,
        ),
      );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.56),
        width: size.width * 0.64,
        height: size.height * 0.46,
      ),
      body,
    );
    canvas.drawCircle(
      Offset(size.width * 0.72, size.height * 0.58),
      size.width * 0.1,
      body,
    );
    canvas.drawCircle(
      Offset(size.width * 0.28, size.height * 0.58),
      size.width * 0.08,
      body,
    );

    final leg = Paint()..color = const Color(0xFFE4AE7E);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * 0.78, size.height * 0.62),
          width: size.width * 0.12,
          height: size.height * 0.08,
        ),
        const Radius.circular(10),
      ),
      leg,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}