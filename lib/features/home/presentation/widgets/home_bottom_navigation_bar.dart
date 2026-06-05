import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/theme/app_theme_extensions.dart';

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

    final selectedColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = context.isDarkMode
        ? const Color(0xFFB9C6DC)
        : const Color(0xFF111111);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 6, 24, 14),
        child: Container(
          height: 94,
          decoration: BoxDecoration(
            color: context.appSurfaceColor,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: context.appBorderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: context.isDarkMode ? 0.28 : 0.06,
                ),
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
                        color: isSelected ? selectedColor : inactiveColor,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.label,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? selectedColor : inactiveColor,
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
