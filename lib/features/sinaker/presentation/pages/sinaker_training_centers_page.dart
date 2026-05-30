import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
// ── Sesuaikan path import ini dengan lokasi SinakerService di project Anda ──
import '../../services/sinaker_service.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Model
// ─────────────────────────────────────────────────────────────────────────────

class TrainingCenterModel {
  const TrainingCenterModel({
    required this.id,
    required this.nama,
    required this.kota,
    required this.deskripsi,
    this.artwork = TrainingCenterArtwork.glassHall,
  });

  final int id;
  final String nama;
  final String kota;
  final String deskripsi;
  final TrainingCenterArtwork artwork;

  factory TrainingCenterModel.fromJson(Map<String, dynamic> json, {
    TrainingCenterArtwork artwork = TrainingCenterArtwork.glassHall,
  }) {
    return TrainingCenterModel(
      id: json['id'] as int? ?? 0,
      nama: json['nama'] as String? ?? '',
      kota: json['kota'] as String? ?? '',
      deskripsi: json['deskripsi'] as String? ?? '',
      artwork: artwork,
    );
  }
}

enum TrainingCenterArtwork { glassHall, urbanCampus, techLab }

// ─────────────────────────────────────────────────────────────────────────────
// Page
// ─────────────────────────────────────────────────────────────────────────────

class SinakerTrainingCentersPage extends StatefulWidget {
  const SinakerTrainingCentersPage({super.key});

  @override
  State<SinakerTrainingCentersPage> createState() =>
      _SinakerTrainingCentersPageState();
}

