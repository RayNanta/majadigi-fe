import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../../home/routes.dart';
import '../widgets/auth_form_widgets.dart';

class SignUpStepThreePage extends StatefulWidget {
  const SignUpStepThreePage({super.key});

  @override
  State<SignUpStepThreePage> createState() => _SignUpStepThreePageState();
}

class _SignUpStepThreePageState extends State<SignUpStepThreePage> {
  static const _categories = <String>[
    'Kesehatan',
    'Kependudukan',
    'Pendidikan',
    'Perpajakan',
    'Darurat',
  ];

  static final _services = <_ServiceItem>[
    _ServiceItem(
      id: 'siskaper-bapo',
      title: 'SISKAPER\nBAPO',
      category: 'Kesehatan',
      icon: Icons.health_and_safety_outlined,
      color: Color(0xFF2E8B57),
    ),
    _ServiceItem(
      id: 'nomor-darurat',
      title: 'Nomor\nDarurat',
      category: 'Darurat',
      icon: Icons.phone_in_talk_outlined,
      color: Color(0xFFEA580C),
    ),
    _ServiceItem(
      id: 'bapenda-jatim',
      title: 'Bapenda\nJatim',
      category: 'Perpajakan',
      icon: Icons.receipt_long_outlined,
      color: Color(0xFF2563EB),
    ),
    _ServiceItem(
      id: 'rsud-saiful-anwar',
      title: 'RSUD Saiful\nAnwar',
      category: 'Kesehatan',
      icon: Icons.local_hospital_outlined,
      color: Color(0xFF9333EA),
    ),
    _ServiceItem(
      id: 'dukcapil-online',
      title: 'Dukcapil\nOnline',
      category: 'Kependudukan',
      icon: Icons.badge_outlined,
      color: Color(0xFF0F766E),
    ),
    _ServiceItem(
      id: 'kartu-keluarga',
      title: 'Kartu\nKeluarga',
      category: 'Kependudukan',
      icon: Icons.groups_2_outlined,
      color: Color(0xFF0891B2),
    ),
    _ServiceItem(
      id: 'ppdb-jatim',
      title: 'PPDB\nJatim',
      category: 'Pendidikan',
      icon: Icons.school_outlined,
      color: Color(0xFF7C3AED),
    ),
    _ServiceItem(
      id: 'beasiswa-jatim',
      title: 'Beasiswa\nJatim',
      category: 'Pendidikan',
      icon: Icons.menu_book_outlined,
      color: Color(0xFF4338CA),
    ),
    _ServiceItem(
      id: 'samsat-online',
      title: 'Samsat\nOnline',
      category: 'Perpajakan',
      icon: Icons.directions_car_outlined,
      color: Color(0xFFDC2626),
    ),
    _ServiceItem(
      id: 'ambulans-jatim',
      title: 'Ambulans\nJatim',
      category: 'Darurat',
      icon: Icons.emergency_outlined,
      color: Color(0xFFE11D48),
    ),
    _ServiceItem(
      id: 'jadwal-dokter',
      title: 'Jadwal\nDokter',
      category: 'Kesehatan',
      icon: Icons.medical_services_outlined,
      color: Color(0xFF0D9488),
    ),
    _ServiceItem(
      id: 'info-sekolah',
      title: 'Info\nSekolah',
      category: 'Pendidikan',
      icon: Icons.cast_for_education_outlined,
      color: Color(0xFFF59E0B),
    ),
  ];

  String? _selectedCategory;
  final Set<String> _selectedServiceIds = <String>{};

  List<_ServiceItem> get _visibleServices {
    if (_selectedCategory == null) {
      return _services;
    }

    return _services
        .where((service) => service.category == _selectedCategory)
        .toList();
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategory == category) {
        _selectedCategory = null;
        return;
      }

      _selectedCategory = category;
    });
  }

  void _toggleService(String id) {
    setState(() {
      if (_selectedServiceIds.contains(id)) {
        _selectedServiceIds.remove(id);
      } else {
        _selectedServiceIds.add(id);
      }
    });
  }

  void _finishRegistration() {
    context.go(HomeRoutes.path);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.isDarkMode
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthTopBar(),
                const SizedBox(height: 72),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'Pilih Layanan',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          color: context.appTextColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _finishRegistration,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.welcomeAccent,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size.zero,
                        textStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: const Text('Lewati'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Pilih layanan yang Anda butuhkan',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                    color: context.appMutedTextColor,
                  ),
                ),
                const SizedBox(height: 34),
                SizedBox(
                  height: 54,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 14),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _selectedCategory == category;

                      return ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (_) => _toggleCategory(category),
                        labelStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? AppColors.welcomeAccent
                              : context.appTextColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        backgroundColor: context.isDarkMode
                            ? context.appChipColor
                            : const Color(0xFFF1F1F2),
                        selectedColor: context.isDarkMode
                            ? context.appSelectedChipColor
                            : const Color(0xFFE8F1FF),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.welcomeAccent
                              : context.isDarkMode
                              ? context.appBorderColor
                              : Colors.transparent,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 34),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: _visibleServices.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 28,
                          crossAxisSpacing: 14,
                          childAspectRatio: 0.62,
                        ),
                    itemBuilder: (context, index) {
                      final service = _visibleServices[index];
                      final isSelected = _selectedServiceIds.contains(
                        service.id,
                      );

                      return _ServiceTile(
                        service: service,
                        isSelected: isSelected,
                        onTap: () => _toggleService(service.id),
                      );
                    },
                  ),
                ),
                AuthPrimaryButton(
                  label: 'Unduh Layanan',
                  onPressed: _selectedServiceIds.isNotEmpty
                      ? _finishRegistration
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  final _ServiceItem service;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.appSurfaceColor,
              border: Border.all(
                color: isSelected
                    ? AppColors.welcomeAccent
                    : context.appBorderColor,
                width: 2,
              ),
              boxShadow: context.appThemedCardShadows([
                BoxShadow(
                  color: const Color(0xFF101828).withValues(alpha: 0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ]),
            ),
            child: Center(
              child: Icon(
                service.icon,
                size: 34,
                color: isSelected ? AppColors.welcomeAccent : service.color,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            service.title,
            maxLines: 3,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              height: 1.3,
              color: context.appTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceItem {
  const _ServiceItem({
    required this.id,
    required this.title,
    required this.category,
    required this.icon,
    required this.color,
  });

  final String id;
  final String title;
  final String category;
  final IconData icon;
  final Color color;
}
