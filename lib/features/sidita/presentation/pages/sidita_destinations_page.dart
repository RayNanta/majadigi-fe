import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../../../shared/widgets/lazy_load_states.dart';

final _siditaDestinationsProvider =
    FutureProvider.autoDispose<List<_SiditaDestinationItem>>((ref) async {
      await Future<void>.delayed(Duration.zero);
      return _SiditaDestinationsPageState._allDestinations;
    });

class SiditaDestinationsPage extends ConsumerStatefulWidget {
  const SiditaDestinationsPage({super.key});

  @override
  ConsumerState<SiditaDestinationsPage> createState() =>
      _SiditaDestinationsPageState();
}

class _SiditaDestinationsPageState
    extends ConsumerState<SiditaDestinationsPage> {
  static const _regions = ['Malang', 'Batu', 'Surabaya'];

  static const _allDestinations = [
    _SiditaDestinationItem(
      title: 'Gunung Bromo',
      location: 'TENGGER, EAST JAVA',
      description:
          'Experience the otherworldly beauty of an active volcano sunrise across the vast sea of sand.',
      price: 'IDR 250K',
      unit: '/pax',
      rating: '4.9',
      region: 'Malang',
      routeName: RouteNames.homeSiditaBromo,
    ),
    _SiditaDestinationItem(
      title: 'Jatim Park 3',
      location: 'BATU CITY',
      description:
          'A world-class theme park featuring Dino Park and the Legend Stars museum with immersive education.',
      price: 'IDR 120k',
      unit: '/pax',
      rating: '4.7',
      region: 'Malang',
    ),
    _SiditaDestinationItem(
      title: 'Kampung Jodipan',
      location: 'JODIPAN, MALANG',
      description:
          'Explore the rainbow-colored streets of Indonesia\'s most vibrant urban regeneration project.',
      price: 'IDR 5k',
      unit: '/entry',
      rating: '4.5',
      region: 'Malang',
    ),
    _SiditaDestinationItem(
      title: 'Museum Angkut',
      location: 'BATU CITY',
      description:
          'Discover a transport-themed attraction with curated exhibits and immersive city set installations.',
      price: 'IDR 100k',
      unit: '/pax',
      rating: '4.8',
      region: 'Batu',
    ),
    _SiditaDestinationItem(
      title: 'Taman Bungkul',
      location: 'SURABAYA',
      description:
          'Relax in one of Surabaya\'s most iconic public parks with culinary stalls and community spaces.',
      price: 'IDR 0',
      unit: '/entry',
      rating: '4.6',
      region: 'Surabaya',
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

  void _openDestinationDetail(_SiditaDestinationItem item) {
    final routeName = item.routeName;
    if (routeName != null) {
      context.pushNamed(routeName);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Detail ${item.title} akan kita lanjutkan berikutnya.'),
      ),
    );
  }

  List<_SiditaDestinationItem> _visibleDestinations(
    List<_SiditaDestinationItem> destinations,
  ) {
    final query = _searchController.text.trim().toLowerCase();
    return destinations.where((item) {
      if (item.region != _selectedRegion) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      return item.title.toLowerCase().contains(query) ||
          item.location.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final destinationsAsync = ref.watch(_siditaDestinationsProvider);

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
                      'Destinasi Wisata',
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
                      'Destinasi $_selectedRegion',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: context.appTextColor,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ...destinationsAsync.when<List<Widget>>(
                      loading: () => const [
                        LazyCardSkeleton(height: 520),
                        SizedBox(height: 28),
                        LazyCardSkeleton(height: 520),
                      ],
                      error: (error, stackTrace) => [
                        Padding(
                          padding: const EdgeInsets.only(top: 28),
                          child: LazyLoadErrorState(
                            message: 'Destinasi gagal dimuat.',
                            onRetry: () {
                              ref.invalidate(_siditaDestinationsProvider);
                            },
                          ),
                        ),
                      ],
                      data: (allDestinations) {
                        final destinations = _visibleDestinations(
                          allDestinations,
                        );
                        if (destinations.isEmpty) {
                          return [
                            Padding(
                              padding: const EdgeInsets.only(top: 36),
                              child: Center(
                                child: Text(
                                  'Belum ada destinasi yang cocok.',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: context.appMutedTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ];
                        }

                        return destinations.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 28),
                            child: _DestinationCard(
                              item: item,
                              onDetailPressed: () =>
                                  _openDestinationDetail(item),
                            ),
                          );
                        }).toList();
                      },
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

class _SiditaDestinationItem {
  const _SiditaDestinationItem({
    required this.title,
    required this.location,
    required this.description,
    required this.price,
    required this.unit,
    required this.rating,
    required this.region,
    this.routeName,
  });

  final String title;
  final String location;
  final String description;
  final String price;
  final String unit;
  final String rating;
  final String region;
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
      decoration: InputDecoration(
        hintText: 'Cari Destinasi Wisata',
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: context.appMutedTextColor,
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Icon(
            Icons.search_rounded,
            size: 34,
            color: context.appMutedTextColor,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        filled: true,
        fillColor: context.isDarkMode
            ? context.appSearchSurfaceColor
            : const Color(0xFFF0F0F2),
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
            width: 1.4,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 22,
        ),
      ),
      style: GoogleFonts.plusJakartaSans(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: context.appTextColor,
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  const _DestinationCard({required this.item, required this.onDetailPressed});

  final _SiditaDestinationItem item;
  final VoidCallback onDetailPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.05),
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
                  top: Radius.circular(24),
                ),
                child: Image.asset(
                  'assets/images/dummy_image.png',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF496D84).withValues(alpha: 0.82),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFF6D365),
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.rating,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: context.appMutedTextColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item.location,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                          color: context.appMutedTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  item.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: context.appTextColor,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                    color: context.appMutedTextColor,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
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
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.appMutedTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: onDetailPressed,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.welcomeAccent,
                        minimumSize: const Size(126, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        textStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: const Text('Detail'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
