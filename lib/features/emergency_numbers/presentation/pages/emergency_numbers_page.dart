import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class EmergencyNumbersPage extends StatelessWidget {
  const EmergencyNumbersPage({super.key});

  static const _benefitText =
      'Layanan nomor darurat memberikan akses cepat dan mudah untuk mencari '
      'pertolongan saat seseorang mengalami atau mengetahui situasi darurat '
      'seperti kebakaran, banjir, kecelakaan lalu lintas, kriminalitas, dan '
      'lainnya. Dengan begitu, layanan ini diharapkan mampu mempercepat '
      'penanganan keadaan darurat dan meminimalisir dampak buruk yang muncul '
      'akibat situasi darurat. Layanan nomor darurat beroperasi 24 jam '
      'sehari, dan 7 hari seminggu. Sehingga masyarakat bisa mengaksesnya '
      'kapanpun dan dari manapun.';

  static const _procedureText =
      'Kontak darurat biasanya lebih pendek atau sedikit dengan tujuan agar '
      'mudah diingat. Pastikan Anda menyimpan daftar kontak darurat di ponsel '
      'Anda atau tempat yang mudah dijangkau. Terakhir, pastikan Anda '
      'memberikan informasi secara jelas mengenai kejadian dan lokasinya agar '
      'petugas bisa mengeksekusinya lebih cepat.';

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.home);
  }

  void _handleDownload(BuildContext context) {
    context.pushNamed(RouteNames.homeEmergencyNumbersMain);
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
              color: AppColors.welcomeAccent,
              padding: const EdgeInsets.fromLTRB(16, 18, 20, 18),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _handleBack(context),
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
                      'Nomor Darurat',
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
                padding: const EdgeInsets.fromLTRB(24, 34, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _HeroBadge(),
                    const SizedBox(height: 26),
                    Text(
                      'Berisi Nomor Darurat yang dapat dihubungi oleh masyarakat',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 1.85,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const _SectionHeading(title: 'Manfaat'),
                    const SizedBox(height: 14),
                    const _InfoCard(text: _benefitText),
                    const SizedBox(height: 24),
                    const _SectionHeading(
                      title: 'Sistem, Mekanisme, dan Prosedur',
                    ),
                    const SizedBox(height: 14),
                    const _InfoCard(text: _procedureText),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 18),
          child: SizedBox(
            height: 66,
            child: FilledButton(
              onPressed: () => _handleDownload(context),
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
              child: const Text('Unduh Layanan'),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [Color(0xFFEAF4FF), Color(0xFFF7FBFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 28,
                  child: Icon(
                    Icons.shield_rounded,
                    size: 188,
                    color: const Color(0xFF1EA6E8).withValues(alpha: 0.16),
                  ),
                ),
                Container(
                  width: 196,
                  height: 196,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFA046), Color(0xFFFF6A00)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF97316).withValues(alpha: 0.25),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.phone_in_talk_rounded,
                        color: Colors.white,
                        size: 52,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        '112',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 64,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF16181D),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(26, 22, 26, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 2,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}
