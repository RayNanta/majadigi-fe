import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/lazy_load_states.dart';

final _khasJatimManuscriptsProvider =
    FutureProvider.autoDispose<List<_ManuscriptItem>>((ref) async {
      await Future<void>.delayed(Duration.zero);
      return _KhasJatimManuscriptsPageState._manuscripts;
    });

class KhasJatimManuscriptsPage extends ConsumerStatefulWidget {
  const KhasJatimManuscriptsPage({super.key});

  @override
  ConsumerState<KhasJatimManuscriptsPage> createState() =>
      _KhasJatimManuscriptsPageState();
}

class _KhasJatimManuscriptsPageState
    extends ConsumerState<KhasJatimManuscriptsPage> {
  static const _pageSize = 6;
  static const _manuscripts = [
    _ManuscriptItem(
      title: 'Serat Sri\nSedana',
      source: 'Koleksi Museum Mpu\nTantular',
      category: 'MASA PRA ISLAM',
      region: 'Sidoarjo',
      year: 'Abad 14',
      script: 'Kawi',
      language: 'Jawa Kuno',
    ),
    _ManuscriptItem(
      title: 'Mantra Mantra\nTengger',
      source: 'Arsip Komunitas Adat\nTengger',
      category: 'PRIMBON & MANTRA',
      region: 'Probolinggo',
      year: 'Abad 18',
      script: 'Jawa',
      language: 'Jawa',
    ),
    _ManuscriptItem(
      title: 'Primbon Suku\nTengger',
      source: 'Dokumen Sejarah\nProbolinggo',
      category: 'ERA KERAJAAN',
      region: 'Probolinggo',
      year: 'Abad 17',
      script: 'Pegon',
      language: 'Jawa',
    ),
    _ManuscriptItem(
      title: 'Serat Centhini\nJilid II',
      source: 'Salinan Naskah\nPonorogo',
      category: 'SERAT',
      region: 'Ponorogo',
      year: 'Abad 19',
      script: 'Latin',
      language: 'Jawa',
    ),
    _ManuscriptItem(
      title: 'Kakawin\nSutasoma',
      source: 'Fragmentasi Naskah\nTrowulan',
      category: 'MASA PRA ISLAM',
      region: 'Mojokerto',
      year: 'Abad 14',
      script: 'Kawi',
      language: 'Jawa Kuno',
    ),
    _ManuscriptItem(
      title: 'Serat Panji\nAngreni',
      source: 'Koleksi Keraton\nSumenep',
      category: 'ERA KERAJAAN',
      region: 'Sumenep',
      year: 'Abad 18',
      script: 'Jawa',
      language: 'Jawa',
    ),
    _ManuscriptItem(
      title: 'Babad\nBlambangan',
      source: 'Arsip Banyuwangi\nHeritage',
      category: 'ERA KERAJAAN',
      region: 'Banyuwangi',
      year: 'Abad 18',
      script: 'Jawa',
      language: 'Jawa',
    ),
    _ManuscriptItem(
      title: 'Primbon\nBetaljemur',
      source: 'Koleksi Pustaka\nMataraman',
      category: 'PRIMBON & MANTRA',
      region: 'Madiun',
      year: 'Abad 19',
      script: 'Pegon',
      language: 'Jawa',
    ),
    _ManuscriptItem(
      title: 'Serat Wulangreh',
      source: 'Salinan Pesantren\nJombang',
      category: 'SERAT',
      region: 'Jombang',
      year: 'Abad 19',
      script: 'Arab Pegon',
      language: 'Jawa',
    ),
    _ManuscriptItem(
      title: 'Kidung\nTantu Panggelaran',
      source: 'Naskah Arkeologi\nMalang',
      category: 'MASA PRA ISLAM',
      region: 'Malang',
      year: 'Abad 15',
      script: 'Kawi',
      language: 'Jawa Kuno',
    ),
    _ManuscriptItem(
      title: 'Serat Damar\nWulan',
      source: 'Koleksi Kadipaten\nMadura',
      category: 'SERAT',
      region: 'Pamekasan',
      year: 'Abad 18',
      script: 'Jawa',
      language: 'Madura',
    ),
    _ManuscriptItem(
      title: 'Mantra Tolak\nBala',
      source: 'Dokumen Komunitas\nOsing',
      category: 'PRIMBON & MANTRA',
      region: 'Banyuwangi',
      year: 'Abad 17',
      script: 'Latin',
      language: 'Osing',
    ),
    _ManuscriptItem(
      title: 'Babad Arya\nWiraraja',
      source: 'Koleksi Daerah\nSumenep',
      category: 'ERA KERAJAAN',
      region: 'Sumenep',
      year: 'Abad 16',
      script: 'Jawa',
      language: 'Jawa',
    ),
    _ManuscriptItem(
      title: 'Serat Wirid\nHidayat Jati',
      source: 'Salinan Pondok\nKediri',
      category: 'SERAT',
      region: 'Kediri',
      year: 'Abad 19',
      script: 'Arab Pegon',
      language: 'Jawa',
    ),
    _ManuscriptItem(
      title: 'Kakawin\nRamayana',
      source: 'Koleksi Arkeologi\nMojokerto',
      category: 'MASA PRA ISLAM',
      region: 'Mojokerto',
      year: 'Abad 15',
      script: 'Kawi',
      language: 'Jawa Kuno',
    ),
    _ManuscriptItem(
      title: 'Primbon\nPawukon',
      source: 'Perpustakaan\nSurabaya',
      category: 'PRIMBON & MANTRA',
      region: 'Surabaya',
      year: 'Abad 18',
      script: 'Jawa',
      language: 'Jawa',
    ),
    _ManuscriptItem(
      title: 'Serat Menak\nJawa Timur',
      source: 'Koleksi Museum\nLamongan',
      category: 'SERAT',
      region: 'Lamongan',
      year: 'Abad 19',
      script: 'Latin',
      language: 'Jawa',
    ),
    _ManuscriptItem(
      title: 'Babad\nMajapahit',
      source: 'Arsip Sejarah\nTrowulan',
      category: 'ERA KERAJAAN',
      region: 'Mojokerto',
      year: 'Abad 16',
      script: 'Jawa',
      language: 'Jawa',
    ),
  ];

  late final TextEditingController _searchController;
  bool _showFilters = false;
  String? _selectedCategory;
  String? _selectedRegion;
  String? _selectedYear;
  String? _selectedScript;
  String? _selectedLanguage;
  int _currentPage = 1;

  List<String> _categories(List<_ManuscriptItem> manuscripts) =>
      manuscripts.map((item) => item.category).toSet().toList()..sort();

  List<String> _regions(List<_ManuscriptItem> manuscripts) =>
      manuscripts.map((item) => item.region).toSet().toList()..sort();

  List<String> _years(List<_ManuscriptItem> manuscripts) =>
      manuscripts.map((item) => item.year).toSet().toList()..sort();

  List<String> _scripts(List<_ManuscriptItem> manuscripts) =>
      manuscripts.map((item) => item.script).toSet().toList()..sort();

  List<String> _languages(List<_ManuscriptItem> manuscripts) =>
      manuscripts.map((item) => item.language).toSet().toList()..sort();

  List<_ManuscriptItem> _filteredItems(List<_ManuscriptItem> manuscripts) {
    final query = _searchController.text.trim().toLowerCase();

    return manuscripts.where((item) {
      final matchesQuery =
          query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.source.toLowerCase().contains(query) ||
          item.region.toLowerCase().contains(query);

      final matchesCategory =
          _selectedCategory == null || item.category == _selectedCategory;
      final matchesRegion =
          _selectedRegion == null || item.region == _selectedRegion;
      final matchesYear = _selectedYear == null || item.year == _selectedYear;
      final matchesScript =
          _selectedScript == null || item.script == _selectedScript;
      final matchesLanguage =
          _selectedLanguage == null || item.language == _selectedLanguage;

      return matchesQuery &&
          matchesCategory &&
          matchesRegion &&
          matchesYear &&
          matchesScript &&
          matchesLanguage;
    }).toList();
  }

  int _totalPages(List<_ManuscriptItem> filteredItems) =>
      math.max(1, (filteredItems.length / _pageSize).ceil());

  List<_ManuscriptItem> _currentItems(List<_ManuscriptItem> filteredItems) {
    final start = (_currentPage - 1) * _pageSize;
    final end = math.min(start + _pageSize, filteredItems.length);

    if (start >= filteredItems.length) {
      return const [];
    }

    return filteredItems.sublist(start, end);
  }

  int _rangeStart(List<_ManuscriptItem> filteredItems) =>
      filteredItems.isEmpty ? 0 : ((_currentPage - 1) * _pageSize) + 1;

  int _rangeEnd(List<_ManuscriptItem> filteredItems) => filteredItems.isEmpty
      ? 0
      : math.min(_currentPage * _pageSize, filteredItems.length);

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()
      ..addListener(_handleSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_handleSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _handleSearchChanged() {
    setState(() {
      _currentPage = 1;
    });
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeKhasJatimMain);
  }

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
  }

  void _applyFilters() {
    setState(() {
      _currentPage = 1;
      _showFilters = false;
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedCategory = null;
      _selectedRegion = null;
      _selectedYear = null;
      _selectedScript = null;
      _selectedLanguage = null;
      _currentPage = 1;
    });
  }

  void _openDetail(_ManuscriptItem item) {
    if (item.title == 'Serat Sri\nSedana') {
      context.pushNamed(RouteNames.homeKhasJatimSeratSriSedana);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Detail ${item.title.replaceAll('\n', ' ')} akan segera tersedia.',
        ),
      ),
    );
  }

  void _changePage(int page) {
    final manuscripts = ref
        .read(_khasJatimManuscriptsProvider)
        .maybeWhen(
          data: (items) => items,
          orElse: () => const <_ManuscriptItem>[],
        );
    final totalPages = _totalPages(_filteredItems(manuscripts));

    setState(() {
      _currentPage = page.clamp(1, totalPages).toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    final manuscriptsAsync = ref.watch(_khasJatimManuscriptsProvider);
    final manuscripts = manuscriptsAsync.maybeWhen(
      data: (items) => items,
      orElse: () => const <_ManuscriptItem>[],
    );
    final filteredItems = _filteredItems(manuscripts);
    final currentItems = _currentItems(filteredItems);
    final totalPages = _totalPages(filteredItems);
    final isInitialLoading = manuscriptsAsync.isLoading && manuscripts.isEmpty;
    final loadError = manuscriptsAsync.hasError && manuscripts.isEmpty;
    final filterPanelWidth = MediaQuery.of(context).size.width * 0.82;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
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
                          'Naskah Kuno Jawa Timur',
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
                    padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SearchBar(
                          controller: _searchController,
                          onFilterTap: _toggleFilters,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          isInitialLoading
                              ? 'Memuat naskah kuno...'
                              : 'Menampilkan ${_rangeStart(filteredItems)}-${_rangeEnd(filteredItems)} dari ${filteredItems.length} hasil',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8A8F9C),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (isInitialLoading) ...[
                          const LazyCardSkeleton(height: 458),
                          const SizedBox(height: 26),
                          const LazyCardSkeleton(height: 458),
                        ] else if (loadError) ...[
                          LazyLoadErrorState(
                            message:
                                'Data naskah kuno belum berhasil dimuat. Silakan coba lagi.',
                            onRetry: () =>
                                ref.invalidate(_khasJatimManuscriptsProvider),
                          ),
                        ] else ...[
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: currentItems.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 18,
                                  mainAxisSpacing: 26,
                                  mainAxisExtent: 458,
                                ),
                            itemBuilder: (context, index) {
                              final item = currentItems[index];

                              return _ManuscriptCard(
                                item: item,
                                onDetailTap: () => _openDetail(item),
                              );
                            },
                          ),
                          const SizedBox(height: 26),
                          _PaginationBar(
                            currentPage: _currentPage,
                            totalPages: totalPages,
                            onPageSelected: _changePage,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_showFilters)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _toggleFilters,
                  child: Container(color: Colors.transparent),
                ),
              ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              top: 0,
              bottom: 0,
              right: _showFilters ? 0 : -filterPanelWidth,
              width: filterPanelWidth,
              child: IgnorePointer(
                ignoring: !_showFilters,
                child: Material(
                  color: Colors.white,
                  elevation: 24,
                  child: SafeArea(
                    left: false,
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 26, 28, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Filter Pencarian',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF2E3038),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: _toggleFilters,
                                style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(32, 32),
                                ),
                                icon: const Icon(Icons.close_rounded),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _FilterField(
                                    label: 'Kategori',
                                    value: _selectedCategory,
                                    options: _categories(manuscripts),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCategory = value;
                                      });
                                    },
                                  ),
                                  _FilterField(
                                    label: 'Asal Daerah',
                                    value: _selectedRegion,
                                    options: _regions(manuscripts),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedRegion = value;
                                      });
                                    },
                                  ),
                                  _FilterField(
                                    label: 'Tahun Penulisan',
                                    value: _selectedYear,
                                    options: _years(manuscripts),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedYear = value;
                                      });
                                    },
                                  ),
                                  _FilterField(
                                    label: 'Aksara',
                                    value: _selectedScript,
                                    options: _scripts(manuscripts),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedScript = value;
                                      });
                                    },
                                  ),
                                  _FilterField(
                                    label: 'Bahasa',
                                    value: _selectedLanguage,
                                    options: _languages(manuscripts),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedLanguage = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: FilledButton(
                              onPressed: _applyFilters,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.welcomeAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: Text(
                                'Terapkan Filter',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: TextButton(
                              onPressed: _resetFilters,
                              child: Text(
                                'Reset Filter',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF4E5565),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller, required this.onFilterTap});

  final TextEditingController controller;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1F5),
        borderRadius: BorderRadius.circular(22),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2E3038),
        ),
        decoration: InputDecoration(
          hintText: 'Cari Naskah',
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF8A8F9C),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 20,
          ),
          suffixIcon: IconButton(
            key: const Key('khas-jatim-filter-button'),
            onPressed: onFilterTap,
            icon: const Icon(
              Icons.filter_list_rounded,
              color: AppColors.welcomeAccent,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}

class _ManuscriptCard extends StatelessWidget {
  const _ManuscriptCard({required this.item, required this.onDetailTap});

  final _ManuscriptItem item;
  final VoidCallback onDetailTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 210,
                  child: Image.asset(
                    'assets/images/dummy_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF27C36D),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      item.category,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.32,
                      color: const Color(0xFF2C2F38),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.source,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.45,
                      color: const Color(0xFF9AA0AE),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: FilledButton(
                      onPressed: onDetailTap,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.welcomeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lihat Detail',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                              color: Colors.white,
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
        ],
      ),
    );
  }
}

