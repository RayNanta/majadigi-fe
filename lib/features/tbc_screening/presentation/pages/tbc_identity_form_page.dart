import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class TbcIdentityFormPage extends StatefulWidget {
  const TbcIdentityFormPage({super.key});

  @override
  State<TbcIdentityFormPage> createState() => _TbcIdentityFormPageState();
}

enum _SelfScreeningChoice { yes, no }

class _TbcIdentityFormPageState extends State<TbcIdentityFormPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _nikController;

  late final TextEditingController _reporterNameController;

  late final TextEditingController _institutionNameController;

  late final TextEditingController _reporterPhoneController;

  late final TextEditingController _screenedNameController;

  late final TextEditingController _screenedNikController;

  _SelfScreeningChoice? _choice;

  String? _selectedGroup;

  bool isLoading = false;

  static const _groupOptions = [
    'Keluarga',
    'Tetangga',
    'Teman',
    'Instansi',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _nikController = TextEditingController();

    _reporterNameController = TextEditingController();

    _institutionNameController = TextEditingController();

    _reporterPhoneController = TextEditingController();

    _screenedNameController = TextEditingController();

    _screenedNikController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nikController.dispose();

    _reporterNameController.dispose();

    _institutionNameController.dispose();

    _reporterPhoneController.dispose();

    _screenedNameController.dispose();

    _screenedNikController.dispose();

    super.dispose();
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeTbcScreening);
  }

  Future<void> _selectGroup() async {
    final selectedValue = await showModalBottomSheet<String>(
      context: context,

      backgroundColor: context.appSurfaceColor,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),

      builder: (context) {
        return SafeArea(
          top: false,

          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Center(
                  child: Container(
                    width: 54,
                    height: 6,

                    decoration: BoxDecoration(
                      color: context.appHandleColor,

                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  'Pilih Kelompok',

                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,

                    color: context.appTextColor,
                  ),
                ),

                const SizedBox(height: 12),

                ..._groupOptions.map((option) {
                  final isSelected = option == _selectedGroup;

                  return ListTile(
                    contentPadding: EdgeInsets.zero,

                    title: Text(
                      option,

                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,

                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,

                        color: isSelected
                            ? AppColors.welcomeAccent
                            : context.appTextColor,
                      ),
                    ),

                    trailing: isSelected
                        ? const Icon(
                            Icons.check_rounded,
                            color: AppColors.welcomeAccent,
                          )
                        : null,

                    onTap: () => context.pop(option),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );

    if (selectedValue == null) return;

    setState(() {
      _selectedGroup = selectedValue;
    });
  }

  Future<void> submitData() async {
    final isSelf = _choice == _SelfScreeningChoice.yes;

    if (_choice == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pilih jenis skrining')));

      return;
    }

    if (isSelf) {
      if (_nameController.text.isEmpty || _nikController.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Lengkapi data diri')));

        return;
      }
    } else {
      if (_reporterNameController.text.isEmpty ||
          _selectedGroup == null ||
          _reporterPhoneController.text.isEmpty ||
          _screenedNameController.text.isEmpty ||
          _screenedNikController.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Lengkapi seluruh data')));

        return;
      }
    }

    final identityData = {
      "is_self_screening": isSelf,

      // SELF
      "pelapor_nama": isSelf ? _nameController.text : null,

      "pelapor_nik": isSelf ? _nikController.text : null,

      // BANTU LAPOR
      "bantu_lapor_nama": !isSelf ? _reporterNameController.text : null,

      "bantu_lapor_nik": !isSelf ? _screenedNikController.text : null,

      "pelapor_kelompok": !isSelf ? _selectedGroup : null,

      "pelapor_instansi": !isSelf ? _institutionNameController.text : null,

      "pelapor_no_telp": !isSelf ? _reporterPhoneController.text : null,

      // PASIEN
      "nama_pasien": !isSelf
          ? _screenedNameController.text
          : _nameController.text,

      "nik_pasien": !isSelf ? _screenedNikController.text : _nikController.text,
    };

    context.pushNamed(RouteNames.homeTbcPersonalIdentity, extra: identityData);
  }

  @override
  Widget build(BuildContext context) {
    final isNoState = _choice == _SelfScreeningChoice.no;

    return Scaffold(
      backgroundColor: context.appThemedScaffoldColor(const Color(0xFFF7F9FF)),

      body: SafeArea(
        bottom: false,

        child: Column(
          children: [
            // HEADER
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
                      'Formulir Identitas',

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
                    const IdentityFormNotice(),

                    const SizedBox(height: 34),

                    Text(
                      'Anda melakukan skrining untuk diri Anda sendiri?',

                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,

                        fontWeight: FontWeight.w700,

                        color: context.appThemedTextColor(
                          const Color(0xFF55585E),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: _ScreeningChoiceCard(
                            label: 'Ya',

                            isSelected: _choice == _SelfScreeningChoice.yes,

                            activeColor: const Color(0xFF28B65E),

                            activeBackground: const Color(0xFFD9F5E2),

                            onTap: () {
                              setState(() {
                                _choice = _SelfScreeningChoice.yes;
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: _ScreeningChoiceCard(
                            label: 'Tidak',

                            isSelected: _choice == _SelfScreeningChoice.no,

                            activeColor: const Color(0xFFFF2156),

                            activeBackground: const Color(0xFFFFD8E4),

                            onTap: () {
                              setState(() {
                                _choice = _SelfScreeningChoice.no;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 34),

                    if (isNoState) _buildNonSelfForm() else _buildSelfForm(),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        top: false,

        child: Container(
          color: context.appSurfaceColor,

          padding: const EdgeInsets.fromLTRB(24, 18, 24, 20),

          child: SizedBox(
            height: 66,

            child: FilledButton(
              onPressed: isLoading ? null : submitData,

              style: FilledButton.styleFrom(
                backgroundColor: AppColors.welcomeAccent,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33),
                ),
              ),

              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Selanjutnya'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelfForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          'Masukkan Identitas Anda',

          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: context.appThemedTextColor(const Color(0xFF55585E)),
          ),
        ),

        const SizedBox(height: 30),

        _IdentityField(
          label: 'Nama Lengkap',

          hintText: 'Masukkan nama lengkap',

          controller: _nameController,
        ),

        const SizedBox(height: 28),

        _IdentityField(
          label: 'NIK',

          hintText: '1234567890',

          controller: _nikController,

          keyboardType: TextInputType.number,

          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      ],
    );
  }

  Widget _buildNonSelfForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          'Informasi Yang Membantu Lapor',

          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: context.appThemedTextColor(const Color(0xFF55585E)),
          ),
        ),

        const SizedBox(height: 30),

        _IdentityField(
          label: 'Nama Pelapor',

          hintText: 'Masukkan nama pelapor',

          controller: _reporterNameController,
        ),

        const SizedBox(height: 28),

        _IdentityDropdownField(
          label: 'Kelompok',

          hintText: 'Pilih kelompok',

          value: _selectedGroup,

          onTap: _selectGroup,
        ),

        const SizedBox(height: 28),

        _IdentityField(
          label: 'Nama Instansi',

          hintText: 'Masukkan nama instansi',

          controller: _institutionNameController,
        ),

        const SizedBox(height: 28),

        _IdentityField(
          label: 'No Telepon',

          hintText: '08xxxxxxxxxx',

          controller: _reporterPhoneController,

          keyboardType: TextInputType.phone,
        ),

        const SizedBox(height: 40),

        Text(
          'Informasi Yang Diskrining',

          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: context.appThemedTextColor(const Color(0xFF55585E)),
          ),
        ),

        const SizedBox(height: 30),

        _IdentityField(
          label: 'Nama Yang Diskrining',

          hintText: 'Masukkan nama',

          controller: _screenedNameController,
        ),

        const SizedBox(height: 28),

        _IdentityField(
          label: 'NIK Yang Diskrining',

          hintText: '1234567890',

          controller: _screenedNikController,

          keyboardType: TextInputType.number,

          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      ],
    );
  }
}

class IdentityFormNotice extends StatelessWidget {
  const IdentityFormNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: context.appSurfaceColor,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(color: const Color(0xFFFF2156), width: 2),
      ),

      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text:
                  'Segala yang Anda cantumkan dalam form skrining akan kami jamin kerahasiaannya.\n\n',
            ),

            TextSpan(
              text: 'Note: ',

              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800),
            ),

            const TextSpan(
              text: 'Jika halaman direfresh maka data akan hilang.',
            ),
          ],
        ),

        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,

          fontWeight: FontWeight.w500,

          height: 1.45,

          color: const Color(0xFFFF2156),
        ),
      ),
    );
  }
}

