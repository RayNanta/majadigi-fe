import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../services/sidita_models.dart';

class SiditaAccommodationsPage extends StatefulWidget {
  const SiditaAccommodationsPage({super.key});

  @override
  State<SiditaAccommodationsPage> createState() =>
      _SiditaAccommodationsPageState();
}

class _SiditaAccommodationsPageState extends State<SiditaAccommodationsPage> {
  static const _regions = ['Semua', 'Malang', 'Mojokerto', 'Surabaya', 'Banyuwangi'];

  final TextEditingController _searchController = TextEditingController();
  String _selectedRegion = _regions.first;
  Future<List<AkomodasiModel>> fetchAkomodasi() async {
    return [
      AkomodasiModel(
        id: 1,
        namaAkomodasi: 'Resort Grand Padusan',
        kabupatenKota: 'Kabupaten Mojokerto',
        deskripsi: 'Penginapan nyaman dengan fasilitas kolam air hangat pribadi dan pemandangan pinus.',
        harga: 'IDR 350000',
        rating: '4.7',
        fotoUrl: 'assets/images/resort_padusan.jpg',
        fasilitasPopuler: ['Kolam Air Hangat', 'Free Wi-Fi', 'Restoran'],
      )
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.homeSiditaMain);
  }

  // 🟢 Kirim objek model akomodasi secara utuh via extra GoRouter ke halaman detail
  void _openAccommodationDetail(AkomodasiModel item) {
    context.pushNamed(
      RouteNames.homeSiditaSinghasari, // Pakai nama route detail akomodasimu rill
      extra: item,
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
            // App Bar Container
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
                      'Akomodasi',
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

            // Body Area dengan FutureBuilder
            Expanded(
              child: FutureBuilder<List<AkomodasiModel>>(
                future: fetchAkomodasi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.welcomeAccent));
                  }

                  if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'Gagal mengambil data akomodasi rill.',
                        style: GoogleFonts.plusJakartaSans(color: context.appMutedTextColor),
                      ),
                    );
                  }

                  final allItems = snapshot.data!;
                  final query = _searchController.text.trim().toLowerCase();

                  // Filter berdasarkan Pencarian & Region Dropdown
                  final visibleProperties = allItems.where((property) {
                    final matchesSearch = property.namaAkomodasi.toLowerCase().contains(query) ||
                        property.kabupatenKota.toLowerCase().contains(query);
                    final matchesRegion = _selectedRegion == 'Semua' ||
                        property.kabupatenKota.toLowerCase().contains(_selectedRegion.toLowerCase());
                    return matchesSearch && matchesRegion;
                  }).toList();

                  // Pisahkan rekomendasi utama (index 0) dan terpopuler sisanya jika ada
                  final featuredProperty = visibleProperties.isNotEmpty ? visibleProperties.first : null;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SearchField(
                          controller: _searchController,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 12),

                        // Region Dropdown
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          decoration: BoxDecoration(
                            color: context.isDarkMode
                                ? context.appSearchSurfaceColor
                                : const Color(0xFFF0F0F2),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedRegion,
                              icon: Icon(
                                Icons.expand_more_rounded,
                                color: context.appMutedTextColor,
                                size: 28,
                              ),
                              dropdownColor: context.appSurfaceColor,
                              borderRadius: BorderRadius.circular(18),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: context.appTextColor,
                              ),
                              items: _regions.map((region) {
                                return DropdownMenuItem<String>(
                                  value: region,
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on_outlined, size: 22, color: context.appMutedTextColor),
                                      const SizedBox(width: 10),
                                      Text(region),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() {
                                  _selectedRegion = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),

                        // Section Rekomendasi Utama
                        if (featuredProperty != null) ...[
                          Text(
                            'Rekomendasi Utama',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: context.appTextColor,
                            ),
                          ),
                          const SizedBox(height: 18),
                          _FeaturedAccommodationCard(
                            item: featuredProperty,
                            onTap: () => _openAccommodationDetail(featuredProperty),
                          ),
                          const SizedBox(height: 28),
                        ],

                        // Section Properti Terpopuler
                        Text(
                          'Properti Terpopuler',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: context.appTextColor,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Render Sisa List Akomodasi
                        ...visibleProperties.map(
                              (property) => Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: _PopularAccommodationCard(
                              item: property,
                              onTap: () => _openAccommodationDetail(property),
                            ),
                          ),
                        ),

                        if (visibleProperties.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: Center(
                              child: Text(
                                'Belum ada akomodasi yang cocok.',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: context.appMutedTextColor,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
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

// 🟢 CARD REKOMENDASI UTAMA DINAMIS
class _FeaturedAccommodationCard extends StatelessWidget {
  const _FeaturedAccommodationCard({required this.item, required this.onTap});

  final AkomodasiModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appSurfaceColor,
      borderRadius: BorderRadius.circular(26),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: SizedBox(
            height: 440,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Menggunakan trik dinamis lokal asset
                Image.asset(
                  item.fotoUrl ?? 'assets/images/padusan_main.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/padusan_main.jpg', fit: BoxFit.cover),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.08),
                        Colors.black.withValues(alpha: 0.18),
                        Colors.black.withValues(alpha: 0.68),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.88),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '★ ${item.rating}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        item.namaAkomodasi,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.kabupatenKota,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.92),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 🟢 CARD PROPERTI TERPOPULER DINAMIS
class _PopularAccommodationCard extends StatelessWidget {
  const _PopularAccommodationCard({required this.item, required this.onTap});

  final AkomodasiModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appSurfaceColor,
      borderRadius: BorderRadius.circular(26),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(
                  item.fotoUrl ?? 'assets/images/padusan_main.jpg',
                  width: double.infinity,
                  height: 206,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/padusan_main.jpg', fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                item.namaAkomodasi,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: context.appTextColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.kabupatenKota,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: context.appMutedTextColor,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'MULAI DARI',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: context.appMutedTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: item.harga,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.welcomeAccent,
                      ),
                    ),
                    TextSpan(
                      text: ' /malam',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: context.appMutedTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// _SearchField widget tetap sama seperti kodingan lamamu...