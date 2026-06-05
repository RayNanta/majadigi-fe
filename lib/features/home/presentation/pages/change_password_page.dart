import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';
import '../../../auth/presentation/widgets/auth_form_widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _canSubmit {
    final oldPassword = _oldPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    return oldPassword.isNotEmpty &&
        newPassword.length >= 8 &&
        confirmPassword.isNotEmpty &&
        newPassword == confirmPassword;
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeProfile);
  }

  void _handleSubmit() {
    final message = _canSubmit
        ? 'Fitur ubah kata sandi akan segera tersedia.'
        : 'Lengkapi seluruh data dan pastikan kata sandi baru cocok.';

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildPasswordVisibilityButton({
    required bool isObscured,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: context.appMutedTextColor,
        size: 28,
      ),
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
                      'Ubah Kata Sandi',
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
                padding: const EdgeInsets.fromLTRB(24, 30, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kata Sandi Lama',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: context.appThemedTextColor(
                          const Color(0xFF303236),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    AuthInputField(
                      controller: _oldPasswordController,
                      hintText: 'Masukkan kata sandi',
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: _obscureOldPassword,
                      suffix: _buildPasswordVisibilityButton(
                        isObscured: _obscureOldPassword,
                        onPressed: () {
                          setState(() {
                            _obscureOldPassword = !_obscureOldPassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Gunakan minimal 8 karakter dengan kombinasi huruf dan angka',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: context.appMutedTextColor,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Text(
                      'Kata Sandi Baru',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: context.appThemedTextColor(
                          const Color(0xFF303236),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    AuthInputField(
                      controller: _newPasswordController,
                      hintText: 'Masukkan kata sandi',
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: _obscureNewPassword,
                      suffix: _buildPasswordVisibilityButton(
                        isObscured: _obscureNewPassword,
                        onPressed: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 36),
                    Text(
                      'Konfirmasi Kata Sandi Baru',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: context.appThemedTextColor(
                          const Color(0xFF303236),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    AuthInputField(
                      controller: _confirmPasswordController,
                      hintText: 'Masukkan kata sandi',
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: _obscureConfirmPassword,
                      suffix: _buildPasswordVisibilityButton(
                        isObscured: _obscureConfirmPassword,
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 56),
                    AuthPrimaryButton(label: 'Masuk', onPressed: _handleSubmit),
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
