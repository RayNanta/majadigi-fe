import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <--- 1. IMPOR UTAMA UNTUK MEMBACA DATA LOKAL

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../controllers/home_services_controller.dart';
import '../data/home_service_catalog.dart';
import '../data/home_service_destinations.dart';
import '../models/home_service_item.dart';
import '../widgets/home_bottom_navigation_bar.dart';

// ✅ DEKLARASI CLASS MODEL PEMBANTU DIATAS AGAR BISA DIBACA OLEH DATA STATIS VARIABEL
class HomeStatItem {
  const HomeStatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.accentColor,
    required this.iconBackground,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color accentColor;
  final Color iconBackground;
}

class HomeNewsItem {
  const HomeNewsItem({
    required this.title,
    required this.tag,
    required this.icon,
    required this.startColor,
    required this.endColor,
  });

  final String title;
  final String tag;
  final IconData icon;
  final Color startColor;
  final Color endColor;
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  static const _addTile = HomeServiceItem(
    id: '__add__',
    title: 'Tambah',
    category: 'Menu',
    icon: Icons.add_rounded,
    accentColor: AppColors.welcomeAccent,
    badgeBackground: Color(0xFFE6F0FF),
    filledBadge: true,
  );

  static const _moreTile = HomeServiceItem(
    id: '__more__',
    title: 'Lainnya',
    category: 'Menu',
    icon: Icons.grid_view_rounded,
    accentColor: AppColors.welcomeAccent,
    badgeBackground: Color(0xFFE6F0FF),
    filledBadge: true,
  );

  static const _stats = <HomeStatItem>[
    HomeStatItem(
      title: 'Jumlah Penduduk',
      value: '42.089.271',
      icon: Icons.groups_2_rounded,
      accentColor: AppColors.welcomeAccent,
      iconBackground: Color(0xFFEFF5FF),
    ),
    HomeStatItem(
      title: 'Pertumbuhan Penduduk',
      value: '0,73%',
      icon: Icons.trending_up_rounded,
      accentColor: Color(0xFF2563EB),
      iconBackground: Color(0xFFF2FAEE),
    ),
  ];

  static const _newsItems = <HomeNewsItem>[
    HomeNewsItem(
      title:
      'Gubernur Khofifah Buka Ajang Talenta Prestasi Murid Jawa Timur 2026',
      tag: 'Pemprov Jatim',
      icon: Icons.campaign_rounded,
      startColor: Color(0xFFD4B08A),
      endColor: Color(0xFF8D5E37),
    ),
    HomeNewsItem(
      title:
      'KONI Jatim Mulai Seleksi Atlet Unggulan untuk Persiapan PON XXI Tahun Depan',
      tag: 'Olahraga',
      icon: Icons.emoji_events_rounded,
      startColor: Color(0xFFF8E7C4),
      endColor: Color(0xFFF4BE45),
    ),
    HomeNewsItem(
      title:
      'Khofifah Dorong Beasiswa dan Kolaborasi untuk Mahasiswa Jawa Timur',
      tag: 'Pendidikan',
      icon: Icons.school_rounded,
      startColor: Color(0xFFD7E8FF),
      endColor: Color(0xFF6AA3FF),
    ),
  ];