class _SinakerTrainingCentersPageState
    extends State<SinakerTrainingCentersPage> {
  // ── Service ────────────────────────────────────────────────────────────────
  final _sinakerService = SinakerService();

  // ── State ──────────────────────────────────────────────────────────────────
  late Future<List<TrainingCenterModel>> _centersFuture;

  /// Semua data yang sudah dimuat (digunakan untuk filter lokal).
  List<TrainingCenterModel> _allCenters = [];

  List<String> _regions = ['Semua Wilayah'];
  String _selectedRegion = 'Semua Wilayah';

  late final TextEditingController _searchController;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()..addListener(_refresh);
    _centersFuture = _loadCenters();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  // ── Data ───────────────────────────────────────────────────────────────────

  Future<List<TrainingCenterModel>> _loadCenters() async {
    final raw = await _sinakerService.getTrainingCenter();

    // Rotasi artwork agar tiap card punya variasi visual
    const artworks = TrainingCenterArtwork.values;
    final centers = raw.asMap().entries.map((entry) {
      final json = entry.value as Map<String, dynamic>;
      return TrainingCenterModel.fromJson(
        json,
        artwork: artworks[entry.key % artworks.length],
      );
    }).toList();

    // Bangun daftar kota unik dari data
    final kotaSet = <String>{};
    for (final c in centers) {
      if (c.kota.isNotEmpty) kotaSet.add(c.kota);
    }

    if (mounted) {
      setState(() {
        _allCenters = centers;
        _regions = ['Semua Wilayah', ...kotaSet.toList()..sort()];
        if (!_regions.contains(_selectedRegion)) {
          _selectedRegion = _regions.first;
        }
      });
    }

    return centers;
  }

  void _refresh() => setState(() {});

  List<TrainingCenterModel> get _visibleCenters {
    final query = _searchController.text.trim().toLowerCase();

    return _allCenters.where((item) {
      final matchesRegion =
          _selectedRegion == 'Semua Wilayah' || item.kota == _selectedRegion;
      final matchesQuery = query.isEmpty ||
          item.nama.toLowerCase().contains(query) ||
          item.kota.toLowerCase().contains(query);
      return matchesRegion && matchesQuery;
    }).toList();
  }


  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.homeSinakerMain);
  }

  void _openDetail(TrainingCenterModel center) {
    context.pushNamed(
      RouteNames.homeSinakerTrainingList,
      pathParameters: {'centerId': center.id.toString()},
      extra: center.nama,
    );
  }


  Future<void> _pickRegion() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 56,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6D9E1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Pilih Wilayah',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1E2330),
                ),
              ),
              const SizedBox(height: 14),
              ..._regions.map(
                    (region) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    region,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3C414A),
                    ),
                  ),
                  trailing: region == _selectedRegion
                      ? const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.welcomeAccent,
                  )
                      : null,
                  onTap: () => context.pop(region),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (selected != null && mounted) {
      setState(() => _selectedRegion = selected);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── App bar ──────────────────────────────────────────────────────
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
                      'Balai Latihan Kerja',
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
              child: FutureBuilder<List<TrainingCenterModel>>(
                future: _centersFuture,
                builder: (context, snapshot) {
                  // Loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.cloud_off_rounded,
                              size: 56,
                              color: Color(0xFFB0B4BE),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              'Gagal memuat data.\nSilakan coba lagi.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                color: const Color(0xFF7F848D),
                              ),
                            ),
                            const SizedBox(height: 24),
                            FilledButton.icon(
                              onPressed: () => setState(() {
                                _centersFuture = _loadCenters();
                              }),
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Coba Lagi'),
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.welcomeAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final centers = _visibleCenters;

                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                          child: Column(
                            children: [
                              // Search field
                              Material(
                                color: const Color(0xFFF0F0F2),
                                borderRadius: BorderRadius.circular(20),
                                child: TextField(
                                  controller: _searchController,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF2F3136),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Cari nama BLK',
                                    hintStyle: GoogleFonts.plusJakartaSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF66666D),
                                    ),
                                    suffixIcon: const Padding(
                                      padding: EdgeInsets.only(right: 14),
                                      child: Icon(
                                        Icons.search_rounded,
                                        size: 34,
                                        color: Color(0xFF66666D),
                                      ),
                                    ),
                                    suffixIconConstraints:
                                    const BoxConstraints(minWidth: 56),
                                    border: InputBorder.none,
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 22,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              InkWell(
                                onTap: _pickRegion,
                                borderRadius: BorderRadius.circular(18),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 18,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F0F2),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Color(0xFF5E6169),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          _selectedRegion,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF5B5E66),
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 26,
                                        color: Color(0xFF5E6169),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Result count
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Lembaga Tersedia',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF383C45),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${centers.length} BLK Ditemukan',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF383C45),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (centers.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              'Tidak ada BLK yang cocok.',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                color: const Color(0xFF9CA0AA),
                              ),
                            ),
                          ),
                        )
                      else
                        SliverPadding(
                          padding:
                          const EdgeInsets.fromLTRB(24, 18, 24, 30),
                          sliver: SliverList.separated(
                            itemCount: centers.length,
                            itemBuilder: (context, index) =>
                                _TrainingCenterCard(
                                  center: centers[index],
                                  onDetailTap: () =>
                                      _openDetail(centers[index]),
                                ),
                            separatorBuilder: (_, __) =>
                            const SizedBox(height: 22),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class _TrainingCenterCard extends StatelessWidget {
  const _TrainingCenterCard({
    required this.center,
    required this.onDetailTap,
  });

  final TrainingCenterModel center;
  final VoidCallback onDetailTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Artwork header ──────────────────────────────────────────────
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              child: _CenterArtworkView(artwork: center.artwork),
            ),

            // ── Content ─────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 22, 28, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama
                  Text(
                    center.nama,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF383C45),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Kota
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Color(0xFF9CA0AA),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        center.kota,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF9CA0AA),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Deskripsi
                  Text(
                    center.deskripsi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF7F848D),
                      height: 1.55,
                    ),
                  ),

                  const SizedBox(height: 18),
                  const Divider(color: Color(0xFFE9EEF9), height: 1),
                  const SizedBox(height: 10),

                  // CTA
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: onDetailTap,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.welcomeAccent,
                        textStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Lihat Detail'),
                          SizedBox(width: 2),
                          Icon(Icons.chevron_right_rounded, size: 22),
                        ],
                      ),
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

// ─────────────────────────────────────────────────────────────────────────────
// Artwork widget (tidak berubah dari versi statis)
// ─────────────────────────────────────────────────────────────────────────────

class _CenterArtworkView extends StatelessWidget {
  const _CenterArtworkView({required this.artwork});

