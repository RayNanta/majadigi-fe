import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:majadigi_mobile/features/bapenda_jatim/services/bapenda_service.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class BapendaJatimPkbPage extends StatefulWidget {
  const BapendaJatimPkbPage({super.key});

  @override
  State<BapendaJatimPkbPage> createState() => _BapendaJatimPkbPageState();
}

final _bapendaService = BapendaService();
bool _isLoading = false;

class _BapendaJatimPkbPageState extends State<BapendaJatimPkbPage> {
  final _plateNumberController = TextEditingController();
  final _chassisNumberController = TextEditingController();

  bool get _canSubmit =>
      _plateNumberController.text.trim().isNotEmpty &&
      _chassisNumberController.text.trim().length == 5;

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeBapendaJatimMain);
  }

  Future<void> _handleSubmit() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _bapendaService.cekPajak(
        nomorPolisi: _plateNumberController.text
            .trim()
            .toUpperCase(),
        nomorRangka: _chassisNumberController.text.trim(),
      );

      if (!mounted) return;

      if (result['success'] == true) {
        context.pushNamed(
          RouteNames.homeBapendaJatimPkbResult,
          extra: result['data'],
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['message'] ??
                  'Data kendaraan tidak ditemukan',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _plateNumberController.dispose();
    _chassisNumberController.dispose();
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
                      'Informasi PKB',
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
                    const _FieldLabel('Plat Nomor Kendaraan'),
                    const SizedBox(height: 14),
                    _InputField(
                      controller: _plateNumberController,
                      hintText: 'Masukkan plat nomor kendaraan',
                      textCapitalization: TextCapitalization.characters,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 28),
                    const _FieldLabel('5 Digit Terakhir Nomor Rangka'),
                    const SizedBox(height: 14),
                    _InputField(
                      controller: _chassisNumberController,
                      hintText: 'Masukkan 5 digit terakhir nomor rangka',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(5),
                      ],
                      onChanged: (_) => setState(() {}),
                    ),
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
              child: _isLoading
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
                  : const Text('Cari Data'),            ),
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

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: context.appThemedTextColor(const Color(0xFF2A2E35)),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: context.appThemedMutedTextColor(const Color(0xFF9A9A9A)),
        ),
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
    );
  }
}
