import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class SiditaEventsPage extends StatefulWidget {
  const SiditaEventsPage({super.key});

  @override
  State<SiditaEventsPage> createState() => _SiditaEventsPageState();
}

class _SiditaEventsPageState extends State<SiditaEventsPage> {
  static const _regions = ['Jawa Timur', 'Malang', 'Surabaya'];

  static const _events = [
    _SiditaEventItem(
      title: 'Pasar Djadoel Ahad Legi',
      category: 'HERITAGE',
      location: 'Kabupaten Ngawi',
      dateRange: '01 Jan 2024 - 31 Dec 2024',
      region: 'Jawa Timur',
      accentColor: Color(0xFF2563EB),
      routeName: RouteNames.homeSiditaPasarDjadoel,
    ),
    _SiditaEventItem(
      title: 'Kurma Festival',
      category: 'KULINER',
      location: 'Kabupaten Pasuruan',
      dateRange: '01 Jan 2024 - 31 Dec 2024',
      region: 'Jawa Timur',
      accentColor: Color(0xFF2563EB),
    ),
    _SiditaEventItem(
      title: 'Pentas Padang Bulan Sendratari Arjuna Wiwaha',
      category: 'PERTUNJUKAN',
      location: 'Kota Batu',
      dateRange: '01 Jan 2024 - 31 Dec 2024',
      region: 'Jawa Timur',
      accentColor: Color(0xFF2563EB),
    ),
    _SiditaEventItem(
      title: 'Gebyar Ekraf',
      category: 'EKONOMI KREATIF',
      location: 'Kabupaten Sidoarjo',
      dateRange: '01 Jan 2024 - 31 Dec 2024',
      region: 'Jawa Timur',
      accentColor: Color(0xFF2563EB),
    ),
    _SiditaEventItem(
      title: 'Festival Bunga Kota Malang',
      category: 'PARIWISATA',
      location: 'Kota Malang',
      dateRange: '05 Feb 2024 - 09 Feb 2024',
      region: 'Malang',
      accentColor: Color(0xFF16A34A),
    ),
    _SiditaEventItem(
      title: 'Surabaya Creative Week',
      category: 'EKONOMI KREATIF',
      location: 'Kota Surabaya',
      dateRange: '10 Mar 2024 - 18 Mar 2024',
      region: 'Surabaya',
      accentColor: Color(0xFF7C3AED),
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _selectedRegion = _regions.first;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeSiditaMain);
  }

  void _openEventDetail(_SiditaEventItem event) {
    final routeName = event.routeName;
    if (routeName != null) {
      context.pushNamed(routeName);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Detail ${event.title} akan kita lanjutkan berikutnya.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final visibleEvents = _events.where((event) {
      if (_selectedRegion != 'Jawa Timur' && event.region != _selectedRegion) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      return event.title.toLowerCase().contains(query) ||
          event.location.toLowerCase().contains(query) ||
          event.category.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.welcomeAccent,
              padding: const EdgeInsets.fromLTRB(16, 18, 20, 18),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _handleBack,
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(36, 36),
                    ),
                    icon: const Icon(Icons.arrow_back_rounded, size: 30),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Event',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
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
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SearchField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F2),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedRegion,
                          icon: const Icon(
                            Icons.expand_more_rounded,
                            color: Color(0xFF5D6068),
                            size: 28,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF555962),
                          ),
                          items: _regions.map((region) {
                            return DropdownMenuItem<String>(
                              value: region,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 22,
                                    color: Color(0xFF696D75),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(region),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }

                            setState(() {
                              _selectedRegion = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Event Mendatang',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF16181D),
                      ),
                    ),
                    const SizedBox(height: 18),
                    ...visibleEvents.map(
                      (event) => Padding(
                        padding: const EdgeInsets.only(bottom: 26),
                        child: _EventCard(
                          item: event,
                          onTap: () => _openEventDetail(event),
                        ),
                      ),
                    ),
                    if (visibleEvents.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 36),
                        child: Center(
                          child: Text(
                            'Belum ada event yang cocok.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SiditaEventItem {
  const _SiditaEventItem({
    required this.title,
    required this.category,
    required this.location,
    required this.dateRange,
    required this.region,
    required this.accentColor,
    this.routeName,
  });

  final String title;
  final String category;
  final String location;
  final String dateRange;
  final String region;
  final Color accentColor;
  final String? routeName;
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Cari Event',
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF8A8F99),
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.only(right: 14),
          child: Icon(Icons.search_rounded, size: 34, color: Color(0xFF696D75)),
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        filled: true,
        fillColor: const Color(0xFFF0F0F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.welcomeAccent,
            width: 1.4,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 22,
        ),
      ),
      style: GoogleFonts.plusJakartaSans(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF20232B),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.item, required this.onTap});

  final _SiditaEventItem item;
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF111827).withValues(alpha: 0.05),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: Image.asset(
                      'assets/images/dummy_image.png',
                      width: double.infinity,
                      height: 268,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        item.category,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: item.accentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF252932),
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _MetaRow(
                      icon: Icons.location_on_outlined,
                      text: item.location,
                    ),
                    const SizedBox(height: 12),
                    _MetaRow(
                      icon: Icons.calendar_today_outlined,
                      text: item.dateRange,
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

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF9CA3AF)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8A8F99),
            ),
          ),
        ),
      ],
    );
  }
}
