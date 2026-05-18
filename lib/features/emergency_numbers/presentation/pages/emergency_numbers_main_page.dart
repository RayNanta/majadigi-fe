import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class EmergencyNumbersMainPage extends StatefulWidget {
  const EmergencyNumbersMainPage({super.key});

  @override
  State<EmergencyNumbersMainPage> createState() =>
      _EmergencyNumbersMainPageState();
}

class _EmergencyNumbersMainPageState extends State<EmergencyNumbersMainPage> {
  static const _regions = ['Jawa Timur', 'Surabaya', 'Malang'];

  static const _servicesByRegion = {
    'Jawa Timur': [
      _EmergencyContact(
        title: 'AMBULANS / KEADAAN DARURAT',
        subtitle: 'Layanan cepat tanggap darurat medis',
        buttonLabel: 'CALL CENTER 112',
        icon: Icons.medical_services_rounded,
        iconColor: Color(0xFFFF175A),
        iconBackground: Color(0xFFFFE2EB),
      ),
      _EmergencyContact(
        title: 'POLDA JATIM',
        subtitle: 'Markas Kepolisian Daerah Jawa Timur',
        buttonLabel: 'CALL CENTER (031) 8280748',
        icon: Icons.verified_user_rounded,
        iconColor: AppColors.welcomeAccent,
        iconBackground: Color(0xFFE5F0FF),
      ),
      _EmergencyContact(
        title: 'CALL CENTER',
        subtitle: 'Layanan pengaduan masyarakat umum',
        buttonLabel: 'CALL CENTER 1500979',
        icon: Icons.support_agent_rounded,
        iconColor: AppColors.welcomeAccent,
        iconBackground: Color(0xFFE5F0FF),
      ),
    ],
    'Surabaya': [
      _EmergencyContact(
        title: 'AMBULANS SURABAYA',
        subtitle: 'Layanan darurat kota Surabaya',
        buttonLabel: 'CALL CENTER 112',
        icon: Icons.local_hospital_rounded,
        iconColor: Color(0xFFFF175A),
        iconBackground: Color(0xFFFFE2EB),
      ),
      _EmergencyContact(
        title: 'POLRESTA SURABAYA',
        subtitle: 'Pelayanan kepolisian kota Surabaya',
        buttonLabel: 'CALL CENTER (031) 5456290',
        icon: Icons.shield_rounded,
        iconColor: AppColors.welcomeAccent,
        iconBackground: Color(0xFFE5F0FF),
      ),
      _EmergencyContact(
        title: 'COMMAND CENTER',
        subtitle: 'Layanan aduan terpadu pemerintah kota',
        buttonLabel: 'CALL CENTER 112',
        icon: Icons.headset_mic_rounded,
        iconColor: AppColors.welcomeAccent,
        iconBackground: Color(0xFFE5F0FF),
      ),
    ],
    'Malang': [
      _EmergencyContact(
        title: 'AMBULANS MALANG',
        subtitle: 'Layanan tanggap darurat wilayah Malang',
        buttonLabel: 'CALL CENTER 119',
        icon: Icons.emergency_rounded,
        iconColor: Color(0xFFFF175A),
        iconBackground: Color(0xFFFFE2EB),
      ),
      _EmergencyContact(
        title: 'POLRES MALANG',
        subtitle: 'Layanan kepolisian wilayah Malang',
        buttonLabel: 'CALL CENTER (0341) 366444',
        icon: Icons.gpp_good_rounded,
        iconColor: AppColors.welcomeAccent,
        iconBackground: Color(0xFFE5F0FF),
      ),
      _EmergencyContact(
        title: 'LAYANAN PUBLIK',
        subtitle: 'Pengaduan umum dan informasi darurat',
        buttonLabel: 'CALL CENTER 112',
        icon: Icons.call_rounded,
        iconColor: AppColors.welcomeAccent,
        iconBackground: Color(0xFFE5F0FF),
      ),
    ],
  };

  String _selectedRegion = _regions.first;

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeEmergencyNumbers);
  }

  void _showDialPlaceholder(String label) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$label akan segera terhubung.')));
  }

  @override
  Widget build(BuildContext context) {
    final contacts = _servicesByRegion[_selectedRegion]!;

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 34, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedRegion,
                          icon: const Icon(
                            Icons.expand_more_rounded,
                            color: Color(0xFF5D6068),
                            size: 30,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          dropdownColor: Colors.white,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF4F525A),
                          ),
                          items: _regions.map((region) {
                            return DropdownMenuItem<String>(
                              value: region,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xFF5D6068),
                                    size: 26,
                                  ),
                                  const SizedBox(width: 12),
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
                    const SizedBox(height: 28),
                    Text(
                      'Menampilkan kontak darurat untuk wilayah terpilih',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 1.7,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 26),
                    ...List.generate(contacts.length, (index) {
                      final contact = contacts[index];

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == contacts.length - 1 ? 0 : 26,
                        ),
                        child: _EmergencyContactCard(
                          contact: contact,
                          onCallPressed: () =>
                              _showDialPlaceholder(contact.buttonLabel),
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

class _EmergencyContact {
  const _EmergencyContact({
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  });

  final String title;
  final String subtitle;
  final String buttonLabel;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
}

class _EmergencyContactCard extends StatelessWidget {
  const _EmergencyContactCard({
    required this.contact,
    required this.onCallPressed,
  });

  final _EmergencyContact contact;
  final VoidCallback onCallPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
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
              color: contact.iconBackground,
            ),
            child: Icon(contact.icon, size: 48, color: contact.iconColor),
          ),
          const SizedBox(height: 26),
          Text(
            contact.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF27305F),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            contact.subtitle,
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
              label: Text(contact.buttonLabel),
            ),
          ),
        ],
      ),
    );
  }
}
