import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class AboutJatimPage extends StatelessWidget {
  const AboutJatimPage({super.key});

  static const _stats = [
    _JatimStatItem(
      label: 'LUAS WILAYAH',
      value: '47,803 km²',
      icon: Icons.map_rounded,
    ),
    _JatimStatItem(
      label: 'POPULASI',
      value: '40.66 Juta',
      icon: Icons.groups_2_rounded,
    ),
    _JatimStatItem(
      label: 'PERTUMBUHAN',
      value: '5.34%',
      icon: Icons.trending_up_rounded,
    ),
    _JatimStatItem(
      label: 'KAB/KOTA',
      value: '38 Daerah',
      icon: Icons.apartment_rounded,
    ),
  ];

  static const _highlights = [
    _JatimHighlight(
      title: 'Gunung Bromo & Ijen',
      description:
          'Ikon wisata dunia dengan fenomena Blue Fire dan matahari terbit yang spektakuler.',
    ),
    _JatimHighlight(
      title: 'Warisan Kerajaan Majapahit',
      description:
          'Situs arkeologi di Trowulan menjadi saksi sejarah kejayaan nusantara masa lampau.',
    ),
    _JatimHighlight(
      title: 'Kuliner Legendaris',
      description:
          'Ragam cita rasa mulai dari Rawon, Rujak Cingur, hingga Nasi Tempong yang khas.',
    ),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeProfile);
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Konten detail Jawa Timur akan segera tersedia.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.splashBackground,
              padding: const EdgeInsets.fromLTRB(18, 22, 24, 28),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _handleBack(context),
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(44, 44),
                    ),
                    icon: const Icon(Icons.arrow_back_rounded, size: 34),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tentang Jawa Timur',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _JatimHeroSection(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _JatimStatsCard(items: _stats),
                              const SizedBox(height: 30),
                              const _SectionHeading(
                                title: 'Pusat Ekonomi &\nKebudayaan',
                                color: AppColors.welcomeAccent,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Jawa Timur merupakan provinsi dengan luas wilayah terbesar di Pulau Jawa. Sebagai gerbang utama menuju wilayah Indonesia Timur, provinsi ini memiliki peran strategis dalam peta ekonomi nasional.',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  height: 1.7,
                                  color: const Color(0xFF5E6470),
                                ),
                              ),
                              const SizedBox(height: 24),
                              const _QuoteCallout(),
                              const SizedBox(height: 26),
                              const _CitySpotlightCard(),
                              const SizedBox(height: 26),
                              _InvestmentCard(
                                onPressed: () => _showComingSoon(context),
                              ),
                              const SizedBox(height: 28),
                              const _SectionHeading(
                                title: 'Kekayaan Alam & Wisata',
                                color: Color(0xFF4C5058),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                'Dari kemegahan Pegunungan Tengger hingga keindahan pantai pasir putih di Malang dan Banyuwangi, Jawa Timur menawarkan lanskap yang luar biasa. Sektor pariwisata menjadi salah satu pilar penting dalam pemulihan ekonomi pasca-pandemi.',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  height: 1.7,
                                  color: const Color(0xFF6A707B),
                                ),
                              ),
                              const SizedBox(height: 24),
                              ..._highlights.map(
                                (item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 18),
                                  child: _HighlightBullet(item: item),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

class _JatimHeroSection extends StatelessWidget {
  const _JatimHeroSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 390,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0B284D),
                  Color(0xFF3A5D86),
                  Color(0xFFF6D8A4),
                ],
                stops: [0, 0.58, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _HeroLandscapePainter()),
            ),
          ),
          Positioned(
            right: 10,
            top: 22,
            child: Container(
              width: 8,
              height: 58,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 88,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.16),
                    ),
                  ),
                  child: Text(
                    'PROFIL PROVINSI',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Sekilas Profil\nJawa Timur',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.08,
                    color: Colors.white,
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

class _JatimStatsCard extends StatelessWidget {
  const _JatimStatsCard({required this.items});

  final List<_JatimStatItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
          childAspectRatio: 1.35,
        ),
        itemBuilder: (context, index) => _StatTile(item: items[index]),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.item});

  final _JatimStatItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, size: 20, color: AppColors.welcomeAccent),
          const SizedBox(height: 10),
          Text(
            item.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: const Color(0xFF5D8EF8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF434954),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuoteCallout extends StatelessWidget {
  const _QuoteCallout();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 96,
            decoration: BoxDecoration(
              color: AppColors.welcomeAccent,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              '"Basuki Mawa Beya" — Keberhasilan membutuhkan pengorbanan dan kerja keras. Semboyan yang menjadi ruh pembangunan masyarakat Jawa Timur.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                height: 1.6,
                color: const Color(0xFF69707D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CitySpotlightCard extends StatelessWidget {
  const _CitySpotlightCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Container(
        height: 210,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A4A85), Color(0xFF1A79D6), Color(0xFF84C5FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _CitySkylinePainter()),
              ),
            ),
            Positioned(
              left: 24,
              bottom: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Surabaya',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pusat Pemerintahan & Perdagangan Internasional',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.45,
                      color: Colors.white.withValues(alpha: 0.9),
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

class _InvestmentCard extends StatelessWidget {
  const _InvestmentCard({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A6BFF), Color(0xFF0F52D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Investasi & Industri',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Jawa Timur mencatatkan pertumbuhan realisasi investasi yang signifikan, didorong oleh infrastruktur pelabuhan internasional dan zona industri terintegrasi.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.7,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.welcomeAccent,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              textStyle: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            child: const Text('Pelajari Lebih Lanjut'),
          ),
        ],
      ),
    );
  }
}

class _HighlightBullet extends StatelessWidget {
  const _HighlightBullet({required this.item});

  final _JatimHighlight item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 9),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.welcomeAccent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF454B56),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.description,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.65,
                  color: const Color(0xFF727884),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: color,
      ),
    );
  }
}

