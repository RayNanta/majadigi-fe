import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../services/emergency_numbers.dart';

class EmergencyNumbersMainPage extends StatefulWidget {
  const EmergencyNumbersMainPage({super.key});

  @override
  State<EmergencyNumbersMainPage> createState() =>
      _EmergencyNumbersMainPageState();
}

class _EmergencyNumbersMainPageState extends State<EmergencyNumbersMainPage> {
  final EmergencyNumbers service = EmergencyNumbers();

  List<dynamic> contacts = [];
  List<dynamic> filteredContacts = [];
  List<String> wilayahList = ['Semua'];

  String selectedWilayah = 'Semua';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final data = await service.getNomorDarurat();
      final wilayah =
          data.map<String>((e) => e['nama_wilayah'].toString()).toSet().toList()
            ..sort();

      setState(() {
        contacts = data;
        filteredContacts = data;
        wilayahList = ['Semua', ...wilayah];
        selectedWilayah = 'Semua';
        isLoading = false;
      });
    } catch (e) {
      debugPrint('ERROR LOAD EMERGENCY NUMBERS: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterByWilayah(String wilayah) {
    setState(() {
      selectedWilayah = wilayah;

      if (wilayah == 'Semua') {
        filteredContacts = contacts;
      } else {
        filteredContacts = contacts
            .where((e) => e['nama_wilayah'] == wilayah)
            .toList();
      }
    });
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeEmergencyNumbers);
  }

  Future<void> _hubungiNomor(String phone) async {
    final telUrl = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(telUrl)) {
      await launchUrl(telUrl);
      return;
    }

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Tidak dapat memanggil $phone')));
    }
  }

  IconData getIcon(String kategori) {
    switch (kategori.toLowerCase()) {
      case 'medis':
        return Icons.medical_services_rounded;
      case 'keamanan':
        return Icons.local_police_rounded;
      case 'kebencanaan':
        return Icons.fire_truck_rounded;
      default:
        return Icons.support_agent_rounded;
    }
  }

  Color getIconColor(String kategori) {
    switch (kategori.toLowerCase()) {
      case 'medis':
        return const Color(0xFFFF175A);
      default:
        return AppColors.welcomeAccent;
    }
  }

  Color getBackgroundColor(String kategori) {
    switch (kategori.toLowerCase()) {
      case 'medis':
        return const Color(0xFFFFE2EB);
      default:
        return const Color(0xFFE5F0FF);
    }
  }

  @override
  Widget build(BuildContext context) {
    final wilayahItems = wilayahList.isEmpty ? ['Semua'] : wilayahList;

    return Scaffold(
      backgroundColor: context.appThemedScaffoldColor(const Color(0xFFF7F9FF)),
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
                      'Nomor Darurat',
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
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 34, 24, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: context.isDarkMode
                                  ? context.appSubtleSurfaceColor
                                  : const Color(0xFFF0F0F2),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: wilayahItems.contains(selectedWilayah)
                                    ? selectedWilayah
                                    : wilayahItems.first,
                                icon: Icon(
                                  Icons.expand_more_rounded,
                                  color: context.appThemedMutedTextColor(
                                    const Color(0xFF5D6068),
                                  ),
                                  size: 30,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                dropdownColor: context.appSurfaceColor,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: context.appThemedTextColor(
                                    const Color(0xFF4F525A),
                                  ),
                                ),
                                items: wilayahItems.map((wilayah) {
                                  return DropdownMenuItem<String>(
                                    value: wilayah,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: context
                                              .appThemedMutedTextColor(
                                                const Color(0xFF5D6068),
                                              ),
                                          size: 26,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(child: Text(wilayah)),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    filterByWilayah(value);
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            'Menampilkan kontak darurat untuk wilayah terpilih',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1.7,
                              color: context.appMutedTextColor,
                            ),
                          ),
                          const SizedBox(height: 26),
                          if (filteredContacts.isEmpty)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 56,
                                ),
                                child: Text(
                                  'Tidak ada data',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: context.appMutedTextColor,
                                  ),
                                ),
                              ),
                            )
                          else
                            ...filteredContacts.map((contact) {
                              final kategori =
                                  contact['kategori']?.toString() ?? 'lainnya';
                              final phone =
                                  contact['nomor_telepon']?.toString() ?? '-';

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 26),
                                child: _EmergencyContactCard(
                                  title:
                                      contact['nama_layanan']?.toString() ??
                                      '-',
                                  subtitle:
                                      contact['keterangan']?.toString() ??
                                      'Layanan darurat',
                                  buttonLabel: 'CALL CENTER $phone',
                                  icon: getIcon(kategori),
                                  iconColor: getIconColor(kategori),
                                  iconBackground: getBackgroundColor(kategori),
                                  onCallPressed: () => _hubungiNomor(phone),
                                ),
                              );
                            }),
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

class _EmergencyContactCard extends StatelessWidget {
  const _EmergencyContactCard({
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.onCallPressed,
  });

  final String title;
  final String subtitle;
  final String buttonLabel;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final VoidCallback onCallPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ]),
      ),
      child: Column(
        children: [
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.isDarkMode
                  ? iconColor.withValues(alpha: 0.16)
                  : iconBackground,
            ),
            child: Icon(icon, size: 48, color: iconColor),
          ),
          const SizedBox(height: 26),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: context.appThemedTextColor(const Color(0xFF27305F)),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: context.appThemedMutedTextColor(const Color(0xFF5A5F91)),
            ),
          ),
          const SizedBox(height: 26),
          SizedBox(
            width: double.infinity,
            height: 72,
            child: FilledButton.icon(
              onPressed: onCallPressed,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFFF0B56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              icon: const Icon(
                Icons.phone_outlined,
                color: Colors.white,
                size: 30,
              ),
              label: Text(buttonLabel),
            ),
          ),
        ],
      ),
    );
  }
}
