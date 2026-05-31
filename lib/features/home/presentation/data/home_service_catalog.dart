import 'package:flutter/material.dart';

import '../models/home_service_item.dart';

const allCatalogServices = <HomeServiceItem>[
  HomeServiceItem(
    id: 'destinasi-wisata',
    title: 'SIDITA',
    category: 'Pariwisata',
    subtitle: 'Sistem Informasi Daya Tarik Wisata Jawa Timur',
    badgeText: 'SID',
    accentColor: Color(0xFF0EA5A4),
    badgeBackground: Color(0xFFE6FFFB),
    catalogTab: HomeCatalogTab.services,
  ),
  HomeServiceItem(
    id: 'islamic-center',
    title: 'Islamic\nCenter',
    category: 'Pendidikan',
    subtitle: 'Biro Kesejahteraan Rakyat',
    badgeText: 'IC',
    accentColor: Color(0xFFC08457),
    badgeBackground: Color(0xFFFFF1E8),
    catalogTab: HomeCatalogTab.services,
  ),
  HomeServiceItem(
    id: 'khas-jatim',
    title: 'Khas\nJatim',
    category: 'Pendidikan',
    subtitle: 'Dinas Perpustakaan dan Kearsipan',
    badgeText: 'KJ',
    accentColor: Color(0xFF16A34A),
    badgeBackground: Color(0xFFEFFBF2),
    catalogTab: HomeCatalogTab.services,
  ),
  HomeServiceItem(
    id: 'klinik-hoaks',
    title: 'Klinik\nHoaks',
    category: 'Pendidikan',
    subtitle: 'Dinas Komunikasi dan Informatika',
    badgeText: 'KH',
    accentColor: Color(0xFF16A34A),
    badgeBackground: Color(0xFFEFFBF2),
    catalogTab: HomeCatalogTab.services,
  ),
  HomeServiceItem(
    id: 'rsud-saiful-anwar',
    title: 'RSUD Saiful\nAnwar',
    category: 'Kesehatan',
    subtitle: 'RSUD Dr. Saiful Anwar',
    badgeText: 'RSSA',
    accentColor: Color(0xFF7C3AED),
    badgeBackground: Colors.white,
    catalogTab: HomeCatalogTab.services,
  ),
  HomeServiceItem(
    id: 'bapenda-jatim',
    title: 'Bapenda\nJatim',
    category: 'Kependudukan',
    subtitle: 'Badan Pendapatan Daerah',
    badgeText: 'BPD',
    accentColor: Color(0xFF16A34A),
    badgeBackground: Colors.white,
    catalogTab: HomeCatalogTab.services,
  ),
  HomeServiceItem(
    id: 'siskaper-bapo',
    title: 'SISKAPER\nBAPO',
    category: 'Kependudukan',
    subtitle: 'Dinas Perindustrian dan Perdagangan',
    badgeText: 'SB',
    accentColor: Color(0xFF2563EB),
    badgeBackground: Colors.white,
    catalogTab: HomeCatalogTab.services,
  ),
  HomeServiceItem(
    id: 'sinaker',
    title: 'SINAKER',
    category: 'Pendidikan',
    subtitle: 'Disnakertrans Jawa Timur',
    badgeText: 'SNK',
    accentColor: Color(0xFFDC2626),
    badgeBackground: Colors.white,
    catalogTab: HomeCatalogTab.services,
  ),
  HomeServiceItem(
    id: 'skrining-tbc',
    title: 'Skrining\nTBC',
    category: 'Kesehatan',
    subtitle: 'Dinas Kesehatan',
    badgeText: 'TBC',
    accentColor: Color(0xFF059669),
    badgeBackground: Colors.white,
    catalogTab: HomeCatalogTab.services,
  ),
  HomeServiceItem(
    id: 'nomor-darurat',
    title: 'Nomor\nDarurat',
    category: 'Kesehatan',
    subtitle: 'Command Center Jawa Timur',
    badgeText: '112',
    accentColor: Color(0xFFF97316),
    badgeBackground: Colors.white,
    catalogTab: HomeCatalogTab.services,
  ),
  HomeServiceItem(
    id: 'jatim-sehat',
    title: 'Jatim\nSehat',
    category: 'Nawa Bhakti',
    subtitle: 'Program Nawa Bhakti Satya',
    badgeText: 'JS',
    accentColor: Color(0xFF16A34A),
    badgeBackground: Color(0xFFEFFBF2),
    catalogTab: HomeCatalogTab.nawaBhakti,
  ),
  HomeServiceItem(
    id: 'jatim-cerdas',
    title: 'Jatim\nCerdas',
    category: 'Nawa Bhakti',
    subtitle: 'Program Nawa Bhakti Satya',
    badgeText: 'JC',
    accentColor: Color(0xFF2563EB),
    badgeBackground: Color(0xFFEEF4FF),
    catalogTab: HomeCatalogTab.nawaBhakti,
  ),
  HomeServiceItem(
    id: 'jatim-kerja',
    title: 'Jatim\nKerja',
    category: 'Nawa Bhakti',
    subtitle: 'Program Nawa Bhakti Satya',
    badgeText: 'JK',
    accentColor: Color(0xFFF97316),
    badgeBackground: Color(0xFFFFF3EA),
    catalogTab: HomeCatalogTab.nawaBhakti,
  ),
  HomeServiceItem(
    id: 'jatim-amanah',
    title: 'Jatim\nAmanah',
    category: 'Nawa Bhakti',
    subtitle: 'Program Nawa Bhakti Satya',
    badgeText: 'JA',
    accentColor: Color(0xFF0F766E),
    badgeBackground: Color(0xFFE8FCF7),
    catalogTab: HomeCatalogTab.nawaBhakti,
  ),
  HomeServiceItem(
    id: 'jatim-makmur',
    title: 'Jatim\nMakmur',
    category: 'Nawa Bhakti',
    subtitle: 'Program Nawa Bhakti Satya',
    badgeText: 'JM',
    accentColor: Color(0xFFCA8A04),
    badgeBackground: Color(0xFFFFF9DB),
    catalogTab: HomeCatalogTab.nawaBhakti,
  ),
  HomeServiceItem(
    id: 'jatim-harmoni',
    title: 'Jatim\nHarmoni',
    category: 'Nawa Bhakti',
    subtitle: 'Program Nawa Bhakti Satya',
    badgeText: 'JH',
    accentColor: Color(0xFF9333EA),
    badgeBackground: Color(0xFFF6EEFF),
    catalogTab: HomeCatalogTab.nawaBhakti,
  ),
];

