import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../models/profile_data.dart';

class PersonalDataPage extends StatelessWidget {
  const PersonalDataPage({super.key});

  List<_PersonalDataItem> get _items => [
    _PersonalDataItem(
      label: 'Nama lengkap',
      value: demoProfileData.fullName,
      icon: Icons.person_outline_rounded,
    ),
    _PersonalDataItem(
      label: 'Email',
      value: demoProfileData.email,
      icon: Icons.email_outlined,
    ),
    _PersonalDataItem(
      label: 'NIK',
      value: demoProfileData.nik,
      icon: Icons.badge_outlined,
    ),
    _PersonalDataItem(
      label: 'Alamat',
      value: demoProfileData.address,
      icon: Icons.location_on_outlined,
    ),
    _PersonalDataItem(
      label: 'No HP',
      value: demoProfileData.phoneNumber,
      icon: Icons.call_outlined,
    ),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeProfile);
  }

  void _showComingSoon(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit $label akan segera tersedia.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.splashBackground,
              padding: const EdgeInsets.fromLTRB(18, 22, 24, 28),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _handleBack(context),
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
                      'Data Diri',
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                child: Column(
                  children: _items
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 22),
                          child: _PersonalDataCard(
                            item: item,
                            onEdit: () => _showComingSoon(context, item.label),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PersonalDataCard extends StatelessWidget {
  const _PersonalDataCard({required this.item, required this.onEdit});

  final _PersonalDataItem item;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: const Color(0xFFE6F0FF),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(item.icon, size: 42, color: AppColors.welcomeAccent),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF303236),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.value,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1.45,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: onEdit,
            style: IconButton.styleFrom(
              foregroundColor: AppColors.welcomeAccent,
              minimumSize: const Size(42, 42),
            ),
            icon: const Icon(Icons.edit_rounded, size: 34),
          ),
        ],
      ),
    );
  }
}

class _PersonalDataItem {
  const _PersonalDataItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
}
