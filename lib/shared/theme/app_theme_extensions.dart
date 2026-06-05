import 'package:flutter/material.dart';

import 'app_colors.dart';

extension AppThemeX on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get appScaffoldColor => Theme.of(this).scaffoldBackgroundColor;

  Color appThemedScaffoldColor(Color lightColor) =>
      isDarkMode ? appScaffoldColor : lightColor;

  Color appThemedSurfaceColor(Color lightColor) =>
      isDarkMode ? appSurfaceColor : lightColor;

  Color appThemedTextColor(Color lightColor) =>
      isDarkMode ? appTextColor : lightColor;

  Color appThemedMutedTextColor(Color lightColor) =>
      isDarkMode ? appMutedTextColor : lightColor;

  Color get appSurfaceColor => Theme.of(this).colorScheme.surface;

  Color get appElevatedSurfaceColor =>
      isDarkMode ? const Color(0xFF14233A) : Colors.white;

  Color get appSubtleSurfaceColor =>
      isDarkMode ? const Color(0xFF172A46) : const Color(0xFFE6F0FF);

  Color get appTextColor => Theme.of(this).colorScheme.onSurface;

  Color get appMutedTextColor =>
      isDarkMode ? const Color(0xFFAAB7CE) : AppColors.textMuted;

  Color get appBorderColor =>
      isDarkMode ? const Color(0xFF2A3A55) : const Color(0xFFE9EAF0);

  Color get appSearchSurfaceColor =>
      isDarkMode ? const Color(0xFF0E1A2D) : Colors.white;

  Color get appChipColor =>
      isDarkMode ? const Color(0xFF14233A) : const Color(0xFFEDEDED);

  Color get appSelectedChipColor =>
      isDarkMode ? const Color(0xFF15345F) : const Color(0xFFE7F0FF);

  Color get appSelectedChipBorderColor =>
      isDarkMode ? const Color(0xFF315F9F) : const Color(0xFFB7D0FF);

  Color get appHandleColor =>
      isDarkMode ? const Color(0xFF40516C) : const Color(0xFFCBCDD4);

  List<Color> get appHeaderGradientColors => isDarkMode
      ? const [Color(0xFF0A2A65), Color(0xFF071A3D)]
      : const [Color(0xFF1668F7), Color(0xFF0F52D2)];

  BoxShadow get appCardShadow => BoxShadow(
    color: Colors.black.withValues(alpha: isDarkMode ? 0.22 : 0.04),
    blurRadius: isDarkMode ? 18 : 14,
    offset: const Offset(0, 6),
  );

  List<BoxShadow> appThemedCardShadows(List<BoxShadow> lightShadows) =>
      isDarkMode ? [appCardShadow] : lightShadows;
}
