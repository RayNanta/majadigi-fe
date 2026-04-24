import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../auth/routes.dart';
import '../../../home/routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 32,
                  ),
                  child: const IntrinsicHeight(child: _WelcomeContent()),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _WelcomeContent extends StatelessWidget {
  const _WelcomeContent();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final heroHeight = math.min(size.height * 0.44, 460.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Image.asset(
            'assets/images/welcome_hero.png',
            width: double.infinity,
            height: heroHeight,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        const SizedBox(height: 34),
        Text(
          'Selamat Datang di',
          style: GoogleFonts.playfairDisplay(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            height: 1.02,
            color: AppColors.welcomeAccent,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'MAJADIGI',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 38,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.2,
            height: 1,
            color: AppColors.brandNavy,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'Platform digital untuk memudahkan\nakses layanan dan informasi Anda.\nMari mulai perjalanan digital Anda\nbersama kami!',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            height: 1.85,
            color: AppColors.textMuted,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => context.go(HomeRoutes.path),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.welcomeAccent,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(72),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              textStyle: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            child: const Text('Daftar'),
          ),
        ),
        const SizedBox(height: 18),
        Center(
          child: TextButton(
            onPressed: () => context.go(AuthRoutes.signInPath),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.welcomeAccent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text('Masuk'),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
