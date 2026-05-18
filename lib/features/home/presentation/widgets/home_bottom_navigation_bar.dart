import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/theme/app_colors.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    const items = [
      _HomeNavItem(icon: Icons.home_rounded, label: 'Beranda'),
      _HomeNavItem(icon: Icons.inventory_2_outlined, label: 'Layanan'),
      _HomeNavItem(icon: Icons.person_rounded, label: 'Akun'),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 6, 24, 14),
        child: Container(
          height: 94,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: const Color(0xFFE9EAF0)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF111827).withValues(alpha: 0.06),
                blurRadius: 18,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = selectedIndex == index;

              return Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(32),
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.icon,
                        size: 32,
                        color: isSelected
                            ? AppColors.welcomeAccent
                            : const Color(0xFF111111),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.label,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? AppColors.welcomeAccent
                              : const Color(0xFF111111),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _HomeNavItem {
  const _HomeNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}
