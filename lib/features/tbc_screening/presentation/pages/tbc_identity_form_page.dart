import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

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

  void _handleNext() {
    context.pushNamed(RouteNames.homeTbcPersonalIdentity);
  }

  Future<void> _selectGroup() async {
    final selectedValue = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
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
                      color: const Color(0xFFD5D8DF),
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
                    color: AppColors.textPrimary,
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
                            : AppColors.textPrimary,
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

    if (selectedValue == null) {
      return;
    }

    setState(() {
      _selectedGroup = selectedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNoState = _choice == _SelfScreeningChoice.no;

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
                    const _IdentityFormNotice(),
                    const SizedBox(height: 34),
                    Text(
                      'Anda melakukan skrining untuk diri Anda sendiri?',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF55585E),
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
                    if (isNoState)
                      const _NonSelfIdentityFormSpacer()
                    else
                      const _SelfIdentityFormSpacer(),
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
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 20),
          child: SizedBox(
            height: 66,
            child: FilledButton(
              onPressed: _handleNext,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.welcomeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('Selanjutnya'),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelfIdentityFormSpacer extends StatelessWidget {
  const _SelfIdentityFormSpacer();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TbcIdentityFormPageState>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Masukkan Identitas Anda',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF55585E),
          ),
        ),
        const SizedBox(height: 30),
        _IdentityField(
          label: 'Nama Lengkap',
          hintText: 'Masukkan nama lengkap',
          controller: state._nameController,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 28),
        _IdentityField(
          label: 'NIK (16 digit)',
          hintText: 'Cth: 123456782910',
          controller: state._nikController,
          keyboardType: TextInputType.number,
          maxLength: 16,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
          ],
        ),
      ],
    );
  }
}

class _NonSelfIdentityFormSpacer extends StatelessWidget {
  const _NonSelfIdentityFormSpacer();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_TbcIdentityFormPageState>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi yang bantu lapor',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF55585E),
          ),
        ),
        const SizedBox(height: 30),
        _IdentityField(
          label: 'Nama Lengkap',
          hintText: 'Masukkan nama lengkap',
          controller: state._reporterNameController,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 28),
        _IdentityDropdownField(
          label: 'Kelompok',
          hintText: 'Pilih kelompok',
          value: state._selectedGroup,
          onTap: state._selectGroup,
        ),
        const SizedBox(height: 28),
        _IdentityField(
          label: 'Nama Instansi',
          hintText: 'Masukkan nama instansi',
          controller: state._institutionNameController,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 28),
        _IdentityField(
          label: 'No. Telepon/HP',
          hintText: 'Cth: 085678910111',
          controller: state._reporterPhoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 34),
        Text(
          'Informasi yang di skrining',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF55585E),
          ),
        ),
        const SizedBox(height: 30),
        _IdentityField(
          label: 'Nama Lengkap',
          hintText: 'Masukkan nama lengkap',
          controller: state._screenedNameController,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 28),
        _IdentityField(
          label: 'NIK (16 digit)',
          hintText: 'Cth: 123456782910',
          controller: state._screenedNikController,
          keyboardType: TextInputType.number,
          maxLength: 16,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
          ],
        ),
      ],
    );
  }
}

class _IdentityFormNotice extends StatelessWidget {
  const _IdentityFormNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFF2156), width: 2),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text:
                  'Segala yang Anda cantumkan dalam form skrining akan kami jamin kerahasiaannya. Hanya tenaga kesehatan berwenang yang bisa memanfaatkan data ini untuk kepentingan Anda.\n',
            ),
            TextSpan(
              text: 'Note:',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800),
            ),
            const TextSpan(
              text:
                  ' Jika anda refresh halaman ini, maka data yang anda isikan akan hilang dan anda harus menunggu 30 menit untuk mengisi kembali.',
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
      color: isSelected ? activeBackground : const Color(0xFFF0F0F2),
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
                color: isSelected ? activeColor : const Color(0xFF9D9D9F),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? activeColor : const Color(0xFF9D9D9F),
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
            color: const Color(0xFF55585E),
          ),
        ),
        const SizedBox(height: 16),
        Material(
          color: const Color(0xFFF0F0F2),
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
                            ? const Color(0xFFA9AAB0)
                            : const Color(0xFF55585E),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 30,
                    color: Color(0xFF666870),
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
    this.maxLength,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

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
            color: const Color(0xFF55585E),
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
            color: const Color(0xFF55585E),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFA9AAB0),
            ),
            filled: true,
            fillColor: const Color(0xFFF0F0F2),
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
            counterText: '',
          ),
          maxLength: maxLength,
        ),
      ],
    );
  }
}
