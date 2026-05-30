import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/theme/app_colors.dart';

class TbcResultLayout extends StatelessWidget {
  const TbcResultLayout({
    required this.onBack,
    required this.onPrimaryAction,
    required this.illustration,
    required this.resultText,
    required this.resultColor,
    this.resultSubtitle,
    required this.patientName,
    required this.screeningDate,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback onPrimaryAction;
  final Widget illustration;
  final String resultText;
  final Color resultColor;
  final String? resultSubtitle;
  final String patientName;
  final String screeningDate;

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
              color: AppColors.welcomeAccent,
              padding: const EdgeInsets.fromLTRB(16, 18, 20, 18),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBack,
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
                      'Hasil Skrining',
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
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _DinkesBadge(),
                    ),
                    const SizedBox(height: 28),
                    illustration,
                    const SizedBox(height: 28),
                    Text(
                      patientName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF4B4E55),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      screeningDate,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9B9EA7),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      resultText,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: resultColor,
                      ),
                    ),
                    if (resultSubtitle != null) ...[
                      const SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          resultSubtitle!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            height: 1.45,
                            color: const Color(0xFF3F434A),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 140),
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
              onPressed: onPrimaryAction,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.welcomeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('Selesai'),
            ),
          ),
        ),
      ),
    );
  }
}

class _DinkesBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFE6F0FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.shield_outlined,
              size: 32,
              color: AppColors.welcomeAccent,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            'DINAS KESEHATAN\nJAWA TIMUR',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              height: 1.4,
              color: const Color(0xFF111111),
            ),
          ),
        ],
      ),
    );
  }
}

class TbcNegativeIllustration extends StatelessWidget {
  const TbcNegativeIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430,
      width: double.infinity,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 8,
              child: Container(
                width: 180,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2F80FF),
                      Color(0xFF40C9FF),
                      Color(0xFFB76DFF),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 18,
              child: Container(
                width: 150,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F9FF),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Positioned(
              left: 80,
              bottom: 36,
              child: _BuddyBlob(
                size: 120,
                color: const Color(0xFF22B4FF),
                accent: const Color(0xFF0F6AF5),
                ear: true,
              ),
            ),
            Positioned(
              right: 80,
              bottom: 44,
              child: _BuddyBlob(
                size: 108,
                color: const Color(0xFF8AD943),
                accent: const Color(0xFF52B61C),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: 240,
                height: 330,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 48,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFF9966),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 118,
                      child: Container(
                        width: 116,
                        height: 128,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F2FF),
                          borderRadius: BorderRadius.circular(56),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 94,
                      child: Transform.rotate(
                        angle: 0.9,
                        child: Container(
                          width: 118,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFA07A),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 16,
                      top: 94,
                      child: Transform.rotate(
                        angle: -0.9,
                        child: Container(
                          width: 118,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFA07A),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 84,
                      top: 8,
                      child: Container(
                        width: 24,
                        height: 54,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC2A8),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 68,
                      top: 20,
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFFD2BD),
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: Color(0xFFFF8A6D),
                          size: 28,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 68,
                      bottom: 26,
                      child: Transform.rotate(
                        angle: 0.18,
                        child: Container(
                          width: 34,
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF178EFF), Color(0xFF98ECFF)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 68,
                      bottom: 26,
                      child: Transform.rotate(
                        angle: -0.38,
                        child: Container(
                          width: 34,
                          height: 126,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF178EFF), Color(0xFFB2F279)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              left: 118,
              top: 146,
              child: _Flower(accent: Color(0xFFFF66CC)),
            ),
            const Positioned(
              right: 112,
              top: 182,
              child: _Flower(accent: Color(0xFFFF6B6B)),
            ),
          ],
        ),
      ),
    );
  }
}

class TbcPositiveIllustration extends StatelessWidget {
  const TbcPositiveIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      width: double.infinity,
      child: Center(
        child: SizedBox(
          width: 320,
          height: 320,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 230,
                height: 230,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2DDA42),
                ),
              ),
              ...List.generate(12, (index) {
                final angle = index * 0.52;
                return Transform.rotate(
                  angle: angle,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 28,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0xFF169722),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF169722),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Positioned(
                top: 108,
                child: Row(
                  children: const [_EyeBlob(), SizedBox(width: 54), _EyeBlob()],
                ),
              ),
              Positioned(
                top: 144,
                child: Container(
                  width: 184,
                  height: 96,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAFBFF),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFF6ED3F0),
                      width: 8,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7FD6F2),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 70,
                        height: 10,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9AE2F8),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 64,
                top: 86,
                child: _Bubble(accent: const Color(0xFF1AA6F2)),
              ),
              Positioned(
                right: 72,
                top: 54,
                child: _Bubble(accent: const Color(0xFF1AA6F2)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuddyBlob extends StatelessWidget {
  const _BuddyBlob({
    required this.size,
    required this.color,
    required this.accent,
    this.ear = false,
  });

  final double size;
  final Color color;
  final Color accent;
  final bool ear;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.18,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (ear) ...[
            Positioned(
              left: size * 0.18,
              top: 0,
              child: Transform.rotate(
                angle: -0.58,
                child: Container(
                  width: size * 0.22,
                  height: size * 0.52,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            Positioned(
              left: size * 0.42,
              top: size * 0.02,
              child: Transform.rotate(
                angle: -0.16,
                child: Container(
                  width: size * 0.22,
                  height: size * 0.54,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ],
          Positioned(
            top: size * 0.22,
            child: Container(
              width: size * 0.76,
              height: size * 0.76,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [color, Color.lerp(color, Colors.white, 0.28)!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
            left: size * 0.2,
            bottom: size * 0.16,
            child: Transform.rotate(
              angle: 0.42,
              child: Container(
                width: size * 0.15,
                height: size * 0.34,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
          Positioned(
            right: size * 0.2,
            bottom: size * 0.16,
            child: Transform.rotate(
              angle: -0.42,
              child: Container(
                width: size * 0.15,
                height: size * 0.34,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
          Positioned(
            left: size * 0.28,
            top: size * 0.5,
            child: Row(
              children: const [_MiniEye(), SizedBox(width: 10), _MiniEye()],
            ),
          ),
        ],
      ),
    );
  }
}

class _Flower extends StatelessWidget {
  const _Flower({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 68,
      height: 68,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (final alignment in const [
            Alignment.topCenter,
            Alignment.bottomCenter,
            Alignment.centerLeft,
            Alignment.centerRight,
          ])
            Align(
              alignment: alignment,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFF2FA),
            ),
          ),
        ],
      ),
    );
  }
}

class _EyeBlob extends StatelessWidget {
  const _EyeBlob();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: Align(
        alignment: const Alignment(0.3, -0.2),
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _MiniEye extends StatelessWidget {
  const _MiniEye();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: Align(
        alignment: const Alignment(0.3, -0.2),
        child: Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(shape: BoxShape.circle, color: accent),
        ),
        Container(
          width: 18,
          height: 18,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
