import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class IslamicCenterAsramaBookingPage extends StatefulWidget {
  const IslamicCenterAsramaBookingPage({super.key, this.roomName});

  final String? roomName;

  @override
  State<IslamicCenterAsramaBookingPage> createState() =>
      _IslamicCenterAsramaBookingPageState();
}

class _IslamicCenterAsramaBookingPageState
    extends State<IslamicCenterAsramaBookingPage> {
  final _fullNameController = TextEditingController();
  String? _selectedDate;
  final Set<String> _selectedFacilities = {};

  static const _dates = [
    '24 Mei 2026',
    '25 Mei 2026',
    '26 Mei 2026',
    '27 Mei 2026',
  ];

  static const _facilities = [
    'Karpet',
    'Kursi',
    'Genset',
    'AC',
    'Kamar Rias',
    'Mimbar',
    'Meja & Kursi Penerima Tamu',
  ];

  bool get _canSubmit =>
      _fullNameController.text.trim().isNotEmpty && _selectedDate != null;

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeIslamicCenterAsramaRooms);
  }

  void _handleSubmit() {
    final roomLabel = widget.roomName ?? 'Asrama';
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Data pemesanan $roomLabel siap diproses.',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
          ),
        ),
      );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
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
                    onPressed: () => _handleBack(context),
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
                      'Booking Asrama',
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
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Pemesanan',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2A2E35),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Pastikan Anda mengisi data pemesanan dengan benar',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 34),
                    const _FieldLabel('Nama Lengkap'),
                    const SizedBox(height: 14),
                    _BookingTextField(
                      controller: _fullNameController,
                      hintText: 'Masukkan nama lengkap',
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 28),
                    const _FieldLabel('Tanggal'),
                    const SizedBox(height: 14),
                    _BookingDropdownField(
                      value: _selectedDate,
                      hintText: 'Pilih tanggal',
                      items: _dates,
                      onChanged: (value) => setState(() {
                        _selectedDate = value;
                      }),
                    ),
                    const SizedBox(height: 30),
                    const _FieldLabel('Fasilitas'),
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 18,
                      runSpacing: 18,
                      children: _facilities.map((facility) {
                        final isWide = facility == 'Meja & Kursi Penerima Tamu';
                        final isSelected = _selectedFacilities.contains(
                          facility,
                        );
                        return _FacilityOptionTile(
                          label: facility,
                          isSelected: isSelected,
                          isWide: isWide,
                          onTap: () => setState(() {
                            if (isSelected) {
                              _selectedFacilities.remove(facility);
                            } else {
                              _selectedFacilities.add(facility);
                            }
                          }),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 22),
          child: SizedBox(
            height: 64,
            child: FilledButton(
              onPressed: _canSubmit ? _handleSubmit : null,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.welcomeAccent,
                disabledBackgroundColor: const Color(0xFFBFD4FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('Pesan'),
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF2A2E35),
      ),
    );
  }
}

class _BookingTextField extends StatelessWidget {
  const _BookingTextField({
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF2A2E35),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF8F949C),
        ),
        filled: true,
        fillColor: const Color(0xFFF1F1F4),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 22,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _BookingDropdownField extends StatelessWidget {
  const _BookingDropdownField({
    required this.value,
    required this.hintText,
    required this.items,
    required this.onChanged,
  });

  final String? value;
  final String hintText;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      onChanged: onChanged,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 30,
        color: Color(0xFF666B73),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF1F1F4),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 22,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
      hint: Text(
        hintText,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF8F949C),
        ),
      ),
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF2A2E35),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(value: item, child: Text(item)),
          )
          .toList(),
    );
  }
}

class _FacilityOptionTile extends StatelessWidget {
  const _FacilityOptionTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isWide = false,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final tile = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Ink(
          width: isWide ? double.infinity : 391 / 2 - 33,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F4),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isSelected
                  ? AppColors.welcomeAccent
                  : const Color(0xFFF1F1F4),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.welcomeAccent
                        : const Color(0xFF8F949C),
                    width: 1.5,
                  ),
                  color: isSelected
                      ? AppColors.welcomeAccent.withValues(alpha: 0.10)
                      : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 18,
                        color: AppColors.welcomeAccent,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4E535B),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (isWide) {
      return SizedBox(width: double.infinity, child: tile);
    }

    return tile;
  }
}
