import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <--- 1. AKU TAMBAHIN INI

import '../../../../shared/theme/app_colors.dart';
import '../../routes.dart';
import '../widgets/auth_form_widgets.dart';

class SignUpStepOnePage extends StatefulWidget {
  const SignUpStepOnePage({super.key});

  @override
  State<SignUpStepOnePage> createState() => _SignUpStepOnePageState();
}

class _SignUpStepOnePageState extends State<SignUpStepOnePage> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  bool get _canContinue {
    return _fullNameController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController()..addListener(_refreshState);
    _phoneController = TextEditingController()..addListener(_refreshState);
    _emailController = TextEditingController()..addListener(_refreshState);
  }

  void _refreshState() {
    setState(() {});
  }

  @override
  void dispose() {
    _fullNameController
      ..removeListener(_refreshState)
      ..dispose();
    _phoneController
      ..removeListener(_refreshState)
      ..dispose();
    _emailController
      ..removeListener(_refreshState)
      ..dispose();
    super.dispose();
  }

  // 2. KODE INI AKU MODIFIKASI BIAR NYIMPEN NAMA PAS REGISTER
  Future<void> _goToStepTwo() async {
    final prefs = await SharedPreferences.getInstance();
    // Simpan nama yang diketik user ke loker HP dengan kata kunci 'user_real_name'
    await prefs.setString('user_real_name', _fullNameController.text.trim());

    if (mounted) {
      context.go(AuthRoutes.signUpStepTwoPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24, 18, 24, viewInsets.bottom + 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - viewInsets.bottom - 42,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AuthTopBar(),
                          const SizedBox(height: 72),
                          Text(
                            'Daftar',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 38,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2F3136),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            'Buat akun dan nikmati semua fitur layanan\npublik dalam satu aplikasi',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              height: 1.7,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 42),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: const LinearProgressIndicator(
                              value: 0.5,
                              minHeight: 8,
                              backgroundColor: AppColors.disabled,
                              valueColor: AlwaysStoppedAnimation(AppColors.welcomeAccent),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Langkah 1 dari 2',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2F3136),
                            ),
                          ),
                          const SizedBox(height: 52),
                          Text(
                            'Nama Lengkap',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2F3136),
                            ),
                          ),
                          const SizedBox(height: 18),
                          AuthInputField(
                            controller: _fullNameController,
                            hintText: 'Masukkan nama lengkap',
                            prefixIcon: Icons.person_outline_rounded,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                          ),
                          const SizedBox(height: 34),
                          Text(
                            'No HP',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2F3136),
                            ),
                          ),
                          const SizedBox(height: 18),
                          AuthInputField(
                            controller: _phoneController,
                            hintText: 'Masukkan no hp',
                            prefixIcon: Icons.call_outlined,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 34),
                          Text(
                            'Email',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2F3136),
                            ),
                          ),
                          const SizedBox(height: 18),
                          AuthInputField(
                            controller: _emailController,
                            hintText: 'Masukkan alamat email',
                            prefixIcon: Icons.mail_outline_rounded,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: 56),
                          AuthPrimaryButton(
                            label: 'Selanjutnya',
                            onPressed: _canContinue ? _goToStepTwo : null,
                          ),
                          const SizedBox(height: 42),
                          AuthFooterPrompt(
                            promptText: 'Sudah punya akun?',
                            actionText: 'Masuk',
                            onPressed: () => context.go(AuthRoutes.signInPath),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}