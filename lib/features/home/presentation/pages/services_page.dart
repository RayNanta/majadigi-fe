import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/extensions/responsive_extension.dart';
import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../controllers/home_services_controller.dart';
import '../data/home_service_catalog.dart';
import '../data/home_service_destinations.dart';
import '../models/home_service_item.dart';
import '../widgets/home_bottom_navigation_bar.dart';

class ServicesPage extends ConsumerStatefulWidget {
  const ServicesPage({super.key});

  @override
  ConsumerState<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends ConsumerState<ServicesPage> {
  late final TextEditingController _searchController;
  String? _selectedCategory;

  List<HomeServiceItem> get _visibleServices {
    final query = _searchController.text.trim().toLowerCase();

    return layananCatalogServices.where((service) {
      final matchesCategory =
          _selectedCategory == null || service.category == _selectedCategory;
      final matchesQuery =
          query.isEmpty ||
          service.displayTitle.toLowerCase().contains(query) ||
          (service.subtitle?.toLowerCase().contains(query) ?? false);

      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
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

  void _showComingSoon(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleBottomNavTap(int index) {
    if (index == 0) {
      context.goNamed(RouteNames.home);
      return;
    }

    if (index == 2) {
      context.goNamed(RouteNames.homeProfile);
    }
  }

  void _handleServiceTap(HomeServiceItem service, bool isInstalled) {
    if (!isInstalled) {
      ref.read(homeSelectedServiceIdsProvider.notifier).addService(service.id);
      return;
    }

    final routeName = routeNameForHomeServiceId(service.id);
    if (routeName != null) {
      context.pushNamed(routeName);
      return;
    }

    _showComingSoon('${service.displayTitle} akan segera tersedia.');
  }

  @override
  Widget build(BuildContext context) {
    final selectedServiceIds = ref.watch(homeSelectedServiceIdsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _ServicesHeader(searchController: _searchController),
            const SizedBox(height: 14),
            SizedBox(
              height: 58,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemCount: layananCategories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final category = layananCategories[index];
                  final isSelected = category == _selectedCategory;

                  return _CategoryChip(
                    label: category,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedCategory = isSelected ? null : category;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 22),
            Expanded(
              child: _visibleServices.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Layanan untuk pencarian atau kategori ini belum tersedia.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                      itemCount: _visibleServices.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: context.isDesktop
                            ? 6
                            : context.isTablet
                            ? 5
                            : 4,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.58,
                      ),
                      itemBuilder: (context, index) {
                        final service = _visibleServices[index];
                        final isInstalled = selectedServiceIds.contains(
                          service.id,
                        );

                        return _ServicesCatalogTile(
                          item: service,
                          isInstalled: isInstalled,
                          onTap: () => _handleServiceTap(service, isInstalled),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        selectedIndex: 1,
        onTap: _handleBottomNavTap,
      ),
    );
  }
}

class _ServicesHeader extends StatelessWidget {
  const _ServicesHeader({required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 222,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 154,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1668F7), Color(0xFF0F52D2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(42)),
            ),
            alignment: Alignment.center,
            child: Text(
              'Layanan',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
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
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
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
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE7F0FF) : const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(999),
          border: isSelected
              ? Border.all(color: const Color(0xFFB7D0FF))
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? AppColors.welcomeAccent
                : const Color(0xFF3B3E45),
          ),
        ),
      ),
    );
  }
}

class _ServicesCatalogTile extends StatelessWidget {
  const _ServicesCatalogTile({
    required this.item,

    required this.isInstalled,
    required this.onTap,
  });

  final HomeServiceItem item;
  final bool isInstalled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final badgeSize = constraints.maxWidth * 0.78;

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ServiceBadge(
                item: item,
                size: badgeSize,
              ),

              const SizedBox(height: 8),

              Text(
                item.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.25,
                  color: const Color(0xFF111111),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                isInstalled ? '✓ Terpasang' : '+ Tambah',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isInstalled
                      ? const Color(0xFF22B56B)
                      : AppColors.welcomeAccent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

extension on Text {
  Widget wrapWithFitted() {
    return SizedBox(
      width: double.infinity,
      child: FittedBox(fit: BoxFit.scaleDown, child: this),
    );
  }
}

class _ServiceBadge extends StatelessWidget {
  const _ServiceBadge({
    required this.item,
    required this.size,
  });

  final HomeServiceItem item;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: item.badgeBackground,
        border: Border.all(color: const Color(0xFFF0F1F4)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: item.icon != null
            ? Icon(item.icon, size: size * 0.42, color: item.accentColor)
            : Text(
                item.badgeText!,
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size * 0.25,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: item.accentColor,
                ),
              ),
      ),
    );
  }
}
