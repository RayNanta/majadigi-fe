import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../../../shared/widgets/lazy_load_states.dart';
import '../../services/khas_jatim_models.dart';
import '../../services/khas_jatim_services.dart';

class KhasJatimManuscriptsPage extends ConsumerStatefulWidget {
  const KhasJatimManuscriptsPage({super.key});

  @override
  ConsumerState<KhasJatimManuscriptsPage> createState() =>
      _KhasJatimManuscriptsPageState();
}

class _KhasJatimManuscriptsPageState
    extends ConsumerState<KhasJatimManuscriptsPage> {
  static const _pageSize = 6;

  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;

  String? _selectedKategori;
  String? _selectedAsalDaerah;
  String? _selectedPerkiraanTahun;
  String? _selectedJenisAksara;
  String? _selectedJenisBahasa;
  int _currentPage = 1;

  // ✅ Build params untuk FutureProvider.family
  KhasJatimFilterParams get _currentParams => KhasJatimFilterParams(
    search: _searchController.text.trim(),
    kategori: _selectedKategori,
    asalDaerah: _selectedAsalDaerah,
    perkiraanTahun: _selectedPerkiraanTahun,
    jenisAksara: _selectedJenisAksara,
    jenisBahasa: _selectedJenisBahasa,
  );

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() => _currentPage = 1));
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
    context.goNamed(RouteNames.homeKhasJatimMain);
  }

  void _toggleFilters() => setState(() => _showFilters = !_showFilters);

  void _applyFilters() => setState(() {
    _currentPage = 1;
    _showFilters = false;
  });

  void _resetFilters() => setState(() {
    _selectedKategori = null;
    _selectedAsalDaerah = null;
    _selectedPerkiraanTahun = null;
    _selectedJenisAksara = null;
    _selectedJenisBahasa = null;
    _currentPage = 1;
  });

  // ✅ Navigasi ke detail page dinamis dengan pass object
  void _openDetail(NaskahKunoModel item) {
    context.pushNamed(
      RouteNames.homeKhasJatimSeratSriSedana,
      extra: item,
    );
  }

  List<NaskahKunoModel> _paginated(List<NaskahKunoModel> all) {
    final start = (_currentPage - 1) * _pageSize;
    final end = math.min(start + _pageSize, all.length);
    if (start >= all.length) return [];
    return all.sublist(start, end);
  }

  int _totalPages(List<NaskahKunoModel> all) =>
      math.max(1, (all.length / _pageSize).ceil());

  @override
  Widget build(BuildContext context) {
    // ✅ FutureProvider.family dengan KhasJatimFilterParams
    final manuscriptsAsync = ref.watch(
      khasJatimManuscriptsProvider(_currentParams),
    );

    final filterPanelWidth = MediaQuery.of(context).size.width * 0.82;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
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

                // BODY — gunakan Expanded + SingleChildScrollView
                Expanded(
                  child: manuscriptsAsync.when(
                    // ✅ FIX: loading state bebas overflow — tidak pakai Expanded di dalam Column
                    loading: () => SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SearchBar(
                            controller: _searchController,
                            onFilterTap: _toggleFilters,
                          ),
                          const SizedBox(height: 24),
                          const LazyCardSkeleton(height: 460),
                          const SizedBox(height: 20),
                          const LazyCardSkeleton(height: 460),
                        ],
                      ),
                    ),
                    error: (error, _) => SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
                      child: Column(
                        children: [
                          _SearchBar(
                            controller: _searchController,
                            onFilterTap: _toggleFilters,
                          ),
                          const SizedBox(height: 24),
                          LazyLoadErrorState(
                            message: 'Gagal memuat naskah kuno. Coba lagi.',
                            onRetry: () => ref.invalidate(
                              khasJatimManuscriptsProvider,
                            ),
                          ),
                        ],
                      ),
                    ),
                    data: (allItems) {
                      final paginated = _paginated(allItems);
                      final totalPages = _totalPages(allItems);
                      final rangeStart = allItems.isEmpty
                          ? 0
                          : (_currentPage - 1) * _pageSize + 1;
                      final rangeEnd = allItems.isEmpty
                          ? 0
                          : math.min(
                          _currentPage * _pageSize, allItems.length);

                      return SingleChildScrollView(
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
                              'Menampilkan $rangeStart-$rangeEnd dari ${allItems.length} hasil',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.appMutedTextColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (allItems.isEmpty)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 36),
                                  child: Text(
                                    'Tidak ada naskah yang cocok.',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: context.appMutedTextColor,
                                    ),
                                  ),
                                ),
                              )
                            else ...[
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: paginated.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 18,
                                  mainAxisSpacing: 26,
                                  mainAxisExtent: 470,
                                ),
                                itemBuilder: (context, index) {
                                  final item = paginated[index];
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
                                onPageSelected: (page) => setState(
                                      () => _currentPage =
                                      page.clamp(1, totalPages),
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // FILTER OVERLAY
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
                  color: context.appSurfaceColor,
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
                                    color: context.appTextColor,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: _toggleFilters,
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.close_rounded),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          Expanded(
                            child: SingleChildScrollView(
                              child: manuscriptsAsync.maybeWhen(
                                data: (allItems) => Column(
                                  children: [
                                    _FilterDropdown(
                                      label: 'Kategori',
                                      value: _selectedKategori,
                                      options: allItems
                                          .map((e) => e.kategori)
                                          .toSet()
                                          .toList()
                                        ..sort(),
                                      onChanged: (v) => setState(
                                              () => _selectedKategori = v),
                                    ),
                                    _FilterDropdown(
                                      label: 'Asal Daerah',
                                      value: _selectedAsalDaerah,
                                      options: allItems
                                          .map((e) => e.asalDaerah)
                                          .toSet()
                                          .toList()
                                        ..sort(),
                                      onChanged: (v) => setState(
                                              () => _selectedAsalDaerah = v),
                                    ),
                                    _FilterDropdown(
                                      label: 'Perkiraan Tahun',
                                      value: _selectedPerkiraanTahun,
                                      options: allItems
                                          .map((e) => e.perkiraanTahun)
                                          .toSet()
                                          .toList()
                                        ..sort(),
                                      onChanged: (v) => setState(
                                              () => _selectedPerkiraanTahun = v),
                                    ),
                                    _FilterDropdown(
                                      label: 'Jenis Aksara',
                                      value: _selectedJenisAksara,
                                      options: allItems
                                          .map((e) => e.jenisAksara)
                                          .toSet()
                                          .toList()
                                        ..sort(),
                                      onChanged: (v) => setState(
                                              () => _selectedJenisAksara = v),
                                    ),
                                    _FilterDropdown(
                                      label: 'Jenis Bahasa',
                                      value: _selectedJenisBahasa,
                                      options: allItems
                                          .map((e) => e.jenisBahasa)
                                          .toSet()
                                          .toList()
                                        ..sort(),
                                      onChanged: (v) => setState(
                                              () => _selectedJenisBahasa = v),
                                    ),
                                  ],
                                ),
                                orElse: () => const SizedBox.shrink(),
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
                                  color: context.appMutedTextColor,
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

// ==================== SUB-WIDGET COMPONENTS ====================

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller, required this.onFilterTap});
  final TextEditingController controller;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? context.appSearchSurfaceColor
            : const Color(0xFFF0F1F5),
        borderRadius: BorderRadius.circular(22),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: context.appTextColor,
        ),
        decoration: InputDecoration(
          hintText: 'Cari Naskah',
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: context.appMutedTextColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 20,
          ),
          suffixIcon: IconButton(
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
  final NaskahKunoModel item;
  final VoidCallback onDetailTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ]),
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
                      item.kategori.toUpperCase(),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.judul,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    height: 1.32,
                    color: context.appTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.sumberNaskah,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                    color: context.appMutedTextColor,
                  ),
                ),
                const SizedBox(height: 16),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Lihat Detail',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ],
                    ),
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
    final visiblePages = List.generate(math.min(totalPages, 3), (i) => i + 1);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final page in visiblePages) ...[
          _PageChip(
            label: '$page',
            isSelected: currentPage == page,
            onTap: () => onPageSelected(page),
          ),
          const SizedBox(width: 12),
        ],
        _PageChip(
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

class _PageChip extends StatelessWidget {
  const _PageChip({
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
      color: isSelected
          ? AppColors.welcomeAccent
          : context.isDarkMode
          ? context.appSearchSurfaceColor
          : const Color(0xFFE7E8ED),
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
                color: isSelected ? Colors.white : context.appTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
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
              color: context.appMutedTextColor,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? context.appSearchSurfaceColor
                  : const Color(0xFFF0F1F5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                borderRadius: BorderRadius.circular(18),
                dropdownColor: context.appSurfaceColor,
                hint: Text(
                  'Pilih',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    color: context.appMutedTextColor,
                  ),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: context.appMutedTextColor,
                ),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: context.appTextColor,
                ),
                items: options
                    .map((o) => DropdownMenuItem(value: o, child: Text(o)))
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