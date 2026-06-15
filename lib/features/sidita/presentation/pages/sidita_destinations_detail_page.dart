import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../services/sidita_models.dart';

class SiditaBromoDetailPage extends StatefulWidget {
  final DestinasiModel destinasi;

  const SiditaBromoDetailPage({
    super.key,
    required this.destinasi,
  });

  @override
  State<SiditaBromoDetailPage> createState() => _SiditaBromoDetailPageState();
}

class _SiditaBromoDetailPageState extends State<SiditaBromoDetailPage> {
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeSiditaDestinations);
  }

  void _showPlaceholder(String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label akan kita lanjutkan berikutnya.')),
    );
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
                      // 🟢 DINAMIS: Nama tempat di App Bar
                      widget.destinasi.namaWisata ?? 'Detail Destinasi',
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
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 620,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              widget.destinasi.fotoUrl != null && widget.destinasi.fotoUrl!.isNotEmpty
                                  ? Image.network(
                                widget.destinasi.fotoUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                  'assets/images/dummy_image.png',
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : Image.asset(
                                'assets/images/dummy_image.png',
                                fit: BoxFit.cover,
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.08),
                                      Colors.black.withValues(alpha: 0.45),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 24,
                          right: 24,
                          bottom: 110,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const _InfoChip(label: 'Wisata Alam'),
                                  const SizedBox(width: 10),
                                  // 🟢 DINAMIS: Kabupaten Kota di atas judul besar
                                  _InfoChip(label: widget.destinasi.kabupatenKota ?? 'Jawa Timur'),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Text(
                                // 🟢 DINAMIS: Nama tempat utama
                                widget.destinasi.namaWisata ?? '-',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  height: 1.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 24,
                          right: 24,
                          bottom: 24,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: context.appSurfaceColor,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: context.appThemedCardShadows([
                                BoxShadow(
                                  color: const Color(
                                    0xFF111827,
                                  ).withValues(alpha: 0.08),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ]),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _HeroStatItem(
                                    label: 'LOKASI',
                                    value: widget.destinasi.kecamatan ?? widget.destinasi.kabupatenKota ?? '-',
                                  ),
                                ),
                                _HeroStatDivider(),
                                Expanded(
                                  child: _HeroStatItem(
                                    label: 'BIAYA MASUK',
                                    value: widget.destinasi.harga,
                                  ),
                                ),
                                _HeroStatDivider(),
                                const Expanded(
                                  child: _HeroStatItem(
                                    label: 'WAKTU TERBAIK',
                                    value: 'Apr - Okt',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tentang ${widget.destinasi.namaWisata}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: context.appTextColor,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            widget.destinasi.deskripsi ?? 'Belum ada deskripsi untuk destinasi wisata ini.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.8,
                              color: context.appMutedTextColor,
                            ),
                          ),
                          const SizedBox(height: 28),
                          _FeatureInfoCard(
                            icon: Icons.landscape_rounded,
                            title: 'Ketinggian',
                            // 🟢 DINAMIS: Menampilkan ketinggian mdpl dinamis (contoh: 800mdpl)
                            value: widget.destinasi.ketinggianMdpl != null
                                ? '${widget.destinasi.ketinggianMdpl}mdpl'
                                : '2,329mdpl',
                            fullWidth: true,
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: _FeatureInfoCard(
                                  icon: Icons.device_thermostat_rounded,
                                  // 🟢 DINAMIS: Menampilkan suhu rata-rata dari database seeder
                                  title: widget.destinasi.rataRataSuhu != null
                                      ? '${widget.destinasi.rataRataSuhu}°C'
                                      : '5°C – 15°C',
                                  value: 'Suhu Rata-rata',
                                  compact: true,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _FeatureInfoCard(
                                  icon: Icons.stars_rounded,
                                  // 🟢 DINAMIS: Menampilkan rating riil objek (contoh: Rating 4.5)
                                  title: 'Rating ${widget.destinasi.rating ?? "0"}',
                                  value: 'Wisatawan',
                                  compact: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
                            decoration: BoxDecoration(
                              color: context.appSurfaceColor,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: context.appThemedCardShadows([
                                BoxShadow(
                                  color: const Color(
                                    0xFF111827,
                                  ).withValues(alpha: 0.05),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ]),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Beri Ulasan',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: context.appTextColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                const Center(child: _StarRow()),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: _reviewController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: 'Tambahkan komentar...',
                                    hintStyle: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: context.appMutedTextColor,
                                    ),
                                    filled: true,
                                    fillColor: context.isDarkMode
                                        ? context.appSearchSurfaceColor
                                        : const Color(0xFFF7F9FF),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.all(18),
                                  ),
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: context.appTextColor,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                OutlinedButton(
                                  onPressed: () =>
                                      _showPlaceholder('Kirim ulasan'),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(58),
                                    side: const BorderSide(
                                      color: AppColors.welcomeAccent,
                                      width: 1.4,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(29),
                                    ),
                                    foregroundColor: AppColors.welcomeAccent,
                                    textStyle: GoogleFonts.plusJakartaSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  child: const Text('Kirim Ulasan'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 26),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Ulasan Wisatawan',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: context.appTextColor,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    _showPlaceholder('Semua ulasan'),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.welcomeAccent,
                                  textStyle: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                child: const Text('Lihat Semua'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            height: 316,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: const [
                                _ReviewCard(
                                  name: 'Alex Rivera',
                                  review:
                                  '"The sunrise was absolutely breathtaking. Make sure to bring a warm jacket, it\'s freezing before dawn!"',
                                ),
                                SizedBox(width: 16),
                                _ReviewCard(
                                  name: 'Nadia Putri',
                                  review:
                                  '"Unreal landscape and the jeep route feels like an adventure from start to finish."',
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
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SUB-WIDGET COMPONENT ====================
class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _HeroStatItem extends StatelessWidget {
  const _HeroStatItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
            color: context.appMutedTextColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.welcomeAccent,
          ),
        ),
      ],
    );
  }
}

class _HeroStatDivider extends StatelessWidget {
  const _HeroStatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 54,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: context.appBorderColor,
    );
  }
}

class _FeatureInfoCard extends StatelessWidget {
  const _FeatureInfoCard({
    required this.icon,
    required this.title,
    required this.value,
    this.fullWidth = false,
    this.compact = false,
  });

  final IconData icon;
  final String title;
  final String value;
  final bool fullWidth;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: EdgeInsets.fromLTRB(
        compact ? 20 : 24,
        compact ? 18 : 22,
        compact ? 20 : 24,
        compact ? 18 : 22,
      ),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.welcomeAccent, size: compact ? 26 : 28),
          const SizedBox(height: 14),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: compact ? 18 : 16,
              fontWeight: FontWeight.w700,
              color: context.appTextColor,
            ),
          ),
          if (value.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: context.appMutedTextColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  const _StarRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final isFilled = index < 4;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(
            isFilled ? Icons.star_rounded : Icons.star_border_rounded,
            size: 38,
            color: isFilled ? const Color(0xFFFFA928) : const Color(0xFFD1D5DB),
          ),
        );
      }),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.name, required this.review});
  final String name;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? AppColors.welcomeAccent.withValues(alpha: 0.16)
                      : const Color(0xFFE7F0FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: AppColors.welcomeAccent,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: context.appTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                            (index) => const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: Color(0xFFFFC84A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            review,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.7,
              color: context.appMutedTextColor,
            ),
          ),
        ],
      ),
    );
  }
}