import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../../../shared/widgets/lazy_load_states.dart';
import '../../services/sidita_models.dart';
import '../../services/sidita_services.dart';

class SiditaEventsPage extends ConsumerStatefulWidget {
  const SiditaEventsPage({super.key});

  @override
  ConsumerState<SiditaEventsPage> createState() => _SiditaEventsPageState();
}

class _SiditaEventsPageState extends ConsumerState<SiditaEventsPage> {
  // ✅ Menyelaraskan opsi filter UI dengan data seeder backend (Surabaya ganti Banyuwangi rill)
  static const Map<String, String> _regionOptions = {
    'Semua': '',
    'Mojokerto': 'Kabupaten Mojokerto',
    'Banyuwangi': 'Kabupaten Banyuwangi',
    'Probolinggo': 'Kabupaten Probolinggo',
  };

  final TextEditingController _searchController = TextEditingController();
  String _selectedRegion = 'Semua';

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

  void _openEventDetail(EventWisataModel event) {
    context.pushNamed(
      RouteNames.homeSiditaPasarDjadoel,
      extra: event,
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(
      siditaEventProvider(
        SiditaFilterParams(
          search: _searchController.text.trim(),
          kabKota: _regionOptions[_selectedRegion] ?? '',
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // APP BAR
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
                      'Event Jawa Timur',
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

            // BODY AREA
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SEARCH FIELD
                    _SearchField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),

                    // DROPDOWN FILTER LOKASI REGION
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? context.appSearchSurfaceColor
                            : const Color(0xFFF0F0F2),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedRegion,
                          icon: Icon(
                            Icons.expand_more_rounded,
                            color: context.appMutedTextColor,
                            size: 28,
                          ),
                          dropdownColor: context.appSurfaceColor,
                          borderRadius: BorderRadius.circular(18),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: context.appTextColor,
                          ),
                          items: _regionOptions.keys.map((label) {
                            return DropdownMenuItem<String>(
                              value: label,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 22,
                                    color: context.appMutedTextColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(label),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedRegion = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),

                    Text(
                      'Event di $_selectedRegion',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: context.appTextColor,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // BINDING DATA ASYNC VIA RIVERPOD WHEN
                    ...eventsAsync.when<List<Widget>>(
                      loading: () => const [
                        LazyCardSkeleton(height: 400),
                        SizedBox(height: 26),
                        LazyCardSkeleton(height: 200),
                      ],
                      error: (error, stackTrace) => [
                        Padding(
                          padding: const EdgeInsets.only(top: 28),
                          child: LazyLoadErrorState(
                            message: 'Gagal memuat daftar event dari server lokal.',
                            onRetry: () {
                              ref.invalidate(siditaEventProvider);
                            },
                          ),
                        ),
                      ],
                      data: (events) {
                        if (events.isEmpty) {
                          return [
                            Padding(
                              padding: const EdgeInsets.only(top: 36),
                              child: Center(
                                child: Text(
                                  'Belum ada event kebudayaan di $_selectedRegion rill.',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: context.appMutedTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ];
                        }

                        return events.map((event) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 26),
                            child: _EventCard(
                              item: event,
                              onTap: () => _openEventDetail(event),
                            ),
                          );
                        }).toList();
                      },
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

// ==================== SUB-WIDGET COMPONENTS ====================

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
        hintText: 'Cari Event Kebudayaan / Festival',
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: context.appMutedTextColor,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Icon(
            Icons.search_rounded,
            size: 34,
            color: context.appMutedTextColor,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        filled: true,
        fillColor: context.isDarkMode
            ? context.appSearchSurfaceColor
            : const Color(0xFFF0F0F2),
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
        color: context.appTextColor,
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.item, required this.onTap});

  final EventWisataModel item; // ✅ Menggunakan Model Dinamis Asli
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Logika warna badge berdasarkan jenis kategori berbayar rill
    final Color badgeColor = item.isBerbayar ? const Color(0xFFEF4444) : const Color(0xFF10B981);

    return Material(
      color: context.appSurfaceColor,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: context.appThemedCardShadows([
              BoxShadow(
                color: const Color(0xFF111827).withValues(alpha: 0.05),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ]),
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
                      'assets/images/dummy_image.png', // Fallback local asset rill
                      width: double.infinity,
                      height: 240,
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 6,
                            )
                          ]
                      ),
                      child: Text(
                        item.isBerbayar ? 'TICKETED' : 'FREE EVENT',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: badgeColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.namaEvent,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: context.appTextColor,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.deskripsiAcara,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: context.appMutedTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Divider(height: 32),
                    _MetaRow(
                      icon: Icons.location_on_outlined,
                      text: '${item.namaTempatLokasi}, ${item.kabupatenKota}',
                    ),
                    const SizedBox(height: 12),
                    _MetaRow(
                      icon: Icons.calendar_today_outlined,
                      text: '${item.tanggalMulai} s/d ${item.tanggalSelesai} (${item.jamOperasional})',
                    ),
                    const SizedBox(height: 12),
                    _MetaRow(
                      icon: Icons.confirmation_number_outlined,
                      text: 'HTM: ${item.hargaTiket}',
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
        Icon(icon, size: 20, color: context.appMutedTextColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: context.appMutedTextColor,
            ),
          ),
        ),
      ],
    );
  }
}