  // 🔄 FUNGSI ASYNC DIUBAH MENJADI FUTURE AGAR DIKONSUMSI OLEH FUTUREBUILDER DI BAWAH
  Future<String> _fetchLocalName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_real_name') ?? "User Majadigi";
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showComingSoon(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleCatalogServiceAdded(String id) {
    ref.read(homeSelectedServiceIdsProvider.notifier).addService(id);
  }

  Future<void> _openServiceCatalogBottomSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.36),
      builder: (context) {
        return _ServiceCatalogBottomSheet(
          services: allCatalogServices,
          selectedServiceIds: ref.read(homeSelectedServiceIdsProvider),
          onAddService: _handleCatalogServiceAdded,
        );
      },
    );
  }

  void _handleMyServiceTap(HomeServiceItem item) {
    if (item.id == _addTile.id) {
      _openServiceCatalogBottomSheet();
      return;
    }

    if (item.id == _moreTile.id) {
      context.pushNamed(RouteNames.homeMyServices);
      return;
    }

    final routeName = routeNameForHomeServiceId(item.id);
    if (routeName != null) {
      context.pushNamed(routeName);
      return;
    }

    _showComingSoon('${item.displayTitle} akan segera tersedia.');
  }

  @override
  Widget build(BuildContext context) {
    final recommendedServices = ref.watch(homeRecommendedServicesProvider);
    final selectedServices = ref.watch(homeSelectedServicesProvider);
    final myServices = [_addTile, ...selectedServices, _moreTile];

    // ✅ REASSURE UTUH: Menggunakan FutureBuilder tepat di atas Scaffold agar layout visual tidak bergeser/berubah 1 milimeter pun!
    return FutureBuilder<String>(
      future: _fetchLocalName(),
      builder: (context, snapshot) {
        // Mengambil nama dinamis akun aktif, jika proses baca delay pakai teks "Memuat..."
        final dynamicName = snapshot.data ?? "Memuat...";

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _HomeHeader(
                  userName: dynamicName, // <--- AKURAT & REAL-TIME MENGIKUTI AKUN YANG DI-INPUTKAN
                  searchController: _searchController,
                  onSearchTap: () {
                    _showComingSoon('Pencarian layanan akan segera tersedia.');
                  },
                  onNotificationTap: () {
                    _showComingSoon('Notifikasi akan segera tersedia.');
                  },
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _SectionTitle(
                                title: 'Mungkin Anda Butuh (Rekomendasi AI)',
                              ),
                              const SizedBox(height: 24),
                              _HomeServiceGrid(
                                items: recommendedServices,
                                onTap: (item) {
                                  _showComingSoon(
                                    '${item.displayTitle} akan segera tersedia.',
                                  );
                                },
                              ),
                              const SizedBox(height: 40),
                              const _SectionTitle(title: 'Layanan Saya'),
                              const SizedBox(height: 24),
                              _HomeServiceGrid(
                                items: myServices,
                                onTap: _handleMyServiceTap,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: ColoredBox(
                          color: Color(0xFFF2F4FB),
                          child: SizedBox(height: 16),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const _SectionTitle(title: 'Jawa Timur dalam Angka'),
                              const SizedBox(height: 20),
                              Row(
                                children: _stats
                                    .map(
                                      (stat) => Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: stat == _stats.first ? 12 : 0,
                                      ),
                                      child: _StatCard(item: stat),
                                    ),
                                  ),
                                )
                                    .toList(),
                              ),
                              const SizedBox(height: 40),
                              const _SectionTitle(title: 'Berita Jawa Timur'),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 248,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _newsItems.length,
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(width: 18),
                                  itemBuilder: (context, index) {
                                    final item = _newsItems[index];

                                    return _NewsCard(
                                      item: item,
                                      onTap: () {
                                        _showComingSoon(
                                          'Detail berita akan segera tersedia.',
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: HomeBottomNavigationBar(
            selectedIndex: 0,
            onTap: (index) {
              if (index == 0) {
                return;
              }

              if (index == 1) {
                context.goNamed(RouteNames.homeServices);
                return;
              }

              context.goNamed(RouteNames.homeProfile);
            },
          ),
        );
      },
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    required this.userName,
    required this.searchController,
    required this.onSearchTap,
    required this.onNotificationTap,
  });

  final String userName;
  final TextEditingController searchController;
  final VoidCallback onSearchTap;
  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 252,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 180,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1668F7), Color(0xFF0F52D2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(42)),
            ),
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 26),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 66,
                  height: 66,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.18),
                    ),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat datang',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.92),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Kota Malang',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    IconButton(
                      onPressed: onNotificationTap,
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.white,
                        minimumSize: const Size(40, 40),
                        padding: EdgeInsets.zero,
                      ),
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        size: 34,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 0,
            child: Material(
              color: Colors.white,
              elevation: 2,
              shadowColor: const Color(0xFF0F172A).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(36),
              child: TextField(
                controller: searchController,
                readOnly: true,
                onTap: onSearchTap,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2F3136),
                ),
                decoration: InputDecoration(
                  hintText: 'Cari layanan',
                  hintStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textMuted,
                  ),
                  suffixIcon: IconButton(
                    onPressed: onSearchTap,
                    icon: const Icon(
                      Icons.search_rounded,
                      size: 36,
                      color: Color(0xFF8C9096),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 24,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: const BorderSide(
                      color: Color(0xFFACAFB6),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: const BorderSide(
                      color: AppColors.welcomeAccent,
                      width: 2.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF303236),
      ),
    );
  }
}

class _HomeServiceGrid extends StatelessWidget {
  const _HomeServiceGrid({required this.items, required this.onTap});

  final List<HomeServiceItem> items;
  final ValueChanged<HomeServiceItem> onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 26,
        crossAxisSpacing: 14,
        childAspectRatio: 0.66,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return _HomeServiceTile(item: item, onTap: () => onTap(item));
      },
    );
  }
}

class _HomeServiceTile extends StatelessWidget {
  const _HomeServiceTile({required this.item, required this.onTap});

