import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class RsudSaifulAnwarMainPage extends StatefulWidget {
  const RsudSaifulAnwarMainPage({super.key});

  @override
  State<RsudSaifulAnwarMainPage> createState() =>
      _RsudSaifulAnwarMainPageState();
}

class _RsudSaifulAnwarMainPageState extends State<RsudSaifulAnwarMainPage> {
  static const _classOptions = ['Kelas', 'VIP', 'Rawat Inap', 'ICU', 'HCU'];

  static const _rooms = [
    _RoomAvailability(
      badgeText: 'INSTALASI RAWAT INAP',
      badgeBackground: Color(0xFFE8F1FF),
      badgeColor: Color(0xFF2563EB),
      name: 'R. SEMERU',
      classLabel: 'I, II, III',
      occupied: 42,
      available: 18,
      icon: Icons.bed_rounded,
      progressValue: 0.30,
      progressColor: Color(0xFF2DB36B),
    ),
    _RoomAvailability(
      badgeText: 'HIGH CARE UNIT',
      badgeBackground: Color(0xFFFFE7EF),
      badgeColor: Color(0xFFE11D48),
      name: 'R. HCU SARANGAN',
      classLabel: 'HCU',
      occupied: 12,
      available: 2,
      icon: Icons.monitor_heart_outlined,
      progressValue: 0.17,
      progressColor: Color(0xFF2DB36B),
    ),
    _RoomAvailability(
      badgeText: 'VIP / SUPER VIP',
      badgeBackground: Color(0xFFF6E9FF),
      badgeColor: Color(0xFF9333EA),
      name: 'R. BUGENVILE',
      classLabel: 'VIP',
      occupied: 28,
      available: 5,
      icon: Icons.star_border_rounded,
      progressValue: 0.18,
      progressColor: Color(0xFF2DB36B),
    ),
    _RoomAvailability(
      badgeText: 'INTENSIVE CARE UNIT',
      badgeBackground: Color(0xFFFFE8ED),
      badgeColor: Color(0xFFE11D48),
      name: 'R. ICU KAPUAS B',
      classLabel: 'ICU',
      occupied: 18,
      available: 0,
      icon: Icons.medical_services_outlined,
      progressValue: 1.0,
      progressColor: Color(0xFFE11D48),
      warningText: 'Antrian penuh untuk ruangan ini.',
    ),
  ];

  String _selectedClass = _classOptions.first;

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeRsudSaifulAnwar);
  }

  @override
  Widget build(BuildContext context) {
    final visibleRooms = _rooms.where((room) {
      if (_selectedClass == 'Kelas') {
        return true;
      }

      final selected = _selectedClass.toLowerCase();
      return room.badgeText.toLowerCase().contains(selected) ||
          room.classLabel.toLowerCase().contains(selected);
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
                      'RSUD SAIFUL ANWAR',
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
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFF30B566),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Terakhir Diperbarui',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF9A9EA6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Senin, 24 Mei 2024',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2B2E35),
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Pukul 14:30 WIB',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8E929B),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: const [
                        Expanded(
                          child: _SummaryCard(
                            value: '966',
                            label: 'TOTAL',
                            valueColor: Color(0xFF1668F7),
                          ),
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: _SummaryCard(
                            value: '340',
                            label: 'TERSEDIA',
                            valueColor: Color(0xFF2DB36B),
                          ),
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: _SummaryCard(
                            value: '595',
                            label: 'TERISI',
                            valueColor: Color(0xFFFF0D57),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 34),
                    Text(
                      'Ketersediaan Ruang',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2B2E35),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F2),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedClass,
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
                          items: _classOptions.map((option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }

                            setState(() {
                              _selectedClass = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...visibleRooms.map(
                      (room) => Padding(
                        padding: const EdgeInsets.only(bottom: 22),
                        child: _RoomCard(item: room),
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

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: const Color(0xFF9A9EA6),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomAvailability {
  const _RoomAvailability({
    required this.badgeText,
    required this.badgeBackground,
    required this.badgeColor,
    required this.name,
    required this.classLabel,
    required this.occupied,
    required this.available,
    required this.icon,
    required this.progressValue,
    required this.progressColor,
    this.warningText,
  });

  final String badgeText;
  final Color badgeBackground;
  final Color badgeColor;
  final String name;
  final String classLabel;
  final int occupied;
  final int available;
  final IconData icon;
  final double progressValue;
  final Color progressColor;
  final String? warningText;
}

class _RoomCard extends StatelessWidget {
  const _RoomCard({required this.item});

  final _RoomAvailability item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: item.badgeBackground,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        item.badgeText,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: item.badgeColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      item.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2B2E35),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F1FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 34,
                  color: AppColors.welcomeAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Divider(height: 1, color: Color(0xFFE3E5EA)),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: _MetricColumn(
                  label: 'KELAS',
                  value: item.classLabel,
                  valueColor: const Color(0xFF2B2E35),
                ),
              ),
              Expanded(
                child: _MetricColumn(
                  label: 'TERISI',
                  value: '${item.occupied}',
                  valueColor: const Color(0xFFE11D48),
                ),
              ),
              Expanded(
                child: _AvailabilityMetric(
                  available: item.available,
                  progressValue: item.progressValue,
                  progressColor: item.progressColor,
                ),
              ),
            ],
          ),
          if (item.warningText != null) ...[
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4E8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFFE11D48),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.warningText!,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFE11D48),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MetricColumn extends StatelessWidget {
  const _MetricColumn({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF666A73),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _AvailabilityMetric extends StatelessWidget {
  const _AvailabilityMetric({
    required this.available,
    required this.progressValue,
    required this.progressColor,
  });

  final int available;
  final double progressValue;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TERSEDIA',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF666A73),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '$available',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2DB36B),
          ),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progressValue,
            minHeight: 6,
            backgroundColor: const Color(0xFFD8F5E6),
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ),
      ],
    );
  }
}
