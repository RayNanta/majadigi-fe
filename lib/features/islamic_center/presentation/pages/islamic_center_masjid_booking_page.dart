import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class IslamicCenterMasjidBookingPage extends StatefulWidget {
  const IslamicCenterMasjidBookingPage({super.key, this.roomName});

  final String? roomName;

  @override
  State<IslamicCenterMasjidBookingPage> createState() =>
      _IslamicCenterMasjidBookingPageState();
}

class _IslamicCenterMasjidBookingPageState
    extends State<IslamicCenterMasjidBookingPage> {
  final _fullNameController = TextEditingController();
  String? _selectedDate;
  String? _selectedSession;

  static const _dates = [
    '24 Mei 2026',
    '25 Mei 2026',
    '26 Mei 2026',
    '27 Mei 2026',
  ];

  static const _sessions = ['Pagi', 'Siang', 'Sore', 'Malam'];

  bool get _canSubmit =>
      _fullNameController.text.trim().isNotEmpty &&
      _selectedDate != null &&
      _selectedSession != null;

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeIslamicCenterMasjidRooms);
  }

  void _handleSubmit() {
    final roomLabel = widget.roomName ?? 'Ruangan Masjid';
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
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFFF7F9FF),
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
                      'Booking Masjid',
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
                        color: context.appTextColor,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Pastikan Anda mengisi data pemesanan dengan benar',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: context.appMutedTextColor,
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
                    const SizedBox(height: 28),
                    const _FieldLabel('Sesi'),
                    const SizedBox(height: 14),
                    _BookingDropdownField(
                      value: _selectedSession,
                      hintText: 'Pilih sesi',
                      items: _sessions,
                      onChanged: (value) => setState(() {
                        _selectedSession = value;
                      }),
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
                disabledBackgroundColor: context.isDarkMode
                    ? AppColors.welcomeAccent.withValues(alpha: 0.28)
                    : const Color(0xFFBFD4FF),
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
        color: context.appTextColor,
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
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: context.appTextColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: context.appMutedTextColor,
        ),
        filled: true,
        fillColor: context.isDarkMode
            ? context.appSearchSurfaceColor
            : const Color(0xFFF0F0F0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 22,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
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
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: context.appMutedTextColor,
        size: 32,
      ),
      dropdownColor: context.appSurfaceColor,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: context.appTextColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: context.appMutedTextColor,
        ),
        filled: true,
        fillColor: context.isDarkMode
            ? context.appSearchSurfaceColor
            : const Color(0xFFF0F0F0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 22,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList(),
    );
  }
}