class _HeroLandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final skyGlow = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0x33FFFFFF), Color(0x00FFFFFF)],
        radius: 0.75,
        center: Alignment(0, 0.2),
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, skyGlow);

    final mist = Paint()
      ..shader =
          LinearGradient(
            colors: [
              Colors.transparent,
              Colors.white.withValues(alpha: 0.16),
              Colors.white.withValues(alpha: 0.3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(
            Rect.fromLTWH(0, size.height * 0.52, size.width, size.height),
          );
    canvas.drawRect(Offset.zero & size, mist);

    final mountainBack = Paint()..color = const Color(0xFF1B365D);
    final mountainMid = Paint()..color = const Color(0xFF324F78);
    final mountainFront = Paint()..color = const Color(0xFF3D5872);

    final backPath = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
        size.width * 0.16,
        size.height * 0.52,
        size.width * 0.32,
        size.height * 0.67,
      )
      ..quadraticBezierTo(
        size.width * 0.44,
        size.height * 0.44,
        size.width * 0.6,
        size.height * 0.66,
      )
      ..quadraticBezierTo(
        size.width * 0.78,
        size.height * 0.5,
        size.width,
        size.height * 0.68,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(backPath, mountainBack);

    final volcano = Path()
      ..moveTo(size.width * 0.32, size.height * 0.66)
      ..lineTo(size.width * 0.52, size.height * 0.28)
      ..lineTo(size.width * 0.73, size.height * 0.66)
      ..close();
    canvas.drawPath(
      volcano,
      Paint()
        ..shader =
            const LinearGradient(
              colors: [Color(0xFF364A6B), Color(0xFF62789D)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ).createShader(
              Rect.fromLTWH(
                size.width * 0.32,
                size.height * 0.28,
                size.width * 0.41,
                size.height * 0.38,
              ),
            ),
    );

    final crater = Path()
      ..moveTo(size.width * 0.46, size.height * 0.34)
      ..quadraticBezierTo(
        size.width * 0.52,
        size.height * 0.31,
        size.width * 0.58,
        size.height * 0.34,
      );
    canvas.drawPath(
      crater,
      Paint()
        ..color = const Color(0x88FFFFFF)
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke,
    );

    final frontPath = Path()
      ..moveTo(0, size.height * 0.82)
      ..quadraticBezierTo(
        size.width * 0.14,
        size.height * 0.61,
        size.width * 0.26,
        size.height * 0.8,
      )
      ..quadraticBezierTo(
        size.width * 0.42,
        size.height * 0.54,
        size.width * 0.55,
        size.height * 0.82,
      )
      ..quadraticBezierTo(
        size.width * 0.72,
        size.height * 0.58,
        size.width * 0.86,
        size.height * 0.78,
      )
      ..quadraticBezierTo(
        size.width * 0.94,
        size.height * 0.72,
        size.width,
        size.height * 0.82,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(frontPath, mountainMid);

    final rightCone = Path()
      ..moveTo(size.width * 0.56, size.height * 0.82)
      ..quadraticBezierTo(
        size.width * 0.66,
        size.height * 0.53,
        size.width * 0.82,
        size.height * 0.82,
      )
      ..close();
    canvas.drawPath(
      rightCone,
      Paint()
        ..shader =
            const LinearGradient(
              colors: [Color(0xFF4D6A51), Color(0xFF917A3B), Color(0xFF324868)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ).createShader(
              Rect.fromLTWH(
                size.width * 0.56,
                size.height * 0.53,
                size.width * 0.26,
                size.height * 0.29,
              ),
            ),
    );

    final steam = Paint()..color = const Color(0xAAEAEFF7);
    canvas.drawCircle(Offset(size.width * 0.26, size.height * 0.73), 18, steam);
    canvas.drawCircle(Offset(size.width * 0.24, size.height * 0.75), 12, steam);

    final fog = Paint()
      ..shader =
          LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.0),
              Colors.white.withValues(alpha: 0.34),
              Colors.white.withValues(alpha: 0.7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(
            Rect.fromLTWH(
              0,
              size.height * 0.72,
              size.width,
              size.height * 0.28,
            ),
          );
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.68, size.width, size.height * 0.32),
      fog,
    );

    final ridgePaint = Paint()
      ..color = const Color(0x55FFFFFF)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < 7; i++) {
      final startX = size.width * (0.16 + i * 0.09);
      final path = Path()
        ..moveTo(startX, size.height * 0.82)
        ..quadraticBezierTo(
          startX + 12,
          size.height * (0.69 + (i.isEven ? -0.02 : 0.01)),
          startX + 28,
          size.height * 0.62,
        );
      canvas.drawPath(path, ridgePaint);
    }

    final foreground = Path()
      ..moveTo(0, size.height * 0.92)
      ..quadraticBezierTo(
        size.width * 0.22,
        size.height * 0.84,
        size.width * 0.45,
        size.height * 0.9,
      )
      ..quadraticBezierTo(
        size.width * 0.66,
        size.height * 0.8,
        size.width,
        size.height * 0.94,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(foreground, mountainFront);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CitySkylinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final ground = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.black.withValues(alpha: 0.65),
          Colors.black.withValues(alpha: 0.16),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Offset.zero & size, ground);

    final buildingPaint = Paint()..color = const Color(0xFF173758);
    final windowPaint = Paint()..color = const Color(0x66D7EEFF);

    final buildings = <Rect>[
      Rect.fromLTWH(size.width * 0.08, size.height * 0.26, 34, 110),
      Rect.fromLTWH(size.width * 0.22, size.height * 0.1, 44, 146),
      Rect.fromLTWH(size.width * 0.4, size.height * 0.18, 58, 132),
      Rect.fromLTWH(size.width * 0.6, size.height * 0.02, 44, 176),
      Rect.fromLTWH(size.width * 0.74, size.height * 0.14, 50, 138),
    ];

    for (final rect in buildings) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        buildingPaint,
      );

      final cols = math.max(2, (rect.width / 10).floor());
      final rows = math.max(4, (rect.height / 16).floor());
      for (var row = 0; row < rows; row++) {
        for (var col = 0; col < cols; col++) {
          final windowRect = Rect.fromLTWH(
            rect.left + 6 + col * 10,
            rect.top + 10 + row * 14,
            4,
            7,
          );
          if (windowRect.right < rect.right - 4 &&
              windowRect.bottom < rect.bottom - 6) {
            canvas.drawRRect(
              RRect.fromRectAndRadius(windowRect, const Radius.circular(1)),
              windowPaint,
            );
          }
        }
      }
    }

    final reflection = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white.withValues(alpha: 0.04), Colors.transparent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, reflection);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _JatimStatItem {
  const _JatimStatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
}

class _JatimHighlight {
  const _JatimHighlight({required this.title, required this.description});

  final String title;
  final String description;
}
