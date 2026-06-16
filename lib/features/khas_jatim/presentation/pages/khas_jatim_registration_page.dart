import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../services/khas_jatim_services.dart';

class KhasJatimRegistrationPage extends ConsumerStatefulWidget {
  const KhasJatimRegistrationPage({super.key});

  @override
  ConsumerState<KhasJatimRegistrationPage> createState() =>
      _KhasJatimRegistrationPageState();
}

class _KhasJatimRegistrationPageState
    extends ConsumerState<KhasJatimRegistrationPage> {
  final _ownerNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _titleController = TextEditingController();
  final _periodController = TextEditingController();

  String? _selectedScheme;
  String? _selectedScript;
  String? _selectedLanguage;
  String? _attachedFileName;
  bool _isLoading = false;
  static const _schemes = [
    _RegistrationScheme(
      title: 'Skema 1: Pengalihan Kepemilikan',
      description:
      'Penyerahan fisik naskah kepada negara untuk perawatan profesional permanen.',
    ),
    _RegistrationScheme(
      title: 'Skema 2: Penitipan (Titip Simpan)',
      description:
      'Penitipan fisik naskah untuk perawatan tanpa perpindahan hak milik.',
    ),
    _RegistrationScheme(
      title: 'Skema 3: Pendaftaran (Registrasi)',
      description:
      'Pendataan identitas naskah sementara fisik tetap berada pada pemilik.',
    ),
  ];

  static const _scriptOptions = [
    'Kawi',
    'Jawa',
    'Arab Pegon',
    'Latin',
    'Lontar',
  ];

  static const _languageOptions = [
    'Jawa Kuno',
    'Jawa',
    'Madura',
    'Osing',
    'Indonesia',
  ];

  bool get _canSubmit =>
      _selectedScheme != null &&
          _ownerNameController.text.trim().isNotEmpty &&
          _phoneController.text.trim().isNotEmpty &&
          _addressController.text.trim().isNotEmpty &&
          _titleController.text.trim().isNotEmpty &&
          _periodController.text.trim().isNotEmpty &&
          _selectedScript != null &&
          _selectedLanguage != null &&
          _attachedFileName != null &&
          !_isLoading;

  @override
  void initState() {
    super.initState();
    for (final controller in [
      _ownerNameController,
      _phoneController,
      _addressController,
      _titleController,
      _periodController,
    ]) {
      controller.addListener(_handleFieldChanged);
    }
  }

  @override
  void dispose() {
    _ownerNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _titleController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  void _handleFieldChanged() {
    setState(() {});
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.homeKhasJatimMain);
  }

  void _pickFile() {
    setState(() {
      _attachedFileName = 'scan_naskah_pribadi_${DateTime.now().millisecondsSinceEpoch ~/ 1000}.pdf';
    });
  }

  void _removeFile() {
    setState(() {
      _attachedFileName = null;
    });
  }

  void _submit() async {
    if (!_canSubmit) return;

    setState(() {
      _isLoading = true;
    });

    final service = ref.read(khasJatimServiceProvider);

    final isSuccess = await service.registerNaskahKuno(
      skemaPendaftaran: _selectedScheme!,
      namaPendaftar: _ownerNameController.text.trim(),
      noHpPendaftar: _phoneController.text.trim(),
      alamatPendaftar: _addressController.text.trim(),
      judul: _titleController.text.trim(),
      perkiraanTahun: _periodController.text.trim(),
      jenisAksara: _selectedScript!,
      jenisBahasa: _selectedLanguage!,
      fileLampiranPdf: _attachedFileName!,
    );

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      if (isSuccess) {
        ref.invalidate(khasJatimManuscriptsProvider);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF10B981),
            content: Text('Pendaftaran naskah "${_titleController.text.trim()}'),
          ),
        );
        // Kembali ke halaman daftar utama naskah kuno
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFFEF4444),
            content: Text('Gagal mengirim pendaftaran. Periksa koneksi adb reverse rill.'),
          ),
        );
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
                      'Pendaftaran Naskah Kuno',
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
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pendaftaran Naskah Kuno',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: context.appThemedTextColor(const Color(0xFF2C2F38)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Dinas Perpustakaan dan Kearsipan Provinsi Jawa Timur mengundang masyarakat untuk berpartisipasi dalam penyelamatan warisan budaya melalui pendaftaran naskah kuno. Program ini bertujuan untuk mendata dan melestarikan kekayaan intelektual leluhur Jawa Timur.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.9,
                        color: context.appThemedMutedTextColor(const Color(0xFF8A8F9C)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    for (final scheme in _schemes) ...[
                      _SchemeCard(
                        scheme: scheme,
                        isSelected: _selectedScheme == scheme.title,
                        onTap: () {
                          setState(() {
                            _selectedScheme = scheme.title;
                          });
                        },
                      ),
                      if (scheme != _schemes.last) const SizedBox(height: 16),
                    ],
                    const SizedBox(height: 24),
                    _FormSection(
                      title: 'Identitas Pemilik',
                      child: Column(
                        children: [
                          _LabeledField(
                            label: 'Nama Lengkap',
                            child: _TextInputField(
                              controller: _ownerNameController,
                              hintText: 'Masukkan nama sesuai KTP',
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          const SizedBox(height: 18),
                          _LabeledField(
                            label: 'No.Telepon / WhatsApp',
                            child: _TextInputField(
                              controller: _phoneController,
                              hintText: 'Masukkan nomor telepon',
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(height: 18),
                          _LabeledField(
                            label: 'Alamat Lengkap',
                            child: _TextInputField(
                              controller: _addressController,
                              hintText: 'Masukkan alamat lengkap',
                              keyboardType: TextInputType.streetAddress,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _FormSection(
                      title: 'Keterangan Naskah',
                      child: Column(
                        children: [
                          _LabeledField(
                            label: 'Nama / Judul Naskah',
                            child: _TextInputField(
                              controller: _titleController,
                              hintText: 'Contoh: Serat Centhini',
                            ),
                          ),
                          const SizedBox(height: 18),
                          _LabeledField(
                            label: 'Perkiraan Masa Penyusunan',
                            child: _TextInputField(
                              controller: _periodController,
                              hintText: 'Abad ke-18 / Tahun 1750',
                            ),
                          ),
                          const SizedBox(height: 18),
                          _LabeledField(
                            label: 'Aksara',
                            child: _DropdownField(
                              hintText: 'Pilih Aksara',
                              value: _selectedScript,
                              options: _scriptOptions,
                              onChanged: (value) {
                                setState(() {
                                  _selectedScript = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 18),
                          _LabeledField(
                            label: 'Bahasa',
                            child: _DropdownField(
                              hintText: 'Pilih Bahasa',
                              value: _selectedLanguage,
                              options: _languageOptions,
                              onChanged: (value) {
                                setState(() {
                                  _selectedLanguage = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _FormSection(
                      title: 'Foto / Gambar Naskah',
                      child: _UploadField(
                        fileName: _attachedFileName,
                        onPickFile: _pickFile,
                        onRemoveFile: _removeFile,
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
              onPressed: _canSubmit ? _submit : null,
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

class _RegistrationScheme {
  const _RegistrationScheme({required this.title, required this.description});
  final String title;
  final String description;
}

class _SchemeCard extends StatelessWidget {
  const _SchemeCard({required this.scheme, required this.isSelected, required this.onTap});
  final _RegistrationScheme scheme;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appSurfaceColor,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border(
              left: BorderSide(
                color: isSelected ? AppColors.welcomeAccent : Colors.grey.withValues(alpha: 0.3),
                width: 4,
              ),
            ),
            boxShadow: context.appThemedCardShadows([
              BoxShadow(
                color: const Color(0xFF111827).withValues(alpha: 0.04),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                scheme.title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? AppColors.welcomeAccent : context.appTextColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                scheme.description,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                  color: context.appMutedTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.welcomeAccent),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700, color: context.appTextColor),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _TextInputField extends StatelessWidget {
  const _TextInputField({required this.controller, required this.hintText, this.keyboardType});
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w500, color: context.appTextColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w500, color: context.appMutedTextColor),
        filled: true,
        fillColor: context.isDarkMode ? context.appSearchSurfaceColor : const Color(0xFFF0F1F5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({required this.hintText, required this.value, required this.options, required this.onChanged});
  final String hintText;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: options.map((opt) => DropdownMenuItem<String>(value: opt, child: Text(opt))).toList(),
      onChanged: onChanged,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: context.appMutedTextColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w500, color: context.appMutedTextColor),
        filled: true,
        fillColor: context.isDarkMode ? context.appSearchSurfaceColor : const Color(0xFFF0F1F5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
      style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w500, color: context.appTextColor),
      dropdownColor: context.appSurfaceColor,
    );
  }
}

class _UploadField extends StatelessWidget {
  const _UploadField({required this.fileName, required this.onPickFile, required this.onRemoveFile});
  final String? fileName;
  final VoidCallback onPickFile;
  final VoidCallback onRemoveFile;

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: BoxDecoration(
        color: context.isDarkMode ? context.appSearchSurfaceColor : const Color(0xFFFDFEFF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.isDarkMode ? context.appBorderColor : const Color(0xFFD6E5FF), width: 2),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: context.isDarkMode ? context.appSurfaceColor : const Color(0xFFDCE9FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.file_upload_outlined, size: 34, color: AppColors.welcomeAccent),
          ),
          const SizedBox(height: 14),
          Text(
            hasFile ? fileName! : 'Format: JPG, PNG, atau PDF (Maks. 10MB)',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w500, height: 1.5, color: context.appMutedTextColor),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              OutlinedButton(
                key: const Key('khas-jatim-file-button'),
                onPressed: onPickFile,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.welcomeAccent,
                  side: const BorderSide(color: AppColors.welcomeAccent, width: 1.6),
                  minimumSize: const Size(124, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  textStyle: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                child: Text(hasFile ? 'Ganti File' : 'Pilih File'),
              ),
              if (hasFile)
                TextButton(
                  onPressed: onRemoveFile,
                  style: TextButton.styleFrom(
                    foregroundColor: context.appMutedTextColor,
                    textStyle: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Hapus'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}