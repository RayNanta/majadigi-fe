import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  static const _sections = [
    _TermsSection(
      number: 1,
      title: 'Pendahuluan',
      paragraphs: [
        'Selamat datang di Majadigi. Syarat dan Ketentuan ini mengatur penggunaan Anda terhadap aplikasi Majadigi yang disediakan oleh Pemerintah Provinsi Jawa Timur.',
        'Dengan mengunduh, mengakses, atau menggunakan aplikasi ini, Anda dianggap telah membaca, memahami, dan menyetujui untuk terikat oleh syarat dan ketentuan ini.',
        'Jika Anda tidak menyetujui bagian apa pun dari syarat ini, mohon untuk tidak menggunakan aplikasi ini.',
      ],
    ),
    _TermsSection(
      number: 2,
      title: 'Ketentuan Pengguna',
      bullets: [
        _TermsBullet(
          prefix: 'a.',
          text:
              'Anda harus memberikan informasi yang akurat, terkini, dan lengkap selama proses pendaftaran.',
        ),
        _TermsBullet(
          prefix: 'b.',
          text:
              'Anda bertanggung jawab untuk menjaga kerahasiaan akun dan kata sandi Anda.',
        ),
        _TermsBullet(
          prefix: 'c.',
          text:
              'Pengguna dilarang menggunakan aplikasi untuk tujuan ilegal atau yang melanggar hukum yang berlaku di Indonesia.',
        ),
      ],
    ),
    _TermsSection(
      number: 3,
      title: 'Layanan yang Disediakan',
      paragraphs: [
        'Majadigi menyediakan berbagai layanan informasi publik, administrasi kependudukan, dan layanan pemerintahan lainnya secara digital untuk masyarakat Jawa Timur.',
      ],
    ),
    _TermsSection(
      number: 4,
      title: 'Penggunaan Data & Privasi',
      paragraphs: [
        'Privasi Anda sangat penting bagi kami. Kebijakan Privasi kami menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi data pribadi Anda saat menggunakan aplikasi Majadigi.',
      ],
    ),
    _TermsSection(
      number: 5,
      title: 'Hak Kekayaan Intelektual',
      paragraphs: [
        'Seluruh konten dalam aplikasi ini, termasuk namun tidak terbatas pada teks, grafik, logo, dan perangkat lunak adalah milik Pemerintah Provinsi Jawa Timur dan dilindungi oleh undang-undang hak cipta.',
      ],
    ),
    _TermsSection(
      number: 6,
      title: 'Pembatasan Tanggung Jawab',
      paragraphs: [
        'Pemerintah Provinsi Jawa Timur tidak bertanggung jawab atas kerugian atau kerusakan yang timbul dari penggunaan aplikasi ini, termasuk namun tidak terbatas pada gangguan layanan atau kehilangan data.',
      ],
    ),
    _TermsSection(
      number: 7,
      title: 'Perubahan Syarat & Ketentuan Pemerintah Provinsi Jawa Timur',
      paragraphs: [
        'Kami berhak untuk mengubah syarat dan ketentuan ini kapan saja. Perubahan akan berlaku segera setelah dipublikasikan di aplikasi.',
        'Penggunaan berkelanjutan atas aplikasi setelah perubahan tersebut merupakan persetujuan Anda terhadap syarat yang baru.',
      ],
    ),
    _TermsSection(
      number: 8,
      title: 'Hubungi Kami',
      paragraphs: [
        'Jika Anda memiliki pertanyaan mengenai Syarat dan Ketentuan ini, silakan hubungi layanan bantuan kami melalui email atau kanal aplikasi resmi yang tersedia di aplikasi.',
      ],
    ),
    _TermsSection(
      number: 9,
      title: 'Persetujuan',
      paragraphs: [
        'Dengan menggunakan aplikasi Majadigi, pengguna menyatakan telah memahami dan menyetujui seluruh ketentuan yang berlaku.',
      ],
    ),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeProfile);
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
                    onPressed: () => _handleBack(context),
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
                      'Syarat dan Ketentuan',
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
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                child: Column(
                  children: _sections
                      .map(
                        (section) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _TermsSectionCard(section: section),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TermsSectionCard extends StatelessWidget {
  const _TermsSectionCard({required this.section});

  final _TermsSection section;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? context.appSubtleSurfaceColor
                      : const Color(0xFFEAF3FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${section.number}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.welcomeAccent,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  section.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                    color: context.appThemedTextColor(const Color(0xFF3C424D)),
                  ),
                ),
              ),
            ],
          ),
          if (section.paragraphs.isNotEmpty) ...[
            const SizedBox(height: 14),
            ...section.paragraphs.map(
              (paragraph) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  paragraph,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                    color: context.appThemedMutedTextColor(
                      const Color(0xFF717784),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (section.bullets.isNotEmpty) ...[
            const SizedBox(height: 14),
            ...section.bullets.map(
              (bullet) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _TermsBulletRow(bullet: bullet),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TermsBulletRow extends StatelessWidget {
  const _TermsBulletRow({required this.bullet});

  final _TermsBullet bullet;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          child: Text(
            bullet.prefix,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.welcomeAccent,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            bullet.text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.6,
              color: context.appThemedMutedTextColor(const Color(0xFF717784)),
            ),
          ),
        ),
      ],
    );
  }
}

class _TermsSection {
  const _TermsSection({
    required this.number,
    required this.title,
    this.paragraphs = const [],
    this.bullets = const [],
  });

  final int number;
  final String title;
  final List<String> paragraphs;
  final List<_TermsBullet> bullets;
}

class _TermsBullet {
  const _TermsBullet({required this.prefix, required this.text});

  final String prefix;
  final String text;
}