class _ScreeningChoiceCard extends StatelessWidget {
  const _ScreeningChoiceCard({
    required this.label,
    required this.isSelected,
    required this.activeColor,
    required this.activeBackground,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Color activeColor;
  final Color activeBackground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? context.isDarkMode
                ? activeColor.withValues(alpha: 0.16)
                : activeBackground
          : context.isDarkMode
          ? context.appSubtleSurfaceColor
          : const Color(0xFFF0F0F2),

      borderRadius: BorderRadius.circular(24),

      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(24),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_unchecked_rounded,

                size: 34,

                color: isSelected
                    ? activeColor
                    : context.appThemedMutedTextColor(const Color(0xFF9D9D9F)),
              ),

              const SizedBox(width: 12),

              Text(
                label,

                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,

                  fontWeight: FontWeight.w500,

                  color: isSelected
                      ? activeColor
                      : context.appThemedMutedTextColor(
                          const Color(0xFF9D9D9F),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IdentityDropdownField extends StatelessWidget {
  const _IdentityDropdownField({
    required this.label,
    required this.hintText,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String hintText;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          label,

          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,

            fontWeight: FontWeight.w700,

            color: context.appThemedTextColor(const Color(0xFF55585E)),
          ),
        ),

        const SizedBox(height: 16),

        Material(
          color: context.isDarkMode
              ? context.appSubtleSurfaceColor
              : const Color(0xFFF0F0F2),

          borderRadius: BorderRadius.circular(24),

          child: InkWell(
            onTap: onTap,

            borderRadius: BorderRadius.circular(24),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),

              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value ?? hintText,

                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,

                        fontWeight: FontWeight.w500,

                        color: value == null
                            ? context.appThemedMutedTextColor(
                                const Color(0xFFA9AAB0),
                              )
                            : context.appThemedTextColor(
                                const Color(0xFF55585E),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Icon(
                    Icons.keyboard_arrow_down_rounded,

                    size: 30,

                    color: context.appThemedMutedTextColor(
                      const Color(0xFF666870),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _IdentityField extends StatelessWidget {
  const _IdentityField({
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.inputFormatters,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;

  final TextInputType? keyboardType;

  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          label,

          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,

            fontWeight: FontWeight.w700,

            color: context.appThemedTextColor(const Color(0xFF55585E)),
          ),
        ),

        const SizedBox(height: 16),

        TextField(
          controller: controller,

          keyboardType: keyboardType,

          inputFormatters: inputFormatters,

          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,

            fontWeight: FontWeight.w500,

            color: context.appThemedTextColor(const Color(0xFF55585E)),
          ),

          decoration: InputDecoration(
            hintText: hintText,

            hintStyle: GoogleFonts.plusJakartaSans(
              fontSize: 18,

              fontWeight: FontWeight.w500,

              color: context.appThemedMutedTextColor(const Color(0xFFA9AAB0)),
            ),

            filled: true,

            fillColor: context.isDarkMode
                ? context.appSubtleSurfaceColor
                : const Color(0xFFF0F0F2),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),

              borderSide: BorderSide.none,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),

              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),

              borderSide: const BorderSide(
                color: AppColors.welcomeAccent,
                width: 1.8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
