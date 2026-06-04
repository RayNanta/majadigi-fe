import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class SinakerTrainingCenterSumenepPage extends StatefulWidget {
  const SinakerTrainingCenterSumenepPage({super.key});

  @override
  State<SinakerTrainingCenterSumenepPage> createState() =>
      _SinakerTrainingCenterSumenepPageState();
}

class _SinakerTrainingCenterSumenepPageState
    extends State<SinakerTrainingCenterSumenepPage> {
  static const _trainings = [
    _CenterTraining(
      category: 'PARIWISATA',
      title: 'Pelatihan Barista Profesional & Manajemen Coffee Shop',
      dateRange: '2 Mar 2026 - 26 Mar 2026',
      location: 'UPT BLK Surabaya',
      artwork: _TrainingArtwork.barista,
      tagColor: Color(0xFFD9D6FF),
      tagTextColor: Color(0xFF5C56D8),
      isPopular: true,
    ),
    _CenterTraining(
      category: 'KREATIF',
      title: 'Graphic Design & UI/UX Foundations',
      dateRange: '10 Mar 2026 - 05 Apr 2026',
      location: 'UPT BLK Malang',
      artwork: _TrainingArtwork.design,
      tagColor: Color(0xFFFCE1FF),
      tagTextColor: Color(0xFFB353C2),
    ),
    _CenterTraining(
      category: 'TEKNIK ENERGI',
      title: 'Pemasangan & Pemeliharaan Panel Surya (PLTS)',
      dateRange: '15 Mar 2026 - 20 Apr 2026',
      location: 'UPT BLK Sumenep',
      artwork: _TrainingArtwork.solar,
      tagColor: Color(0xFFDDF8E6),
      tagTextColor: Color(0xFF319C59),
    ),
  ];

  late final TextEditingController _searchController;

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

  List<_CenterTraining> get _visibleTrainings {
    final query = _searchController.text.trim().toLowerCase();
    return _trainings.where((item) {
      if (query.isEmpty) return true;
      return item.title.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query) ||
          item.location.toLowerCase().contains(query);
    }).toList();
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeSinakerTrainingCenters);
  }

  void _openRegistration() {
    context.pushNamed(RouteNames.homeSinakerTrainingRegistration);
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
                      'UPT BLK Sumenep',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                hintText: 'Cari pelatihan kerja',
                                hintStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: context.appThemedMutedTextColor(
                                    const Color(0xFF66666D),
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 14),
                                  child: Icon(
                                    Icons.search_rounded,
                                    size: 34,
                                    color: context.appThemedMutedTextColor(
                                      const Color(0xFF66666D),
                                    ),
                                  ),
                                ),
                                suffixIconConstraints: const BoxConstraints(
                                  minWidth: 56,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Jl. Dukuh Menanggal III no. 29, Surabaya,\nJawa Timur',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: context.appThemedMutedTextColor(
                                const Color(0xFF8B8F98),
                              ),
                              height: 1.45,
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
                          padding: const EdgeInsets.symmetric(horizontal: 36),
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
                      padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
                      sliver: SliverList.separated(
                        itemCount: trainings.length,
                        itemBuilder: (context, index) => _CenterTrainingCard(
                          item: trainings[index],
                          onRegister: _openRegistration,
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 24),
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

class _CenterTrainingCard extends StatelessWidget {
  const _CenterTrainingCard({required this.item, required this.onRegister});

  final _CenterTraining item;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(26),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF101828).withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(26),
                ),
                child: SizedBox(
                  height: 258,
                  width: double.infinity,
                  child: _TrainingArtworkView(artwork: item.artwork),
                ),
              ),
              if (item.isPopular)
                Positioned(
                  top: 14,
                  right: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF111827,
                          ).withValues(alpha: 0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      'TERPOPULER',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.welcomeAccent,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: item.tagColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    item.category,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: item.tagTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  item.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: context.appThemedTextColor(const Color(0xFF383C62)),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 16),
                _TrainingMetaRow(
                  icon: Icons.calendar_month_outlined,
                  text: item.dateRange,
                ),
                const SizedBox(height: 10),
                _TrainingMetaRow(
                  icon: Icons.location_on_outlined,
                  text: item.location,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: onRegister,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.welcomeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
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

class _TrainingMetaRow extends StatelessWidget {
  const _TrainingMetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: context.appThemedMutedTextColor(const Color(0xFF8D91A9)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: context.appThemedMutedTextColor(const Color(0xFF868AA1)),
            ),
          ),
        ),
      ],
    );
  }
}

class _TrainingArtworkView extends StatelessWidget {
  const _TrainingArtworkView({required this.artwork});

  final _TrainingArtwork artwork;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: switch (artwork) {
        _TrainingArtwork.barista => const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4F2B10), Color(0xFFD19A4D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        _TrainingArtwork.design => const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF43494F), Color(0xFFB6B39D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        _TrainingArtwork.solar => const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E79BB), Color(0xFFFDE7A0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _ArtworkScenePainter(artwork: artwork)),
          ),
        ],
      ),
    );
  }
}

