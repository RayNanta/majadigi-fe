import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../services/sinaker_service.dart';

class SinakerTrainingListPage extends StatefulWidget {
  const SinakerTrainingListPage({super.key});

  @override
  State<SinakerTrainingListPage> createState() =>
      _SinakerTrainingListPageState();
}

class Training {
  final int id;
  final String namaPelatihan;
  final String deskripsi;
  final int trainingCenterId;
  final DateTime tanggalMulai;
  final DateTime tanggalSelesai;

  Training({
    required this.id,
    required this.namaPelatihan,
    required this.deskripsi,
    required this.trainingCenterId,
    required this.tanggalMulai,
    required this.tanggalSelesai,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      id: json['id'],
      namaPelatihan: json['nama_pelatihan'],
      deskripsi: json['deskripsi'] ?? '',
      trainingCenterId: json['training_center_id'],
      tanggalMulai: DateTime.parse(json['tanggal_mulai']),
      tanggalSelesai: DateTime.parse(json['tanggal_selesai']),
    );
  }
}

class TrainingCenter {
  final int id;
  final String nama;

  TrainingCenter({required this.id, required this.nama});

  factory TrainingCenter.fromJson(Map<String, dynamic> json) {
    return TrainingCenter(id: json['id'], nama: json['nama']);
  }
}

class _SinakerTrainingListPageState extends State<SinakerTrainingListPage> {
  final _service = SinakerService();

  List<Map<String, dynamic>> _centers = [];
  Map<int, String> _centerMap = {};

  List<Training> _trainings = [];
  bool _loading = true;

  late final TextEditingController _searchController;
  Map<String, dynamic>? _selectedCenter;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()..addListener(_refresh);
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final trainingsRes = await _service.getTrainings();
      final centersRes = await _service.getTrainingCenter();

      final centerMap = {
        for (var c in centersRes) c['id'] as int: c['nama'] as String,
      };