  final HomeServiceItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Column(
        children: [
          _ServiceBadge(
            item: item,
            size: 82,
            badgeFontSize: item.badgeText != null && item.badgeText!.length > 3
                ? 20
                : 24,
            iconSize: item.filledBadge ? 44 : 34,
          ),
          const SizedBox(height: 14),
          Expanded(
            child: Text(
              item.title,
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.25,
                color: const Color(0xFF3A3D42),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCatalogBottomSheet extends StatefulWidget {
  const _ServiceCatalogBottomSheet({
    required this.services,
    required this.selectedServiceIds,
    required this.onAddService,
  });

  final List<HomeServiceItem> services;
  final Set<String> selectedServiceIds;
  final ValueChanged<String> onAddService;

  @override
  State<_ServiceCatalogBottomSheet> createState() =>
      _ServiceCatalogBottomSheetState();
}

class _ServiceCatalogBottomSheetState
    extends State<_ServiceCatalogBottomSheet> {
  late final TextEditingController _searchController;
  late final Set<String> _selectedIds;

  HomeCatalogTab _selectedTab = HomeCatalogTab.services;

  List<HomeServiceItem> get _visibleServices {
    final query = _searchController.text.trim().toLowerCase();

    return widget.services.where((service) {
      if (service.catalogTab != _selectedTab) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      return service.displayTitle.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _selectedIds = Set<String>.from(widget.selectedServiceIds);
    _searchController = TextEditingController()..addListener(_refreshState);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refreshState)
      ..dispose();
    super.dispose();
  }

  void _refreshState() {
    setState(() {});
  }

  void _handleAddService(HomeServiceItem service) {
    if (_selectedIds.contains(service.id)) {
      return;
    }

    setState(() {
      _selectedIds.add(service.id);
    });
    widget.onAddService(service.id);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return FractionallySizedBox(
      heightFactor: 0.78,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF7F9FF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 92,
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCBCDD4),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    'Katalog Layanan',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(36),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2F3136),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Cari layanan',
                        hintStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textMuted,
                        ),
                        suffixIcon: const Icon(
                          Icons.search_rounded,
                          size: 36,
                          color: Color(0xFF8C9096),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 24,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(36),
                          borderSide: const BorderSide(
                            color: Color(0xFFACAFB6),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(36),
                          borderSide: const BorderSide(
                            color: AppColors.welcomeAccent,
                            width: 2.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 34),
                  Row(
                    children: [
                      Expanded(
                        child: _CatalogTabButton(
                          label: 'Layanan',
                          isSelected: _selectedTab == HomeCatalogTab.services,
                          onTap: () {
                            setState(() {
                              _selectedTab = HomeCatalogTab.services;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: _CatalogTabButton(
                          label: 'Nawa Bhakti Satya',
                          isSelected: _selectedTab == HomeCatalogTab.nawaBhakti,
                          onTap: () {
                            setState(() {
                              _selectedTab = HomeCatalogTab.nawaBhakti;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    children: [
                      Container(height: 2, color: const Color(0xFFACAFB6)),
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 180),
                        alignment: _selectedTab == HomeCatalogTab.services
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: 0.5,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.welcomeAccent,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  Expanded(
                    child: _visibleServices.isEmpty
                        ? Center(
                      child: Text(
                        'Layanan tidak ditemukan.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMuted,
                        ),
                      ),
                    )
                        : GridView.builder(
                      padding: const EdgeInsets.only(bottom: 12),
                      itemCount: _visibleServices.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 28,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.56,
                      ),
                      itemBuilder: (context, index) {
                        final service = _visibleServices[index];

                        return _CatalogServiceTile(
                          item: service,
                          isAdded: _selectedIds.contains(service.id),
                          onAdd: () => _handleAddService(service),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CatalogTabButton extends StatelessWidget {
  const _CatalogTabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? AppColors.welcomeAccent
                : const Color(0xFF9A9DA5),
          ),
        ),
      ),
    );
  }
}

class _CatalogServiceTile extends StatelessWidget {
  const _CatalogServiceTile({
    required this.item,
    required this.isAdded,
    required this.onAdd,
  });

  final HomeServiceItem item;
  final bool isAdded;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ServiceBadge(
          item: item,
          size: 86,
          badgeFontSize: item.badgeText != null && item.badgeText!.length > 3
              ? 20
              : 24,
          iconSize: 34,
        ),
        const SizedBox(height: 14),
        Text(
          item.title,
          maxLines: 3,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.25,
            color: const Color(0xFF111111),
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: isAdded ? null : onAdd,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  isAdded ? 'Ditambahkan' : '+ Tambah',
                  maxLines: 1,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isAdded
                        ? const Color(0xFF0F766E)
                        : AppColors.welcomeAccent,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ServiceBadge extends StatelessWidget {
  const _ServiceBadge({
    required this.item,
    required this.size,
    required this.badgeFontSize,
    required this.iconSize,
  });

  final HomeServiceItem item;
  final double size;
  final double badgeFontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: item.badgeBackground,
        border: item.filledBadge
            ? null
            : Border.all(color: const Color(0xFFF0F1F4)),
        boxShadow: item.filledBadge
            ? []
            : [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: item.icon != null
            ? Icon(item.icon, size: iconSize, color: item.accentColor)
            : Text(
          item.badgeText!,
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: badgeFontSize,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: item.accentColor,
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.item});

  final HomeStatItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF5FF),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item.iconBackground,
            ),
            child: Icon(item.icon, color: item.accentColor, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF3A3D42),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.value,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: item.accentColor,
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

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.item, required this.onTap});

  final HomeNewsItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 286,
      child: InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [item.startColor, item.endColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -12,
                      bottom: -18,
                      child: CircleAvatar(
                        radius: 56,
                        backgroundColor: Colors.white.withValues(alpha: 0.18),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      top: 18,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          item.tag,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      bottom: 18,
                      child: Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.18),
                        ),
                        child: Icon(item.icon, size: 34, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.35,
                color: const Color(0xFF303236),
              ),
            ),
          ],
        ),
      ),
    );
  }
}