class _ArtworkScenePainter extends CustomPainter {
  const _ArtworkScenePainter({required this.artwork});

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
    final steam = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromLTWH(size.width * 0.56, size.height * 0.06, 46, 60),
      3.2,
      2.1,
      false,
      steam,
    );

    final metal = Paint()..color = const Color(0xFFD9D7D4);
    final machine = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.12,
        size.height * 0.18,
        size.width * 0.76,
        size.height * 0.48,
      ),
      const Radius.circular(6),
    );
    canvas.drawRRect(machine, metal);

    final dark = Paint()..color = const Color(0xFF18181B);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.10,
          size.height * 0.22,
          size.width * 0.22,
          24,
        ),
        const Radius.circular(12),
      ),
      dark,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.62,
          size.height * 0.18,
          size.width * 0.17,
          18,
        ),
        const Radius.circular(9),
      ),
      dark,
    );

    final cup = Paint()..color = const Color(0xFFE5E7EB);
    final cupRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.56,
        size.height * 0.50,
        size.width * 0.12,
        size.height * 0.17,
      ),
      const Radius.circular(8),
    );
    canvas.drawRRect(cupRect, cup);
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.50,
        size.height * 0.42,
        size.width * 0.06,
        6,
      ),
      dark,
    );
  }

  void _paintDesign(Canvas canvas, Size size) {
    final desk = Paint()..color = const Color(0xFFB88E63);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.78, size.width, size.height * 0.22),
      desk,
    );

    final monitor = Paint()..color = const Color(0xFF25272D);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.15,
          size.height * 0.12,
          size.width * 0.42,
          size.height * 0.48,
        ),
        const Radius.circular(10),
      ),
      monitor,
    );
    final screen = Paint()
      ..shader =
          const LinearGradient(
            colors: [Color(0xFFF77AE6), Color(0xFF57D6FF), Color(0xFFFFC857)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(
            Rect.fromLTWH(
              size.width * 0.18,
              size.height * 0.15,
              size.width * 0.36,
              size.height * 0.40,
            ),
          );
    final path = Path()
      ..moveTo(size.width * 0.36, size.height * 0.18)
      ..quadraticBezierTo(
        size.width * 0.47,
        size.height * 0.28,
        size.width * 0.42,
        size.height * 0.40,
      )
      ..quadraticBezierTo(
        size.width * 0.36,
        size.height * 0.54,
        size.width * 0.28,
        size.height * 0.45,
      )
      ..quadraticBezierTo(
        size.width * 0.16,
        size.height * 0.36,
        size.width * 0.22,
        size.height * 0.24,
      )
      ..close();
    canvas.drawPath(path, screen);

    final tablet = Paint()..color = const Color(0xFF17191F);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.48,
          size.height * 0.54,
          size.width * 0.20,
          size.height * 0.17,
        ),
        const Radius.circular(12),
      ),
      tablet,
    );
    final pen = Paint()
      ..color = const Color(0xFFF3F4F6)
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.62, size.height * 0.48),
      Offset(size.width * 0.55, size.height * 0.70),
      pen,
    );
  }

  void _paintSolar(Canvas canvas, Size size) {
    final horizon = Paint()..color = const Color(0xFFFFE08A);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.70, size.width, size.height * 0.30),
      horizon,
    );
    final sun = Paint()..color = Colors.white.withValues(alpha: 0.85);
    canvas.drawCircle(Offset(size.width * 0.88, size.height * 0.16), 30, sun);

    final panel = Paint()..color = const Color(0xFF2B74B8);
    final panelDark = Paint()..color = const Color(0xFF235E94);
    final points = [
      Offset(size.width * 0.02, size.height * 0.84),
      Offset(size.width * 0.84, size.height * 0.62),
      Offset(size.width * 0.98, size.height * 0.72),
      Offset(size.width * 0.16, size.height * 0.92),
    ];
    final path = Path()..addPolygon(points, true);
    canvas.drawPath(path, panel);
    for (var i = 1; i < 6; i++) {
      final dx = size.width * (0.08 + i * 0.14);
      canvas.drawLine(
        Offset(dx, size.height * 0.86),
        Offset(dx + 24, size.height * 0.67),
        panelDark..strokeWidth = 2,
      );
    }
    for (var i = 0; i < 4; i++) {
      final y = size.height * (0.72 + i * 0.05);
      canvas.drawLine(
        Offset(size.width * 0.08, y),
        Offset(size.width * 0.93, y - 0.04 * size.width),
        panelDark..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ArtworkScenePainter oldDelegate) {
    return oldDelegate.artwork != artwork;
  }
}

class _CenterTraining {
  const _CenterTraining({
    required this.category,
    required this.title,
    required this.dateRange,
    required this.location,
    required this.artwork,
    required this.tagColor,
    required this.tagTextColor,
    this.isPopular = false,
  });

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