class _PaginationBar extends StatelessWidget {
  const _PaginationBar({
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
  });

  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageSelected;

  @override
  Widget build(BuildContext context) {
    final visiblePages = List.generate(
      math.min(totalPages, 3),
      (index) => index + 1,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final page in visiblePages) ...[
          _PaginationChip(
            label: '$page',
            isSelected: currentPage == page,
            onTap: () => onPageSelected(page),
          ),
          const SizedBox(width: 12),
        ],
        _PaginationChip(
          label: '›',
          isSelected: false,
          onTap: currentPage < totalPages
              ? () => onPageSelected(currentPage + 1)
              : null,
        ),
      ],
    );
  }
}

class _PaginationChip extends StatelessWidget {
  const _PaginationChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.welcomeAccent : const Color(0xFFE7E8ED),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 46,
          height: 46,
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : const Color(0xFF4A4E57),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterField extends StatelessWidget {
  const _FilterField({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF808694),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1F5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                borderRadius: BorderRadius.circular(18),
                dropdownColor: Colors.white,
                hint: Text(
                  'Pilih',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF666C78),
                  ),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF666C78),
                ),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2E3038),
                ),
                items: options
                    .map(
                      (option) => DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      ),
                    )
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ManuscriptItem {
  const _ManuscriptItem({
    required this.title,
    required this.source,
    required this.category,
    required this.region,
    required this.year,
    required this.script,
    required this.language,
  });

  final String title;
  final String source;
  final String category;
  final String region;
  final String year;
  final String script;
  final String language;
}