const recommendedHomeServiceIds = <String>[
  'destinasi-wisata',
  'islamic-center',
  'khas-jatim',
  'klinik-hoaks',
];

const initialAddedHomeServiceIds = <String>{
  'rsud-saiful-anwar',
  'bapenda-jatim',
  'siskaper-bapo',
  'sinaker',
  'skrining-tbc',
  'nomor-darurat',
};

HomeServiceItem serviceById(String id) {
  return allCatalogServices.firstWhere((service) => service.id == id);
}

List<HomeServiceItem> selectedServicesFrom(Set<String> ids) {
  return allCatalogServices
      .where((service) => ids.contains(service.id))
      .toList();
}

List<HomeServiceItem> get recommendedHomeServices {
  return recommendedHomeServiceIds.map(serviceById).toList();
}

List<HomeServiceItem> get layananCatalogServices {
  return allCatalogServices
      .where((service) => service.catalogTab == HomeCatalogTab.services)
      .toList();
}

List<String> get layananCategories {
  const preferredOrder = [
    'Kesehatan',
    'Kependudukan',
    'Pendidikan',
    'Pariwisata',
    'Perdagangan',
    'Darurat',
  ];
  final categories = <String>[];

  for (final category in preferredOrder) {
    if (layananCatalogServices.any((service) => service.category == category)) {
      categories.add(category);
    }
  }

  for (final service in layananCatalogServices) {
    if (!categories.contains(service.category)) {
      categories.add(service.category);
    }
  }

  return categories;
}
