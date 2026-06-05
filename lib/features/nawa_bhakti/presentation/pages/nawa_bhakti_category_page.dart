import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../features/home/presentation/controllers/home_services_controller.dart';
import '../../../../features/home/presentation/data/home_service_catalog.dart';
import '../../../../features/home/presentation/data/home_service_destinations.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class NawaBhaktiServiceLink {
  const NawaBhaktiServiceLink({
    required this.serviceId,
    required this.title,
    required this.subtitle,
  });

  final String serviceId;
  final String title;
  final String subtitle;
}

class NawaBhaktiCategoryPage extends StatelessWidget {
  const NawaBhaktiCategoryPage({
    super.key,
    required this.title,
    required this.imageAssetPath,
    required this.description,
    required this.services,
  });

  final String title;
  final String imageAssetPath;
  final String description;
  final List<NawaBhaktiServiceLink> services;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFFF7F9FF),
      appBar: AppBar(
        backgroundColor: AppColors.welcomeAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 28),
          child: Column(
            children: [
              ClipOval(
                child: Image.asset(
                  imageAssetPath,
                  width: 240,
                  height: 240,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/dummy_image.png',
                      width: 240,
                      height: 240,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              Text(
                description,
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  color: context.appMutedTextColor,
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: services.isEmpty
                    ? Center(
                        child: Text(
                          'Belum ada layanan yang tersedia',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: context.appMutedTextColor,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: services.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final service = services[index];
                          return _NawaBhaktiServiceCard(service: service);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NawaBhaktiServiceCard extends ConsumerWidget {
  const _NawaBhaktiServiceCard({required this.service});

  final NawaBhaktiServiceLink service;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceItem = serviceById(service.serviceId);
    final selectedServiceIds = ref.watch(homeSelectedServiceIdsProvider);

    return Material(
      color: context.appSurfaceColor,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          final routeName = routeNameForHomeServiceId(
            service.serviceId,
            isInstalled: selectedServiceIds.contains(service.serviceId),
          );
          if (routeName != null) {
            context.pushNamed(routeName);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.isDarkMode
                      ? serviceItem.accentColor.withValues(alpha: 0.16)
                      : serviceItem.badgeBackground,
                  border: serviceItem.filledBadge
                      ? null
                      : Border.all(color: context.appBorderColor),
                ),
                child: Center(
                  child: serviceItem.icon != null
                      ? Icon(
                          serviceItem.icon,
                          size: 28,
                          color: serviceItem.accentColor,
                        )
                      : Text(
                          serviceItem.badgeText ?? '',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: (serviceItem.badgeText?.length ?? 0) > 3
                                ? 18
                                : 22,
                            fontWeight: FontWeight.w800,
                            color: serviceItem.accentColor,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      service.title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: context.appTextColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      service.subtitle,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
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
