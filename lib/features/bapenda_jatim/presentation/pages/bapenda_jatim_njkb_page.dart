import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class BapendaJatimNjkbPage extends StatefulWidget {
  const BapendaJatimNjkbPage({super.key});

  @override
  State<BapendaJatimNjkbPage> createState() => _BapendaJatimNjkbPageState();
}

class _BapendaJatimNjkbPageState extends State<BapendaJatimNjkbPage> {
  String? _selectedVehicleType;
  String? _selectedBrand;
  String? _selectedYear;
  String? _selectedModel;
  String? _selectedTrim;

  static const _vehicleTypes = [
    'Sepeda Motor',
    'Mobil Penumpang',
    'Mobil Barang',
  ];

  static const _brands = ['Honda', 'Toyota', 'Yamaha', 'Suzuki'];

  static const _years = [
    '2026',
    '2025',
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
    '2019',
    '2018',
    '2017',
    '2016',
    '2015',
  ];

  static const _models = ['Beat', 'Vario', 'Avanza', 'NMAX'];
  static const _trims = ['CBS', 'Deluxe', 'Sport', 'Standard'];

  bool get _canSubmit =>
      _selectedVehicleType != null &&
      _selectedBrand != null &&
      _selectedYear != null &&
      _selectedModel != null &&
      _selectedTrim != null;

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeBapendaJatimMain);
  }

  void _handleSubmit() {
    context.pushNamed(
      RouteNames.homeBapendaJatimNjkbResult,
      extra: <String, String>{
        'vehicleType': _selectedVehicleType ?? '',
        'brand': _selectedBrand ?? '',
        'year': _selectedYear ?? '',
        'model': _selectedModel ?? '',
        'trim': _selectedTrim ?? '',
      },
    );
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
                      'Informasi NJKB',
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
                padding: const EdgeInsets.fromLTRB(24, 30, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Kendaraan',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: context.appThemedTextColor(
                          const Color(0xFF2A2E35),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Masukkan data kendaraan Anda',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: context.appMutedTextColor,
                      ),
                    ),
                    const SizedBox(height: 34),
                    const _FieldLabel('Jenis Kendaraan'),
                    const SizedBox(height: 14),
                    _DropdownField(
                      value: _selectedVehicleType,
                      hintText: 'Masukkan plat nomor kendaraan',
                      items: _vehicleTypes,
                      onChanged: (value) => setState(() {
                        _selectedVehicleType = value;
                      }),
                    ),
                    const SizedBox(height: 28),
                    const _FieldLabel('Merk Kendaraan'),
                    const SizedBox(height: 14),
                    _DropdownField(
                      value: _selectedBrand,
                      hintText: 'Pilih merk kendaraan',
                      items: _brands,
                      onChanged: (value) => setState(() {
                        _selectedBrand = value;
                      }),
                    ),
                    const SizedBox(height: 28),
                    const _FieldLabel('Tahun Kendaraan'),
                    const SizedBox(height: 14),
                    _DropdownField(
                      value: _selectedYear,
                      hintText: 'Pilih tahun kendaraan',
                      items: _years,
                      onChanged: (value) => setState(() {
                        _selectedYear = value;
                      }),
                    ),
                    const SizedBox(height: 28),
                    const _FieldLabel('Model Kendaraan'),
                    const SizedBox(height: 14),
                    _DropdownField(
                      value: _selectedModel,
                      hintText: 'Pilih model kendaraan',
                      items: _models,
                      onChanged: (value) => setState(() {
                        _selectedModel = value;
                      }),
                    ),
                    const SizedBox(height: 28),
                    const _FieldLabel('Tipe Kendaraan'),
                    const SizedBox(height: 14),
                    _DropdownField(
                      value: _selectedTrim,
                      hintText: 'Pilih tipe kendaraan',
                      items: _trims,
                      onChanged: (value) => setState(() {
                        _selectedTrim = value;
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
                    ? const Color(0xFF294569)
                    : const Color(0xFFBFD4FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('Cari Data'),
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
        color: context.appThemedTextColor(const Color(0xFF2A2E35)),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
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
      key: ValueKey('$hintText-${value ?? 'empty'}'),
      initialValue: value,
      onChanged: onChanged,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: context.appThemedTextColor(const Color(0xFF555555)),
        size: 28,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: context.isDarkMode
            ? context.appSubtleSurfaceColor
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
      hint: Text(
        hintText,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: context.appThemedMutedTextColor(const Color(0xFF9A9A9A)),
        ),
      ),
      style: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: context.appThemedTextColor(const Color(0xFF2A2E35)),
      ),
      dropdownColor: context.appSurfaceColor,
      items: items
          .map(
            (item) => DropdownMenuItem<String>(value: item, child: Text(item)),
          )
          .toList(),
    );
  }
}
