import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../auth/presentation/widgets/auth_form_widgets.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  static const _languageOptions = [
    _LanguageOption(
      code: 'id',
      label: 'Bahasa Indonesia',
      icon: Icons.language_rounded,
    ),
    _LanguageOption(code: 'en', label: 'English', icon: Icons.public_rounded),
    _LanguageOption(
      code: 'jv',
      label: 'Bahasa Jawa',
      icon: Icons.translate_rounded,
    ),
    _LanguageOption(
      code: 'mad',
      label: 'Bahasa Madura',
      icon: Icons.record_voice_over_rounded,
    ),
    _LanguageOption(
      code: 'osi',
      label: 'Bahasa Osing',
      icon: Icons.chat_bubble_outline_rounded,
    ),
  ];

  String _selectedLanguageCode = 'id';

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeProfile);
  }

  void _handleApply() {
    final selectedLanguage = _languageOptions.firstWhere(
      (option) => option.code == _selectedLanguageCode,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${selectedLanguage.label} dipilih. Penerapan bahasa penuh akan segera tersedia.',
        ),
      ),
    );
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
              color: AppColors.splashBackground,
              padding: const EdgeInsets.fromLTRB(18, 22, 24, 28),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _handleBack,
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(44, 44),
                    ),
                    icon: const Icon(Icons.arrow_back_rounded, size: 34),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Ganti Bahasa',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
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
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF111827,
                            ).withValues(alpha: 0.04),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: _languageOptions
                            .map(
                              (option) => _LanguageOptionTile(
                                option: option,
                                isSelected:
                                    option.code == _selectedLanguageCode,
                                onTap: () {
                                  setState(() {
                                    _selectedLanguageCode = option.code;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(18, 20, 18, 22),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF3FF),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFF69A0FF),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.welcomeAccent,
                            size: 34,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              'Mengubah bahasa akan memperbarui teks di seluruh aplikasi untuk memberikan pengalaman terbaik sesuai pilihan Anda.',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 132),
                    AuthPrimaryButton(
                      label: 'Terapkan',
                      onPressed: _handleApply,
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

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _LanguageOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE6F0FF),
              ),
              child: Icon(
                option.icon,
                size: 34,
                color: AppColors.welcomeAccent,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                option.label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF303236),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.welcomeAccent
                      : const Color(0xFF979797),
                  width: isSelected ? 10 : 2.5,
                ),
              ),
              child: isSelected
                  ? const DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption {
  const _LanguageOption({
    required this.code,
    required this.label,
    required this.icon,
  });

  final String code;
  final String label;
  final IconData icon;
}