  final TrainingCenterArtwork artwork;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 252,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: switch (artwork) {
            TrainingCenterArtwork.glassHall => const LinearGradient(
              colors: [Color(0xFF2C87D8), Color(0xFF9FD3FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            TrainingCenterArtwork.urbanCampus => const LinearGradient(
              colors: [Color(0xFF88C4F1), Color(0xFFEAF8FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            TrainingCenterArtwork.techLab => const LinearGradient(
              colors: [Color(0xFF6B96A8), Color(0xFFD8ECF4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          },
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: switch (artwork) {
                    TrainingCenterArtwork.glassHall => 84,
                    TrainingCenterArtwork.urbanCampus => 78,
                    TrainingCenterArtwork.techLab => 72,
                  },
                  color: switch (artwork) {
                    TrainingCenterArtwork.glassHall => const Color(0xFFF6F6F7),
                    TrainingCenterArtwork.urbanCampus =>
                    const Color(0xFFCEDAD9),
                    TrainingCenterArtwork.techLab => const Color(0xFFE4EEF0),
                  },
                ),
              ),
            ),
            if (artwork == TrainingCenterArtwork.urbanCampus) ...[
              Positioned(
                left: 0,
                right: 0,
                bottom: 70,
                child:
                Container(height: 12, color: const Color(0xFF707C7E)),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 56,
                child:
                Container(height: 14, color: const Color(0xFF606A6D)),
              ),
            ],
            if (artwork == TrainingCenterArtwork.techLab)
              Positioned(
                left: 24,
                right: 24,
                top: 24,
                bottom: 42,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0x1FFFFFFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ...switch (artwork) {
              TrainingCenterArtwork.glassHall => _glassHallPieces,
              TrainingCenterArtwork.urbanCampus => _urbanCampusPieces,
              TrainingCenterArtwork.techLab => _techLabPieces,
            },
          ],
        ),
      ),
    );
  }

  static final _glassHallPieces = <Widget>[
    Positioned(
      left: 26,
      right: 26,
      bottom: 58,
      child: Container(
        height: 122,
        decoration: BoxDecoration(
          color: const Color(0xFFEEF6FF),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
    Positioned(
      left: 108,
      right: 70,
      bottom: 58,
      child: Container(
        height: 162,
        decoration: BoxDecoration(
          color: const Color(0xFFD9F0FF),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFFB7D9F2), width: 2),
        ),
      ),
    ),
    Positioned(
      left: 54,
      width: 94,
      bottom: 58,
      child: Container(
        height: 96,
        decoration: BoxDecoration(
          color: const Color(0xFFF7FCFF),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFFCFE6F7), width: 2),
        ),
      ),
    ),
    for (final x in [132.0, 154.0, 176.0, 198.0, 220.0, 242.0])
      Positioned(
        left: x,
        bottom: 58,
        child:
        Container(width: 4, height: 162, color: const Color(0xFF9FC7DF)),
      ),
  ];

  static final _urbanCampusPieces = <Widget>[
    Positioned(
      left: 26,
      right: 26,
      bottom: 70,
      child: Container(
        height: 124,
        decoration: BoxDecoration(
          color: const Color(0xFFC6D6DA),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
    Positioned(
      left: 168,
      right: 40,
      bottom: 70,
      child: Container(
        height: 154,
        decoration: BoxDecoration(
          color: const Color(0xFFAABDC3),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    ),
    Positioned(
      left: 82,
      right: 208,
      bottom: 70,
      child: Container(
        height: 148,
        decoration: BoxDecoration(
          color: const Color(0xFFB3C5CB),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    ),
    for (final x in [38.0, 122.0, 228.0, 284.0])
      Positioned(
        left: x,
        bottom: 70,
        child: Container(
          width: 6,
          height: 164,
          decoration: BoxDecoration(
            color: const Color(0xFF8AA2A9),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    Positioned(
      left: 18,
      width: 10,
      bottom: 72,
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFF6EA86C),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
    Positioned(
      right: 18,
      width: 10,
      bottom: 72,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF6EA86C),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
  ];

  static final _techLabPieces = <Widget>[
    Positioned(
      left: 34,
      right: 34,
      bottom: 68,
      child: Container(
        height: 116,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F4F7),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
    for (final x in [58.0, 116.0, 174.0, 232.0])
      Positioned(
        left: x,
        bottom: 96,
        child: Container(
          width: 24,
          height: 88,
          decoration: BoxDecoration(
            color: const Color(0xFFB8D5DE),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    for (final dx in [44.0, 136.0, 230.0])
      Positioned(
        left: dx,
        bottom: 70,
        child: Container(
          width: 54,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFFC9E2E9),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
  ];
}