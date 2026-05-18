import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class SinakerTrainingCentersPage extends StatefulWidget {
  const SinakerTrainingCentersPage({super.key});

  @override
  State<SinakerTrainingCentersPage> createState() =>
      _SinakerTrainingCentersPageState();
}

class _SinakerTrainingCentersPageState
    extends State<SinakerTrainingCentersPage> {
  static const _regions = [
    'Jawa Timur',
    'Surabaya',
    'Sumenep',
    'Sidoarjo',
    'Malang',
    'Jember',
    'Madiun',
  ];

  static const _centers = [
    _TrainingCenter(
      name: 'UPT BLK Sumenep',
      address: 'Jl. Gapura No. 1 Desa Parsanga, Kec. Kota, Kab. Sumenep',
      region: 'Sumenep',
      trainingCount: 8,
      artwork: _CenterArtwork.glassHall,
      routeName: RouteNames.homeSinakerTrainingCenterSumenep,
      quickIcons: [
        Icons.groups_2_outlined,
        Icons.computer_outlined,
        Icons.bolt_rounded,
      ],
    ),
    _TrainingCenter(
      name: 'UPT BLK Surabaya',
      address: 'Jl. Dukuh Menanggal III/29, Kec. Gayungan, Surabaya',
      region: 'Surabaya',
      trainingCount: 0,
      artwork: _CenterArtwork.urbanCampus,
      statusText: 'Segera dibuka kembali',
    ),
    _TrainingCenter(
      name: 'UPT BLK Sidoarjo',
      address: 'Jl. Kebaron No.1, Tulangan, Kec. Tulangan, Kab. Sidoarjo',
      region: 'Sidoarjo',
      trainingCount: 12,
      artwork: _CenterArtwork.techLab,
      quickIcons: [Icons.restaurant_menu_rounded, Icons.content_cut_rounded],
    ),
    _TrainingCenter(
      name: 'UPT BLK Malang',
      address: 'Jl. Raya Tlogomas No. 8, Lowokwaru, Kota Malang',
      region: 'Malang',
      trainingCount: 6,
      artwork: _CenterArtwork.urbanCampus,
      quickIcons: [Icons.palette_outlined, Icons.design_services_outlined],
    ),
    _TrainingCenter(
      name: 'UPT BLK Jember',
      address: 'Jl. Letjen Panjaitan No. 77, Sumbersari, Kab. Jember',
      region: 'Jember',
      trainingCount: 9,
      artwork: _CenterArtwork.glassHall,
      quickIcons: [
        Icons.precision_manufacturing_outlined,
        Icons.handyman_outlined,
      ],
    ),
    _TrainingCenter(
      name: 'UPT BLK Madiun',
      address: 'Jl. Basuki Rahmat No. 12, Taman, Kota Madiun',
      region: 'Madiun',
      trainingCount: 5,
      artwork: _CenterArtwork.techLab,
      quickIcons: [Icons.electrical_services_outlined, Icons.memory_rounded],
    ),
    _TrainingCenter(
      name: 'UPT BLK Kediri',
      address: 'Jl. PK Bangsa No. 14, Kota Kediri',
      region: 'Jawa Timur',
      trainingCount: 4,
      artwork: _CenterArtwork.glassHall,
      quickIcons: [Icons.storefront_outlined, Icons.inventory_2_outlined],
    ),
    _TrainingCenter(
      name: 'UPT BLK Banyuwangi',
      address: 'Jl. Adi Sucipto No. 3, Kab. Banyuwangi',
      region: 'Jawa Timur',
      trainingCount: 11,
      artwork: _CenterArtwork.urbanCampus,
      quickIcons: [Icons.hotel_class_outlined, Icons.room_service_outlined],
    ),
    _TrainingCenter(
      name: 'UPT BLK Lamongan',
      address: 'Jl. Veteran No. 18, Kab. Lamongan',
      region: 'Jawa Timur',
      trainingCount: 3,
      artwork: _CenterArtwork.techLab,
      statusText: 'Pendaftaran batch berikutnya segera dibuka',
    ),
    _TrainingCenter(
      name: 'UPT BLK Pasuruan',
      address: 'Jl. Hayam Wuruk No. 5, Kota Pasuruan',
      region: 'Jawa Timur',
      trainingCount: 7,
      artwork: _CenterArtwork.glassHall,
      quickIcons: [
        Icons.local_shipping_outlined,
        Icons.directions_bus_filled_outlined,
      ],
    ),
    _TrainingCenter(
      name: 'UPT BLK Gresik',
      address: 'Jl. Dr. Wahidin SH No. 17, Kab. Gresik',
      region: 'Jawa Timur',
      trainingCount: 2,
      artwork: _CenterArtwork.urbanCampus,
      quickIcons: [Icons.factory_outlined, Icons.engineering_outlined],
    ),
    _TrainingCenter(
      name: 'UPT BLK Probolinggo',
      address: 'Jl. Panglima Sudirman No. 9, Kota Probolinggo',
      region: 'Jawa Timur',
      trainingCount: 1,
      artwork: _CenterArtwork.techLab,
      statusText: 'Sesi orientasi dibuka minggu depan',
    ),
  ];

  late final TextEditingController _searchController;
  String _selectedRegion = _regions.first;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()..addListener(_refresh);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  List<_TrainingCenter> get _visibleCenters {
    final query = _searchController.text.trim().toLowerCase();

    return _centers.where((item) {
      final matchesRegion =
          _selectedRegion == 'Jawa Timur' || item.region == _selectedRegion;
      final matchesQuery =
          query.isEmpty ||
          item.name.toLowerCase().contains(query) ||
          item.address.toLowerCase().contains(query);
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

  Future<void> _pickRegion() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return SafeArea(
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
        );
      },
    );

    if (selected != null && mounted) {
      setState(() {
        _selectedRegion = selected;
      });
    }
  }

  void _openDetail(_TrainingCenter center) {
    if (center.routeName != null) {
      context.pushNamed(center.routeName!);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Detail ${center.name} akan kita lanjutkan berikutnya.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final centers = _visibleCenters;

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
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: Column(
                        children: [
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
                                suffixIconConstraints: const BoxConstraints(
                                  minWidth: 56,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
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
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 18, 24, 30),
                    sliver: SliverList.separated(
                      itemCount: centers.length,
                      itemBuilder: (context, index) => _TrainingCenterCard(
                        center: centers[index],
                        onDetailTap: () => _openDetail(centers[index]),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 22),
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

class _TrainingCenterCard extends StatelessWidget {
  const _TrainingCenterCard({required this.center, required this.onDetailTap});

  final _TrainingCenter center;
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                  child: _CenterArtworkView(artwork: center.artwork),
                ),
                Positioned(
                  top: 18,
                  right: 18,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.welcomeAccent,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '${center.trainingCount} PELATIHAN',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 22, 28, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    center.name,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF383C45),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: Color(0xFF9CA0AA),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          center.address,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7F848D),
                            height: 1.55,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Divider(color: Color(0xFFE9EEF9), height: 1),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: center.statusText != null
                            ? Text(
                                center.statusText!,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF8A8E97),
                                ),
                              )
                            : Wrap(
                                spacing: 8,
                                children: center.quickIcons
                                    .map(
                                      (icon) => Container(
                                        width: 36,
                                        height: 36,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFEAF2FF),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          icon,
                                          size: 18,
                                          color: const Color(0xFF3B4453),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                      ),
                      TextButton(
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
                    ],
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

class _CenterArtworkView extends StatelessWidget {
  const _CenterArtworkView({required this.artwork});

  final _CenterArtwork artwork;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 252,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: switch (artwork) {
            _CenterArtwork.glassHall => const LinearGradient(
              colors: [Color(0xFF2C87D8), Color(0xFF9FD3FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            _CenterArtwork.urbanCampus => const LinearGradient(
              colors: [Color(0xFF88C4F1), Color(0xFFEAF8FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            _CenterArtwork.techLab => const LinearGradient(
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
                    _CenterArtwork.glassHall => 84,
                    _CenterArtwork.urbanCampus => 78,
                    _CenterArtwork.techLab => 72,
                  },
                  color: switch (artwork) {
                    _CenterArtwork.glassHall => const Color(0xFFF6F6F7),
                    _CenterArtwork.urbanCampus => const Color(0xFFCEDAD9),
                    _CenterArtwork.techLab => const Color(0xFFE4EEF0),
                  },
                ),
              ),
            ),
            if (artwork == _CenterArtwork.urbanCampus) ...[
              Positioned(
                left: 0,
                right: 0,
                bottom: 70,
                child: Container(height: 12, color: const Color(0xFF707C7E)),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 56,
                child: Container(height: 14, color: const Color(0xFF606A6D)),
              ),
            ],
            if (artwork == _CenterArtwork.techLab)
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
              _CenterArtwork.glassHall => _glassHallPieces,
              _CenterArtwork.urbanCampus => _urbanCampusPieces,
              _CenterArtwork.techLab => _techLabPieces,
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
        child: Container(width: 4, height: 162, color: const Color(0xFF9FC7DF)),
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

class _TrainingCenter {
  const _TrainingCenter({
    required this.name,
    required this.address,
    required this.region,
    required this.trainingCount,
    required this.artwork,
    this.routeName,
    this.quickIcons = const [],
    this.statusText,
  });

  final String name;
  final String address;
  final String region;
  final int trainingCount;
  final _CenterArtwork artwork;
  final String? routeName;
  final List<IconData> quickIcons;
  final String? statusText;
}

enum _CenterArtwork { glassHall, urbanCampus, techLab }
