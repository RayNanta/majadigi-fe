import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../routes.dart';
import '../widgets/auth_form_widgets.dart';

class SignUpStepTwoPage extends StatefulWidget {
  const SignUpStepTwoPage({super.key});

  @override
  State<SignUpStepTwoPage> createState() => _SignUpStepTwoPageState();
}

class _SignUpStepTwoPageState extends State<SignUpStepTwoPage> {
  late final TextEditingController _addressController;
  late final TextEditingController _nikController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool get _canSubmit {
    return _addressController.text.trim().isNotEmpty &&
        _nikController.text.trim().length == 16 &&
        _birthDateController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text;
  }

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController()..addListener(_refreshState);
    _nikController = TextEditingController()..addListener(_refreshState);
    _birthDateController = TextEditingController()..addListener(_refreshState);
    _passwordController = TextEditingController()..addListener(_refreshState);
    _confirmPasswordController = TextEditingController()
      ..addListener(_refreshState);
  }

  void _refreshState() {
    setState(() {});
  }

  @override
  void dispose() {
    _addressController
      ..removeListener(_refreshState)
      ..dispose();
    _nikController
      ..removeListener(_refreshState)
      ..dispose();
    _birthDateController
      ..removeListener(_refreshState)
      ..dispose();
    _passwordController
      ..removeListener(_refreshState)
      ..dispose();
    _confirmPasswordController
      ..removeListener(_refreshState)
      ..dispose();
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 20),
      firstDate: DateTime(1945),
      lastDate: now,
    );

    if (pickedDate == null) {
      return;
    }

    final day = pickedDate.day.toString().padLeft(2, '0');
    final month = pickedDate.month.toString().padLeft(2, '0');
    final year = pickedDate.year.toString();
    _birthDateController.text = '$day/$month/$year';
  }

  void _goToStepThree() {
    context.go(AuthRoutes.signUpStepThreePath);
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
                  padding: EdgeInsets.fromLTRB(
                    24,
                    18,
                    24,
                    viewInsets.bottom + 24,
                  ),
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
                              value: 1,
                              minHeight: 8,
                              backgroundColor: AppColors.disabled,
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.welcomeAccent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Langkah 2 dari 2',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2F3136),
                            ),
                          ),
                          const SizedBox(height: 52),
                          Text(
                            'Alamat',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2F3136),
                            ),
                          ),
                          const SizedBox(height: 18),
                          AuthInputField(
                            controller: _addressController,
                            hintText: 'Masukkan alamat lengkap',
                            prefixIcon: Icons.home_outlined,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          const SizedBox(height: 34),
                          Text(
                            'NIK',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2F3136),
                            ),
                          ),
                          const SizedBox(height: 18),
                          AuthInputField(
                            controller: _nikController,
                            hintText: 'Masukkan 16 digit NIK',
                            prefixIcon: Icons.badge_outlined,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                            ],
                          ),
                          const SizedBox(height: 34),
                          Text(
                            'Tanggal Lahir',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2F3136),
                            ),
                          ),
                          const SizedBox(height: 18),
                          AuthInputField(
                            controller: _birthDateController,
                            hintText: 'Pilih tanggal lahir',
                            prefixIcon: Icons.calendar_today_outlined,
                            readOnly: true,
                            onTap: _pickBirthDate,
                            suffix: IconButton(
                              onPressed: _pickBirthDate,
                              icon: const Icon(Icons.expand_more_rounded),
                              color: AppColors.outline,
                            ),
                          ),
                          const SizedBox(height: 34),
                          Text(
                            'Kata Sandi',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2F3136),
                            ),
                          ),
                          const SizedBox(height: 18),
                          AuthInputField(
                            controller: _passwordController,
                            hintText: 'Masukkan kata sandi',
                            prefixIcon: Icons.lock_outline_rounded,
                            textInputAction: TextInputAction.next,
                            obscureText: _obscurePassword,
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              color: AppColors.outline,
                            ),
                          ),
                          const SizedBox(height: 34),
                          Text(
                            'Konfirmasi Kata Sandi',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2F3136),
                            ),
                          ),
                          const SizedBox(height: 18),
                          AuthInputField(
                            controller: _confirmPasswordController,
                            hintText: 'Masukkan ulang kata sandi',
                            prefixIcon: Icons.lock_outline_rounded,
                            textInputAction: TextInputAction.done,
                            obscureText: _obscureConfirmPassword,
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              color: AppColors.outline,
                            ),
                          ),
                          const SizedBox(height: 56),
                          AuthPrimaryButton(
                            label: 'Daftar',
                            onPressed: _canSubmit ? _goToStepThree : null,
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
