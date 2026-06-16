import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../../../shared/widgets/lazy_load_states.dart';
import '../../services/sidita_models.dart';
import '../../services/sidita_services.dart';

class SiditaAccommodationsPage extends ConsumerStatefulWidget {
  const SiditaAccommodationsPage({super.key});

  @override
  ConsumerState<SiditaAccommodationsPage> createState() =>
      _SiditaAccommodationsPageState();
}

class _SiditaAccommodationsPageState
    extends ConsumerState<SiditaAccommodationsPage> {

  // ✅ Pisahkan label UI dan value BE (sama seperti destinations page)
  static const Map<String, String> _regionOptions = {
    'Semua'       : '',
    'Mojokerto'   : 'Kabupaten Mojokerto',
    'Probolinggo' : 'Kabupaten Probolinggo',
    'Malang'      : 'Kabupaten Malang',
    'Batu'        : 'Kota Batu',
    'Surabaya'    : 'Kota Surabaya',
    'Banyuwangi'  : 'Kabupaten Banyuwangi',
  };

  final TextEditingController _searchController = TextEditingController();
  String _selectedRegion = 'Semua';

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

  void _openAccommodationDetail(AkomodasiModel item) {
    context.pushNamed(
      RouteNames.homeSiditaSinghasari,
      extra: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ FIX: Ganti Map<String,String> → SiditaFilterParams
    final accommodationsAsync = ref.watch(
      siditaAkomodasiProvider(
        SiditaFilterParams(
          search: _searchController.text.trim(),
          kabKota: _regionOptions[_selectedRegion] ?? '',
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // APP BAR
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

            // BODY
            Expanded(
              child: accommodationsAsync.when(
                loading: () => const SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      LazyCardSkeleton(height: 440),
                      SizedBox(height: 24),
                      LazyCardSkeleton(height: 200),
                    ],
                  ),
                ),
                error: (error, stackTrace) => Center(
                  child: LazyLoadErrorState(
                    message: 'Gagal mengambil data akomodasi.',
                    onRetry: () {
                      ref.invalidate(siditaAkomodasiProvider);
                    },
                  ),
                ),
                data: (visibleProperties) {
                  final featuredProperty = visibleProperties.isNotEmpty
                      ? visibleProperties.first
                      : null;
                  final popularProperties = visibleProperties.length > 1
                      ? visibleProperties.sublist(1)
                      : <AkomodasiModel>[];

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SEARCH FIELD
                        _SearchField(
                          controller: _searchController,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 12),

                        // REGION DROPDOWN
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
                              items: _regionOptions.keys.map((label) {
                                return DropdownMenuItem<String>(
                                  value: label,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 22,
                                        color: context.appMutedTextColor,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(label),
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

                        // SECTION REKOMENDASI UTAMA
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

                        // SECTION PROPERTI TERPOPULER
                        if (popularProperties.isNotEmpty) ...[
                          Text(
                            'Properti Terpopuler',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: context.appTextColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...popularProperties.map(
                                (property) => Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: _PopularAccommodationCard(
                                item: property,
                                onTap: () => _openAccommodationDetail(property),
                              ),
                            ),
                          ),
                        ],

                        // JIKA DATA KOSONG
                        if (visibleProperties.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: Center(
                              child: Text(
                                'Belum ada akomodasi yang cocok di $_selectedRegion.',
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

// ==================== SUB-WIDGET COMPONENTS ====================

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
        hintText: 'Cari Akomodasi / Hotel',
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
                item.fotoUrl != null && item.fotoUrl!.startsWith('http')
                    ? Image.network(
                  item.fotoUrl!,
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
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
                child: item.fotoUrl != null && item.fotoUrl!.startsWith('http')
                    ? Image.network(
                  item.fotoUrl!,
                  width: double.infinity,
                  height: 206,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset(
                        'assets/images/dummy_image.png',
                        width: double.infinity,
                        height: 206,
                        fit: BoxFit.cover,
                      ),
                )
                    : Image.asset(
                  'assets/images/dummy_image.png',
                  width: double.infinity,
                  height: 206,
                  fit: BoxFit.cover,
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