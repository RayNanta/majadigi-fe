import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:majadigi_mobile/features/auth/models/user_model.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../auth/services/auth_service.dart';
import '../../../../shared/theme/app_theme_controller.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../models/profile_data.dart';
import '../widgets/home_bottom_navigation_bar.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  static const _accountSecurityItems = [
    _ProfileMenuItem(
      label: 'Data Diri',
      icon: Icons.person_outline_rounded,
      routeName: RouteNames.homePersonalData,
      message: 'Buka halaman data diri.',
    ),
    _ProfileMenuItem(
      label: 'Ubah Kata Sandi',
      icon: Icons.lock_outline_rounded,
      routeName: RouteNames.homeChangePassword,
      message: 'Buka halaman ubah kata sandi.',
    ),
  ];

  static const _informationItems = [
    _ProfileMenuItem(
      label: 'Tentang Jawa Timur',
      icon: Icons.location_on_outlined,
      routeName: RouteNames.homeAboutJatim,
      message: 'Buka halaman tentang Jawa Timur.',
    ),
    _ProfileMenuItem(
      label: 'Ganti Bahasa',
      icon: Icons.language_rounded,
      routeName: RouteNames.homeChangeLanguage,
      message: 'Buka halaman ganti bahasa.',
    ),
    _ProfileMenuItem(
      label: 'Tentang Majadigi',
      icon: Icons.info_outline_rounded,
      routeName: RouteNames.homeAboutMajadigi,
      message: 'Buka halaman tentang Majadigi.',
    ),
    _ProfileMenuItem(
      label: 'Beri Rating',
      icon: Icons.star_outline_rounded,
      message: 'Fitur rating akan segera tersedia.',
    ),
    _ProfileMenuItem(
      label: 'Syarat dan Ketentuan',
      icon: Icons.description_outlined,
      routeName: RouteNames.homeTermsConditions,
      message: 'Buka halaman syarat dan ketentuan.',
    ),
  ];

  void _showComingSoon(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleMenuTap(BuildContext context, _ProfileMenuItem item) {
    if (item.routeName != null) {
      context.pushNamed(item.routeName!);
      return;
    }

    _showComingSoon(context, item.message);
  }

  void _handleBottomNavTap(BuildContext context, int index) {
    if (index == 0) {
      context.goNamed(RouteNames.home);
      return;
    }

    if (index == 1) {
      context.goNamed(RouteNames.homeServices);
      return;
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    await AuthService.logout();

    if (context.mounted) {
      context.goNamed(RouteNames.signIn);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode =
        ref.watch(appThemeModeControllerProvider) == ThemeMode.dark;
    final user = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: context.appThemedScaffoldColor(const Color(0xFFF7F9FF)),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: context.appHeaderGradientColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(42),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 44),
              child: Center(
                child: Text(
                  'Profile',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProfileSummaryCard(user: user),
                    const SizedBox(height: 28),
                    const _ProfileSectionTitle(title: 'Akun dan Keamanan'),
                    const SizedBox(height: 16),
                    _DarkModeToggleCard(
                      value: isDarkMode,
                      onChanged: (value) {
                        ref
                            .read(appThemeModeControllerProvider.notifier)
                            .setDarkMode(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    _ProfileMenuCard(
                      items: _accountSecurityItems,
                      onTap: (item) => _handleMenuTap(context, item),
                    ),
                    const SizedBox(height: 28),
                    const _ProfileSectionTitle(title: 'Informasi Lainnya'),
                    const SizedBox(height: 16),
                    _ProfileMenuCard(
                      items: _informationItems,
                      onTap: (item) => _handleMenuTap(context, item),
                    ),
                    const SizedBox(height: 28),
                    OutlinedButton(
                      onPressed: () async {
                        await _handleLogout(context);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 76),
                        foregroundColor: const Color(0xFFFF2156),
                        side: const BorderSide(
                          color: Color(0xFFFF2156),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(38),
                        ),
                        textStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('Keluar'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        selectedIndex: 2,
        onTap: (index) => _handleBottomNavTap(context, index),
      ),
    );
  }
}

class _ProfileSummaryCard extends StatelessWidget {
  const _ProfileSummaryCard({
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [context.appCardShadow],
      ),
      child: Row(
        children: [
          Container(
            width: 98,
            height: 98,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.appSubtleSurfaceColor,
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              size: 50,
              color: AppColors.welcomeAccent,
            ),
          ),
          const SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user?.name ?? '-',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: context.appTextColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user?.email ?? '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.appMutedTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user?.phone ?? '-',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.appMutedTextColor,
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

class _DarkModeToggleCard extends StatelessWidget {
  const _DarkModeToggleCard({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [context.appCardShadow],
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: context.appSubtleSurfaceColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              value ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              size: 34,
              color: AppColors.welcomeAccent,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dark Mode',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: context.appTextColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value ? 'Tampilan gelap aktif' : 'Tampilan terang aktif',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.appMutedTextColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _ProfileSectionTitle extends StatelessWidget {
  const _ProfileSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: context.appTextColor,
      ),
    );
  }
}

class _ProfileMenuCard extends StatelessWidget {
  const _ProfileMenuCard({required this.items, required this.onTap});

  final List<_ProfileMenuItem> items;
  final ValueChanged<_ProfileMenuItem> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [context.appCardShadow],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];

          return InkWell(
            borderRadius: BorderRadius.vertical(
              top: index == 0 ? const Radius.circular(28) : Radius.zero,
              bottom: index == items.length - 1
                  ? const Radius.circular(28)
                  : Radius.zero,
            ),
            onTap: () => onTap(item),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: context.appSubtleSurfaceColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      item.icon,
                      size: 34,
                      color: AppColors.welcomeAccent,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Text(
                      item.label,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: context.appTextColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 34,
                    color: context.appMutedTextColor,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ProfileMenuItem {
  const _ProfileMenuItem({
    required this.label,
    required this.icon,
    required this.message,
    this.routeName,
  });

  final String label;
  final IconData icon;
  final String message;
  final String? routeName;
}
