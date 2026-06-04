import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../home/routes.dart';
import '../../../welcome/routes.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  static const _navigationDelay = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await ref.read(authProvider.notifier).loadCurrentUser();

    await Future.delayed(_navigationDelay);

    if (!mounted) return;

    final user = ref.read(authProvider);

    if (user != null) {
      context.go(HomeRoutes.path);
    } else {
      context.go(WelcomeRoutes.path);
    }
  }




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
