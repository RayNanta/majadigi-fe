import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class HoaxTrackReportPage extends StatefulWidget {
  const HoaxTrackReportPage({super.key});

  @override
  State<HoaxTrackReportPage> createState() => _HoaxTrackReportPageState();
}

class _HoaxTrackReportPageState extends State<HoaxTrackReportPage> {
  late final TextEditingController _ticketController;

  @override
  void initState() {
    super.initState();
    _ticketController = TextEditingController();
  }

  @override
  void dispose() {
    _ticketController.dispose();
    super.dispose();
  }

  bool get _canTrack => _ticketController.text.trim().isNotEmpty;

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeHoaxClinicMain);
  }

  void _handleTrack(BuildContext context) {
    if (!_canTrack) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan dulu nomor tiket untuk melacak laporan.'),
        ),
      );
      return;
    }

    final ticketNumber = _ticketController.text.trim();
    context.pushNamed(
      RouteNames.homeHoaxClinicTrackResult,
      extra: ticketNumber,
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
                      'Lacak Pelaporan',
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
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(26, 28, 26, 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF111827).withValues(alpha: 0.035),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pelacakan Tiket Permohonan Anda',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF4A4D54),
                        ),
                      ),
                      const SizedBox(height: 44),
                      Text(
                        'Nomor Tiket',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4E525A),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _ticketController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9\-]'),
                          ),
                        ],
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF2F3136),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Contoh: MH-2024-001',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFB0B3BA),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF0F0F2),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: const BorderSide(
                              color: AppColors.welcomeAccent,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 44),
                      Text(
                        'Silakan masukkan nomor tiket yang telah dikirimkan melalui WhatsApp atau Email Anda untuk memantau status terkini.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.55,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
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
              onPressed: _canTrack ? () => _handleTrack(context) : null,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.welcomeAccent,
                disabledBackgroundColor: AppColors.disabled,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('Lacak'),
            ),
          ),
        ),
      ),
    );
  }
}
