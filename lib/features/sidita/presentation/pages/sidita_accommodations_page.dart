import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class SiditaAccommodationsPage extends StatefulWidget {
  const SiditaAccommodationsPage({super.key});

  @override
  State<SiditaAccommodationsPage> createState() =>
      _SiditaAccommodationsPageState();
}

class _SiditaAccommodationsPageState extends State<SiditaAccommodationsPage> {
  static const _regions = ['Malang', 'Jawa Timur', 'Surabaya', 'Banyuwangi'];

  static const _featuredProperty = _SiditaAccommodationItem(
    title: 'The Singhasari\nResort',
    location: 'Batu, Jawa Timur',
    price: 'Rp 2.450.000',
    unit: '/malam',
    badgeText: 'FEATURED LUXURY',
    routeName: RouteNames.homeSiditaSinghasari,
  );

  static const _popularProperties = [
    _SiditaAccommodationItem(
      title: 'Grand City Hall Surabaya',
      location: 'Surabaya Pusat',
      price: 'Rp 1.450.000',
      unit: '/malam',
    ),
    _SiditaAccommodationItem(
      title: 'Oak Tree Glamping',
      location: 'Batu, Malang',
      price: 'Rp 850.000',
      unit: '/malam',
    ),
    _SiditaAccommodationItem(
      title: 'Jaya Sands Resort',
      location: 'Banyuwangi',
      price: 'Rp 2.100.000',
      unit: '/malam',
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _selectedRegion = _regions.first;

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

  void _openAccommodation(_SiditaAccommodationItem item) {
    final routeName = item.routeName;
    if (routeName != null) {
      context.pushNamed(routeName);
      return;
    }

    _showPlaceholder(item.title);
  }

  void _showPlaceholder(String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label akan kita lanjutkan berikutnya.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final visibleProperties = _popularProperties.where((property) {
      if (query.isEmpty) {
        return true;
      }

      return property.title.toLowerCase().contains(query) ||
          property.location.toLowerCase().contains(query);
    }).toList();

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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SearchField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
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
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 22,
                                    color: context.appMutedTextColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(region),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }

                            setState(() {
                              _selectedRegion = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
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
                      item: _featuredProperty,
                      onTap: () => _openAccommodation(_featuredProperty),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Properti Terpopuler',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: context.appTextColor,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              _showPlaceholder('Semua properti akomodasi'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.welcomeAccent,
                            textStyle: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: const Text('Lihat Semua'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...visibleProperties.map(
                      (property) => Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: _PopularAccommodationCard(
                          item: property,
                          onTap: () => _openAccommodation(property),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SiditaAccommodationItem {
  const _SiditaAccommodationItem({
    required this.title,
    required this.location,
    required this.price,
    required this.unit,
    this.badgeText,
    this.routeName,
  });

  final String title;
  final String location;
  final String price;
  final String unit;
  final String? badgeText;
  final String? routeName;
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: context.appTextColor,
      ),
      decoration: InputDecoration(
        hintText: 'Cari Destinasi Wisata',
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: context.appMutedTextColor,
        ),
        filled: true,
        fillColor: context.isDarkMode
            ? context.appSearchSurfaceColor
            : const Color(0xFFF0F0F2),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 20,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Icon(
            Icons.search_rounded,
            color: context.appMutedTextColor,
            size: 34,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 58),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.welcomeAccent,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}

class _FeaturedAccommodationCard extends StatelessWidget {
  const _FeaturedAccommodationCard({required this.item, required this.onTap});

  final _SiditaAccommodationItem item;
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
                Image.asset('assets/images/dummy_image.png', fit: BoxFit.cover),
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
                  padding: const EdgeInsets.fromLTRB(26, 26, 26, 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.88),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          item.badgeText ?? '',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                            color: const Color(0xFF8C8F96),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        item.title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.location,
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

class _PopularAccommodationCard extends StatelessWidget {
  const _PopularAccommodationCard({required this.item, required this.onTap});

  final _SiditaAccommodationItem item;
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
                  'assets/images/dummy_image.png',
                  width: double.infinity,
                  height: 206,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                item.title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: context.appTextColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.location,
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
                      text: item.price,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.welcomeAccent,
                      ),
                    ),
                    TextSpan(
                      text: item.unit,
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
