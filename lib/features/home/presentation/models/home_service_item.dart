import 'package:flutter/material.dart';

enum HomeCatalogTab { services, nawaBhakti }

class HomeServiceItem {
  const HomeServiceItem({
    required this.id,
    required this.title,
    required this.category,
    required this.accentColor,
    required this.badgeBackground,
    this.subtitle,
    this.badgeText,
    this.icon,
    this.filledBadge = false,
    this.catalogTab = HomeCatalogTab.services,
  });

  final String id;
  final String title;
  final String category;
  final String? subtitle;
  final String? badgeText;
  final IconData? icon;
  final Color accentColor;
  final Color badgeBackground;
  final bool filledBadge;
  final HomeCatalogTab catalogTab;

  String get displayTitle => title.replaceAll('\n', ' ');
}
