import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../routes.dart';
import '../controllers/home_services_controller.dart';
import '../data/home_service_destinations.dart';
import '../models/home_service_item.dart';

class ServiceListPage extends ConsumerStatefulWidget {
  const ServiceListPage({super.key});

  @override
  ConsumerState<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends ConsumerState<ServiceListPage> {
  late final TextEditingController _searchController;

  List<HomeServiceItem> _filterServices(List<HomeServiceItem> services) {
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return services;
    }

    return services.where((service) {
      final subtitle = service.subtitle?.toLowerCase() ?? '';
      return service.displayTitle.toLowerCase().contains(query) ||
          subtitle.contains(query);
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

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.go(HomeRoutes.path);
  }

  void _handleServiceTap(HomeServiceItem item) {
    final routeName = routeNameForHomeServiceId(item.id);
    if (routeName != null) {
      context.pushNamed(routeName);
      return;
    }

    _showComingSoon('${item.displayTitle} akan segera tersedia.');
  }

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(homeSelectedServicesProvider);
    final visibleServices = _filterServices(services);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1668F7), Color(0xFF0F52D2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(18, 22, 24, 26),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _handleBack,
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
                      'Daftar Layanan Saya',
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                      child: Material(
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
                              size: 34,
                              color: Color(0xFF8C9096),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 22,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(36),
                              borderSide: const BorderSide(
                                color: Color(0xFFD8DAE0),
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
                  ),
                  if (visibleServices.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            services.isEmpty
                                ? 'Belum ada layanan yang ditambahkan.'
                                : 'Layanan yang kamu cari belum ditemukan.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final serviceIndex = index ~/ 2;

                          if (index.isOdd) {
                            return const SizedBox(height: 18);
                          }

                          return _ServiceListCard(
                            item: visibleServices[serviceIndex],
                            onTap: () => _handleServiceTap(
                              visibleServices[serviceIndex],
                            ),
                          );
                        }, childCount: visibleServices.length * 2 - 1),
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

class _ServiceListCard extends StatelessWidget {
  const _ServiceListCard({required this.item, required this.onTap});

  final HomeServiceItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF111827).withValues(alpha: 0.04),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              _ServiceListBadge(item: item),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.displayTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.subtitle ?? 'Pemerintah Provinsi Jawa Timur',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
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

class _ServiceListBadge extends StatelessWidget {
  const _ServiceListBadge({required this.item});

  final HomeServiceItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: item.badgeBackground,
        border: Border.all(color: const Color(0xFFF0F1F4)),
      ),
      child: Center(
        child: item.icon != null
            ? Icon(item.icon, size: 34, color: item.accentColor)
            : Text(
                item.badgeText!,
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: item.badgeText!.length > 3 ? 18 : 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: item.accentColor,
                ),
              ),
      ),
    );
  }
}
