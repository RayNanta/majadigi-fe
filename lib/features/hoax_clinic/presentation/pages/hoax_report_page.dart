import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 🟢 Tambahkan Riverpod
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../services/hoax_services.dart';

class HoaxReportPage extends ConsumerStatefulWidget {
  const HoaxReportPage({super.key});

  @override
  ConsumerState<HoaxReportPage> createState() => _HoaxReportPageState();
}

class _HoaxReportPageState extends ConsumerState<HoaxReportPage> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _whatsAppController;
  late final TextEditingController _reportController;
  late final TextEditingController _sourceController;

  String? _selectedAttachmentName;
  bool _isLoading = false; // 🟢 State loading saat kirim ke Laravel

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _whatsAppController = TextEditingController();
    _reportController = TextEditingController();
    _sourceController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _whatsAppController.dispose();
    _reportController.dispose();
    _sourceController.dispose();
    super.dispose();
  }

  bool get _isFormComplete {
    return _fullNameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _whatsAppController.text.trim().isNotEmpty &&
        _reportController.text.trim().isNotEmpty &&
        _sourceController.text.trim().isNotEmpty &&
        !_isLoading;
  }

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.homeHoaxClinicMain);
  }
void _handleSubmit(BuildContext context) async {
    if (!_isFormComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi dulu semua isian wajib laporan hoaks.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final service = ref.read(hoaxServiceProvider);

    final isSuccess = await service.postLaporHoax(
      namaPelapor: _fullNameController.text.trim(),
      deskripsiLaporan: _reportController.text.trim(),
      urlBukti: _sourceController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF10B981),
            content: Text('Laporan hoaks "${_titleTruncate(_fullNameController.text)}" berhasil terkirim!'),
          ),
        );
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFFEF4444),
            content: Text('Gagal mengirim laporan. Coba cek route:post Laravel-mu.'),
          ),
        );
      }
    }
  }

  String _titleTruncate(String text) => text.length > 15 ? '${text.substring(0, 15)}...' : text;

  void _handleChooseAttachment() {
    setState(() {
      _selectedAttachmentName ??= 'tangkapan_layar_hoaks.jpg';
    });
  }

  void _removeAttachment() {
    setState(() {
      _selectedAttachmentName = null;
    });
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
                      'Laporan Hoaks',
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
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? context.appSubtleSurfaceColor
                            : const Color(0xFFDCEBFF),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 5,
                            height: 148,
                            decoration: BoxDecoration(
                              color: AppColors.welcomeAccent,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Text(
                              'Kirimkan detail informasi yang kamu dapat, akan kami bantu cari klarifikasinya dalam 1×24 jam.',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1.55,
                                color: context.appMutedTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    const _FieldLabel(label: 'Nama Lengkap'),
                    const SizedBox(height: 10),
                    _ReportInputField(
                      controller: _fullNameController,
                      hintText: 'Masukkan nama lengkap',
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(height: 26),
                    const _FieldLabel(label: 'Email Aktif'),
                    const SizedBox(height: 10),
                    _ReportInputField(
                      controller: _emailController,
                      hintText: 'Masukkan alamat email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 26),
                    const _FieldLabel(label: 'Nomor WhatsApp'),
                    const SizedBox(height: 10),
                    _ReportInputField(
                      controller: _whatsAppController,
                      hintText: 'Masukkan nomor WhatsApp',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 26),
                    const _FieldLabel(label: 'Narasi Laporan'),
                    const SizedBox(height: 10),
                    _ReportInputField(
                      controller: _reportController,
                      hintText: 'Isi laporan dugaan berita hoaks',
                      minLines: 4,
                      maxLines: 6,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 26),
                    const _FieldLabel(label: 'Tautan Sumber'),
                    const SizedBox(height: 10),
                    _ReportInputField(
                      controller: _sourceController,
                      hintText: 'Link bukti/alamat website berita',
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(height: 26),
                    const _FieldLabel(label: 'Lampiran Tangkapan Layar'),
                    const SizedBox(height: 14),
                    _AttachmentPicker(
                      selectedAttachmentName: _selectedAttachmentName,
                      onPick: _handleChooseAttachment,
                      onRemove: _removeAttachment,
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'Laporan Anda akan dienkripsi secara aman untuk menjaga privasi narasumber tim Majadidi',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          height: 1.45,
                          color: context.appMutedTextColor,
                        ),
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
            height: 66,
            child: FilledButton(
              onPressed: _isFormComplete ? () => _handleSubmit(context) : null, // 🟢 Sesuai kelengkapan form
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.welcomeAccent,
                disabledBackgroundColor: AppColors.welcomeAccent.withValues(alpha: 0.55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
                textStyle: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              child: _isLoading
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                  : const Text('Kirim'),
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: context.appThemedTextColor(const Color(0xFF4E525A)),
      ),
    );
  }
}

class _ReportInputField extends StatelessWidget {
  const _ReportInputField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.minLines = 1,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      minLines: minLines,
      maxLines: maxLines,
      style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w500, color: context.appTextColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w400, color: context.appMutedTextColor),
        filled: true,
        fillColor: context.isDarkMode ? context.appSubtleSurfaceColor : const Color(0xFFF0F0F2),
        contentPadding: const EdgeInsets.all(18),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22), borderSide: const BorderSide(color: AppColors.welcomeAccent, width: 2)),
      ),
    );
  }
}

class _AttachmentPicker extends StatelessWidget {
  const _AttachmentPicker({required this.selectedAttachmentName, required this.onPick, required this.onRemove});
  final String? selectedAttachmentName;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPick,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 28, 18, 24),
        decoration: BoxDecoration(
          color: context.isDarkMode ? context.appSubtleSurfaceColor : const Color(0xFFF4F4F5),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: context.isDarkMode ? context.appBorderColor : const Color(0xFFD3D5DB), width: 2),
        ),
        child: Column(
          children: [
            const Icon(Icons.file_upload_outlined, size: 46, color: AppColors.welcomeAccent),
            const SizedBox(height: 16),
            Text(
              selectedAttachmentName == null ? 'Choose File' : 'File terlampir',
              style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w700, color: context.appTextColor),
            ),
            const SizedBox(height: 14),
            Text(
              selectedAttachmentName ?? 'MAKSIMAL 2MB (JPG/PNG)',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w500, color: context.appMutedTextColor),
            ),
            if (selectedAttachmentName != null) ...[
              const SizedBox(height: 18),
              OutlinedButton.icon(
                onPressed: onRemove,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444),
                  side: const BorderSide(color: Color(0xFFEF4444), width: 1.4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                icon: const Icon(Icons.close_rounded, size: 18),
                label: Text('Hapus lampiran', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}