      setState(() {
        _trainings = trainingsRes;
        _centers = centersRes;
        _centerMap = centerMap;

        _selectedCenter = null;
        _loading = false;
      });
    } catch (e) {
      debugPrint("ERROR LOAD: $e");
      setState(() => _loading = false);
    }
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

  _TrainingItem _mapToItem(Training t) {
    return _TrainingItem(
      trainingId: t.id,
      routeName: RouteNames.homeSinakerTrainingRegistration,
      category: 'TRAINING',
      title: t.namaPelatihan,
      dateRange:
          '${t.tanggalMulai.day} ${_month(t.tanggalMulai.month)} ${t.tanggalMulai.year}'
          ' - '
          '${t.tanggalSelesai.day} ${_month(t.tanggalSelesai.month)} ${t.tanggalSelesai.year}',
      location: _centerMap[t.trainingCenterId] ?? 'Unknown',
      artwork: _TrainingArtwork.barista,
      tagColor: const Color(0xFFD9D6FF),
      tagTextColor: const Color(0xFF5C56D8),
    );
  }

  String _month(int m) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return months[m];
  }

  String _locationName(int id) {
    switch (id) {
      case 1:
        return 'UPT BLK Surabaya';
      case 2:
        return 'UPT BLK Malang';
      case 3:
        return 'UPT BLK Sumenep';
      default:
        return 'Jawa Timur';
    }
  }

  List<_TrainingItem> get _visibleTrainings {
    final query = _searchController.text.trim().toLowerCase();

    final items = _trainings.map(_mapToItem).toList();

    return items.where((item) {
      final matchesLocation =
          _selectedCenter == null || item.location == _selectedCenter!['nama'];

      final matchesQuery =
          query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.location.toLowerCase().contains(query);

      return matchesLocation && matchesQuery;
    }).toList();
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.homeSinakerMain);
  }

  void _pickLocation() async {
    final selected = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      backgroundColor: context.appSurfaceColor,
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
                      color: context.appHandleColor,
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
                    color: context.appThemedTextColor(const Color(0xFF1E2330)),
                  ),
                ),
                const SizedBox(height: 14),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Semua Training',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: context.appThemedTextColor(
                        const Color(0xFF3C414A),
                      ),
                    ),
                  ),
                  trailing: _selectedCenter == null
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.welcomeAccent,
                        )
                      : null,
                  onTap: () => context.pop({'id': -1, 'nama': 'Semua'}),
                ),
                ..._centers.map(
                  (center) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      center['nama']?.toString() ?? '-',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: context.appThemedTextColor(
                          const Color(0xFF3C414A),
                        ),
                      ),
                    ),
                    trailing: _selectedCenter?['id'] == center['id']
                        ? const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.welcomeAccent,
                          )
                        : null,
                    onTap: () => context.pop(center),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedCenter = selected['id'] == -1 ? null : selected;
      });
    }
  }

  void _registerTraining(_TrainingItem item) {
    context.pushNamed(
      RouteNames.homeSinakerTrainingRegistration,
      extra: {'training_id': item.trainingId, 'training_name': item.title},
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Pendaftaran ${item.title}')));
  }

  @override
  Widget build(BuildContext context) {
    final trainings = _visibleTrainings;

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
                    onPressed: _handleBack,
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Daftar Pelatihan Kerja',
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
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                            child: Column(
                              children: [
                                Material(
                                  color: context.isDarkMode
                                      ? context.appSubtleSurfaceColor
                                      : const Color(0xFFF0F0F2),
                                  borderRadius: BorderRadius.circular(20),
                                  child: TextField(
                                    controller: _searchController,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: context.appThemedTextColor(
                                        const Color(0xFF2F3136),
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Cari Pelatihan',
                                      hintStyle: GoogleFonts.plusJakartaSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: context.appThemedMutedTextColor(
                                          const Color(0xFF66666D),
                                        ),
                                      ),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 14,
                                        ),
                                        child: Icon(
                                          Icons.search_rounded,
                                          size: 34,
                                          color: context
                                              .appThemedMutedTextColor(
                                                const Color(0xFF66666D),
                                              ),
                                        ),
                                      ),
                                      suffixIconConstraints:
                                          const BoxConstraints(minWidth: 56),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 18,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: AppColors.welcomeAccent,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Material(
                                  color: context.isDarkMode
                                      ? context.appSubtleSurfaceColor
                                      : const Color(0xFFF0F0F2),
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    onTap: _pickLocation,
                                    child: Padding(
                                      padding: const EdgeInsets.all(18),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: context
                                                .appThemedMutedTextColor(
                                                  const Color(0xFF5D6168),
                                                ),
                                            size: 24,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              _selectedCenter?['nama']
                                                      ?.toString() ??
                                                  'Semua',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: context
                                                        .appThemedTextColor(
                                                          const Color(
                                                            0xFF5D6168,
                                                          ),
                                                        ),
                                                  ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: context
                                                .appThemedMutedTextColor(
                                                  const Color(0xFF5D6168),
                                                ),
                                            size: 28,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        if (trainings.isEmpty)
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 36,
                                ),
                                child: Text(
                                  'Belum ada pelatihan yang cocok dengan pencarian ini.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: context.appMutedTextColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(24, 22, 24, 28),
                            sliver: SliverList.separated(
                              itemCount: trainings.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 28),
                              itemBuilder: (context, index) {
                                final item = trainings[index];
                                return _TrainingCard(
                                  item: item,
                                  onRegister: () => _registerTraining(item),
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

class _TrainingCard extends StatelessWidget {
  const _TrainingCard({required this.item, required this.onRegister});

  final _TrainingItem item;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            child: SizedBox(
              height: 228,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _TrainingArtworkPainter(item.artwork),
                    ),
                  ),
                  if (item.isPopular)
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'TERPOPULER',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.welcomeAccent,
                            letterSpacing: 0.35,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: item.tagColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    item.category,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: item.tagTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  item.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: context.appThemedTextColor(const Color(0xFF30355F)),
                    height: 1.26,
                  ),
                ),
                const SizedBox(height: 16),
                _MetaRow(
                  icon: Icons.calendar_today_outlined,
                  label: item.dateRange,
                ),
                const SizedBox(height: 12),
                _MetaRow(
                  icon: Icons.location_on_outlined,
                  label: item.location,
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: FilledButton(
                    onPressed: onRegister,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.welcomeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(29),
                      ),
                      textStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: const Text('Daftar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 22,
          color: context.appThemedMutedTextColor(const Color(0xFF7D83AF)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: context.appThemedMutedTextColor(const Color(0xFF7D83AF)),
            ),
          ),
        ),
      ],
    );
  }
}

class _TrainingItem {
  const _TrainingItem({
    required this.trainingId,
    this.routeName,
    required this.category,
    required this.title,
    required this.dateRange,
    required this.location,
    required this.artwork,
    required this.tagColor,
    required this.tagTextColor,
    this.isPopular = false,
  });

  final int trainingId;
  final String? routeName;
  final String category;
  final String title;
  final String dateRange;
  final String location;
  final _TrainingArtwork artwork;
  final Color tagColor;
  final Color tagTextColor;
  final bool isPopular;
}

enum _TrainingArtwork { barista, design, solar }

class _TrainingArtworkPainter extends CustomPainter {
  const _TrainingArtworkPainter(this.artwork);

  final _TrainingArtwork artwork;

  @override
  void paint(Canvas canvas, Size size) {
    switch (artwork) {
      case _TrainingArtwork.barista:
        _paintBarista(canvas, size);
        return;
      case _TrainingArtwork.design:
        _paintDesign(canvas, size);
        return;
      case _TrainingArtwork.solar:
        _paintSolar(canvas, size);
        return;
    }
  }

  void _paintBarista(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF6B4728), Color(0xFF1F1A19)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    final warmLight = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.65, -0.2),
        radius: 0.95,
        colors: [
          const Color(0xFFFFD089).withValues(alpha: 0.72),
          Colors.transparent,
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, warmLight);

    final machinePaint = Paint()..color = const Color(0xFFB7B9BD);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.54,
          size.height * 0.06,
          size.width * 0.3,
          size.height * 0.52,
        ),
        const Radius.circular(18),
      ),
      machinePaint,
    );

    final pipePaint = Paint()
      ..color = const Color(0xFF222326)
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.12, size.height * 0.26),
      Offset(size.width * 0.62, size.height * 0.26),
      pipePaint,
    );

    final spoutPaint = Paint()
      ..color = const Color(0xFF42464C)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.63, size.height * 0.22),
      Offset(size.width * 0.63, size.height * 0.4),
      spoutPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.61, size.height * 0.4),
      Offset(size.width * 0.66, size.height * 0.4),
      spoutPaint,
    );

    final counterPaint = Paint()..color = const Color(0xFFC4CACF);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.76, size.width, size.height * 0.24),
      counterPaint,
    );

    final cupBodyPaint = Paint()
      ..shader =
          const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD8DBDF), Color(0xFF8D949E)],
          ).createShader(
            Rect.fromLTWH(
              size.width * 0.56,
              size.height * 0.45,
              size.width * 0.1,
              size.height * 0.22,
            ),
          );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.56,
          size.height * 0.45,
          size.width * 0.12,
          size.height * 0.24,
        ),
        const Radius.circular(8),
      ),
      cupBodyPaint,
    );

    final handlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = const Color(0xFFC8CDD3);
    canvas.drawArc(
      Rect.fromLTWH(
        size.width * 0.65,
        size.height * 0.49,
        size.width * 0.07,
        size.height * 0.12,
      ),
      -1.2,
      2.7,
      false,
      handlePaint,
    );
  }

  void _paintDesign(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFEDF3F7);
    canvas.drawRect(Offset.zero & size, bg);

    final deskPaint = Paint()..color = const Color(0xFFC39E74);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.78, size.width, size.height * 0.22),
      deskPaint,
    );

    final monitorPaint = Paint()..color = const Color(0xFF1E293B);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.12,
          size.height * 0.14,
          size.width * 0.46,
          size.height * 0.45,
        ),
        const Radius.circular(10),
      ),
      monitorPaint,
    );

    final screenPaint = Paint()
      ..shader =
          const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF083344), Color(0xFF172554)],
          ).createShader(
            Rect.fromLTWH(
              size.width * 0.15,
              size.height * 0.17,
              size.width * 0.4,
              size.height * 0.39,
            ),
          );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.15,
        size.height * 0.17,
        size.width * 0.4,
        size.height * 0.39,
      ),
      screenPaint,
    );

    final petalPaint = Paint()
      ..shader =
          const RadialGradient(
            colors: [Color(0xFFFEC7A1), Color(0xFFE76F51)],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.34, size.height * 0.28),
              radius: 46,
            ),
          );
    for (var i = 0; i < 8; i++) {
      final angle = i * 0.79;
      canvas.save();
      canvas.translate(size.width * 0.34, size.height * 0.28);
      canvas.rotate(angle);
      canvas.drawOval(
        Rect.fromCenter(center: const Offset(0, -26), width: 28, height: 66),
        petalPaint,
      );
      canvas.restore();
    }
    canvas.drawCircle(
      Offset(size.width * 0.34, size.height * 0.28),
      18,
      Paint()..color = const Color(0xFFD97706),
    );

    final tabletPaint = Paint()..color = const Color(0xFF111827);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.48,
          size.height * 0.5,
          size.width * 0.22,
          size.height * 0.19,
        ),
        const Radius.circular(12),
      ),
      tabletPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.5,
          size.height * 0.52,
          size.width * 0.18,
          size.height * 0.15,
        ),
        const Radius.circular(10),
      ),
      Paint()..color = const Color(0xFF0EA5E9),
    );

    final penPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.54, size.height * 0.48),
      Offset(size.width * 0.66, size.height * 0.68),
      penPaint,
    );
  }

  void _paintSolar(Canvas canvas, Size size) {
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF57A7E8), Color(0xFFF7D692)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, skyPaint);

    canvas.drawCircle(
      Offset(size.width * 0.84, size.height * 0.2),
      38,
      Paint()..color = const Color(0xFFFFF3B0),
    );

    final panelPaint = Paint()
      ..shader =
          const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1D4ED8), Color(0xFF0F172A)],
          ).createShader(
            Rect.fromLTWH(0, size.height * 0.6, size.width, size.height * 0.4),
          );
    final panelPath = Path()
      ..moveTo(0, size.height * 0.7)
      ..lineTo(size.width, size.height * 0.62)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(panelPath, panelPaint);

    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..strokeWidth = 1.4;
    for (var i = 0; i < 6; i++) {
      final dx = size.width * 0.12 + (i * size.width * 0.14);
      canvas.drawLine(
        Offset(dx, size.height * 0.68),
        Offset(dx + 24, size.height),
        linePaint,
      );
    }
    for (var i = 0; i < 5; i++) {
      final dy = size.height * 0.72 + (i * size.height * 0.06);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy - 12), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TrainingArtworkPainter oldDelegate) {
    return oldDelegate.artwork != artwork;
  }
}
