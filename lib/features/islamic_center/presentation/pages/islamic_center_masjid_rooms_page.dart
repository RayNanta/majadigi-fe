import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class IslamicCenterMasjidRoomsPage extends StatelessWidget {
  const IslamicCenterMasjidRoomsPage({super.key});

  static const _rooms = [
    _MasjidRoomItem(
      title: 'Ruang VIP Masjid',
      price: 'Rp3.000.000',
      description:
          'Ruang eksklusif kami dengan suasana tenang dan nyaman, cocok untuk tamu kehormatan, rapat terbatas, dan kegiatan privat yang lebih khidmat.',
      capacity: '100 Orang',
    ),
    _MasjidRoomItem(
      title: 'Akad Nikah + Petugas',
      price: 'Rp3.500.000',
      description:
          'Layanan akad nikah lengkap dengan petugas berpengalaman, memastikan proses berjalan lancar, sakral, dan penuh makna bagi kedua mempelai.',
      capacity: '100 Orang',
    ),
    _MasjidRoomItem(
      title: 'Area Luar Masjid',
      price: 'Rp2.500.000',
      description:
          'Area terbuka yang luas dan fleksibel, cocok untuk kegiatan sosial, acara komunitas, hingga momen kebersamaan yang lebih santai.',
      capacity: '100 Orang',
    ),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeIslamicCenterMasjid);
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
                      'Ruangan Masjid',
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
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
                itemCount: _rooms.length + 1,
                separatorBuilder: (context, index) =>
                    SizedBox(height: index == 0 ? 18 : 22),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Text(
                      'Pilihan Ruangan',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: context.appTextColor,
                      ),
                    );
                  }

                  final room = _rooms[index - 1];
                  return _MasjidRoomCard(
                    room: room,
                    onTap: () => context.pushNamed(
                      RouteNames.homeIslamicCenterMasjidBooking,
                      queryParameters: {'room': room.title},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MasjidRoomItem {
  const _MasjidRoomItem({
    required this.title,
    required this.price,
    required this.description,
    required this.capacity,
  });

  final String title;
  final String price;
  final String description;
  final String capacity;
}

class _MasjidRoomCard extends StatelessWidget {
  const _MasjidRoomCard({required this.room, required this.onTap});

  final _MasjidRoomItem room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ]),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                    child: Image.asset(
                      'assets/images/dummy_image.png',
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 18,
                    right: 18,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'TERSEDIA',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                          color: AppColors.welcomeAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      room.title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: context.appTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'MULAI DARI',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: context.appMutedTextColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        room.price,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.welcomeAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                room.description,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.55,
                  color: context.appMutedTextColor,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'KAPASITAS',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: context.appMutedTextColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Icon(
                    Icons.groups_2_outlined,
                    size: 22,
                    color: context.appMutedTextColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    room.capacity,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: context.appTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 62,
                child: FilledButton(
                  onPressed: onTap,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.welcomeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(31),
                    ),
                    textStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Text('Detail Pemesanan'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
