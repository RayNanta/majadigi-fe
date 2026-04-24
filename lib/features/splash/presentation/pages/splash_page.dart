import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/theme/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final logoSize = math.min(size.width * 0.32, 220.0);
    final footerBottomSpacing = math.max(88.0, size.height * 0.115);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.splashBackground,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Align(
                alignment: const Alignment(0, -0.10),
                child: Image.asset(
                  'assets/logos/splash_logo.png',
                  width: logoSize,
                  height: logoSize,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: footerBottomSpacing,
                child: const _SplashFooter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SplashFooter extends StatelessWidget {
  const _SplashFooter();

  @override
  Widget build(BuildContext context) {
    final smallTextStyle = GoogleFonts.plusJakartaSans(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.3,
      color: Colors.white,
    );
    final mainTextStyle = GoogleFonts.plusJakartaSans(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      height: 1.35,
      color: Colors.white,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Powered by', textAlign: TextAlign.center, style: smallTextStyle),
        const SizedBox(height: 10),
        Text(
          'Pemerintah Provinsi Jawa Timur',
          textAlign: TextAlign.center,
          style: mainTextStyle,
        ),
      ],
    );
  }
}
