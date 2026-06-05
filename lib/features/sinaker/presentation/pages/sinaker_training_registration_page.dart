import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../services/sinaker_service.dart';

class SinakerTrainingRegistrationPage extends StatefulWidget {
  final int trainingId;
  final String trainingName;

  const SinakerTrainingRegistrationPage({
    super.key,
    required this.trainingId,
    required this.trainingName,
  });

  @override
  State<SinakerTrainingRegistrationPage> createState() =>
      _SinakerTrainingRegistrationPageState();
}

class _SinakerTrainingRegistrationPageState
    extends State<SinakerTrainingRegistrationPage> {
  final _service = SinakerService();

  bool _isLoading = false;
  late final TextEditingController _nameController;
  late final TextEditingController _nikController;
  late final TextEditingController _whatsAppController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController()..addListener(_refresh);
    _nikController = TextEditingController()..addListener(_refresh);
    _whatsAppController = TextEditingController()..addListener(_refresh);
  }

  @override
  void dispose() {
    _nameController
      ..removeListener(_refresh)
      ..dispose();
    _nikController
      ..removeListener(_refresh)
      ..dispose();
    _whatsAppController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  bool get _isFormComplete {
    return _nameController.text.trim().isNotEmpty &&
        _nikController.text.trim().isNotEmpty &&
        _whatsAppController.text.trim().isNotEmpty;
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeSinakerTrainingList);
  }

  Future<void> _submit() async {
    if (!_isFormComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi semua data pendaftaran terlebih dahulu.'),
        ),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final result = await _service.joinTraining({
        'training_id': widget.trainingId,
        'nama': _nameController.text,
        'nik': _nikController.text,
        'no_telp': _whatsAppController.text,
      });

      if (result['success'] == true) {
        if (!mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result['message'])));

        context.pop();
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Gagal mendaftar pelatihan'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
                      'Pelatihan Kerja',
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
                      widget.trainingName,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: context.appThemedTextColor(
                          const Color(0xFF2D3162),
                        ),
                        height: 1.22,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(26, 28, 26, 28),
                      decoration: BoxDecoration(
                        color: context.appSurfaceColor,
                        borderRadius: BorderRadius.circular(34),
                        boxShadow: context.appThemedCardShadows([
                          BoxShadow(
                            color: const Color(
                              0xFF111827,
                            ).withValues(alpha: 0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ]),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lengkapi Formulir',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: context.appThemedTextColor(
                                const Color(0xFF2D3162),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Pastikan data yang Anda masukkan sudah sesuai dengan identitas resmi.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: context.appThemedMutedTextColor(
                                const Color(0xFF60658D),
                              ),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 28),
                          _FormLabel('Nama Lengkap'),
                          const SizedBox(height: 14),
                          _FormField(
                            controller: _nameController,
                            hintText: 'Masukkan nama sesuai KTP',
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 28),
                          _FormLabel('NIK'),
                          const SizedBox(height: 14),
                          _FormField(
                            controller: _nikController,
                            hintText: '16 digit nomor KTP',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 28),
                          _FormLabel('Nomor WhatsApp'),
                          const SizedBox(height: 14),
                          _FormField(
                            controller: _whatsAppController,
                            hintText: 'Masukkan nomor WhatsApp',
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                          ),
                        ],
                      ),
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
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 18),
          child: SizedBox(
            height: 70,
            child: FilledButton(
              onPressed: _isLoading ? null : _submit,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.welcomeAccent,
                disabledBackgroundColor: AppColors.welcomeAccent.withValues(
                  alpha: 0.45,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Daftar'),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormLabel extends StatelessWidget {
  const _FormLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: context.appThemedTextColor(const Color(0xFF363A42)),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.isDarkMode
          ? context.appSubtleSurfaceColor
          : const Color(0xFFF0F0F2),
      borderRadius: BorderRadius.circular(22),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: context.appThemedTextColor(const Color(0xFF2F3136)),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: context.appThemedMutedTextColor(const Color(0xFF9A9EA6)),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 22,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: AppColors.welcomeAccent,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
