import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../services/emergency_numbers.dart';

class EmergencyNumbersMainPage extends StatefulWidget {
  const EmergencyNumbersMainPage({super.key});

  @override
  State<EmergencyNumbersMainPage> createState() =>
      _EmergencyNumbersMainPageState();
}

class _EmergencyNumbersMainPageState
    extends State<EmergencyNumbersMainPage> {

  final EmergencyNumbers service = EmergencyNumbers();

  List contacts = [];
  List filteredContacts = [];

  List<String> wilayahList = [];

  String selectedWilayah = 'Semua';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    try {
      final data = await service.getNomorDarurat();

      final wilayah = data
          .map<String>((e) => e['nama_wilayah'].toString())
          .toSet()
          .toList();

      wilayah.sort();

      setState(() {
        contacts = data;
        filteredContacts = data;

        wilayahList = [
          'Semua',
          ...wilayah,
        ];

        isLoading = false;
      });

    } catch (e) {
      print(e);

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

  void _showDialPlaceholder(String phone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Menghubungi $phone'),
      ),
    );
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

                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 30,
                    ),
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
                  ? const Center(
                child: CircularProgressIndicator(),
              )

                  : Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(20),

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(

                          value: selectedWilayah,

                          isExpanded: true,

                          items: wilayahList.map((wilayah) {

                            return DropdownMenuItem(
                              value: wilayah,

                              child: Text(
                                wilayah,

                                style:
                                GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w600,
                                ),
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
                  ),

                  Expanded(
                    child: filteredContacts.isEmpty
                        ? const Center(
                      child: Text("Tidak ada data"),
                    )

                        : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(
                        24,
                        10,
                        24,
                        28,
                      ),

                      child: Column(
                        children:
                        filteredContacts.map((contact) {

                          final kategori =
                              contact['kategori'] ?? 'lainnya';

                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 26,
                            ),

                            child: _EmergencyContactCard(

                              title:
                              contact['nama_layanan'] ?? '-',

                              subtitle:
                              contact['keterangan'] ??
                                  'Layanan darurat',

                              buttonLabel:
                              'CALL CENTER ${contact['nomor_telepon']}',

                              icon: getIcon(kategori),

                              iconColor:
                              getIconColor(kategori),

                              iconBackground:
                              getBackgroundColor(kategori),

                              onCallPressed: () =>
                                  _showDialPlaceholder(
                                    contact['nomor_telepon'],
                                  ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
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

      padding: const EdgeInsets.fromLTRB(
        22,
        26,
        22,
        22,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827)
                .withValues(alpha: 0.04),

            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        children: [

          Container(
            width: 112,
            height: 112,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBackground,
            ),

            child: Icon(
              icon,
              size: 48,
              color: iconColor,
            ),
          ),

          const SizedBox(height: 26),

          Text(
            title,
            textAlign: TextAlign.center,

            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF27305F),
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
              color: const Color(0xFF5A5F91),
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