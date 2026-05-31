import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class IslamicCenterAulaPage extends StatelessWidget {
  const IslamicCenterAulaPage({super.key});

  static const _rooms = [
    _RoomOption(
      name: 'Hall Utama',
      price: 'Rp10.000.000',
      description:
          'Ruangan termegah kami dengan kapasitas masif, cocok untuk resepsi pernikahan, seminar internasional, dan pertemuan akbar komunitas.',
      capacity: '2000 Orang',
    ),
    _RoomOption(
      name: 'Hall Madya',
      price: 'Rp7.500.000',
      description:
          'Ruangan menengah untuk pelatihan intensif, workshop, dan acara formal berskala komunitas.',
      capacity: '800 Orang',
    ),
  ];

  static const _reviews = [
    _ReviewItem(
      name: 'Alex Rivera',
      review:
          'The sunrise was absolutely breathtaking. Make sure to bring a warm jacket, it\'s freezing before dawn!',
    ),
    _ReviewItem(
      name: 'Nadia Putri',
      review:
          'Ruangannya luas, akustiknya nyaman, dan sangat cocok untuk acara resmi maupun semi formal.',
    ),
  ];

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeIslamicCenterMain);
  }

  void _showPlaceholder(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
          ),
        ),
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
                      'Aula',
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
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Image.asset(
                        'assets/images/dummy_image.png',
                        width: double.infinity,
                        height: 380,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF111827,
                            ).withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Text(
                        'Aula utama di Islamic Center Jawa Timur menghadirkan ruang luas dengan kapasitas besar yang dirancang untuk berbagai kebutuhan acara. Dilengkapi fasilitas modern serta tata ruang yang fleksibel, aula ini sangat ideal untuk seminar, pelatihan, resepsi, hingga pertemuan berskala besar. Suasana yang nyaman dan representatif menjadikannya pilihan tepat untuk menyelenggarakan kegiatan formal maupun semi-formal dengan kesan profesional.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.8,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    _SectionHeader(
                      title: 'Pilihan Ruangan',
                      actionLabel: 'Lihat Semua',
                      onTap: () => context.pushNamed(
                        RouteNames.homeIslamicCenterAulaRooms,
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 520,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _rooms.length,
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final room = _rooms[index];
                          return _RoomCard(
                            room: room,
                            onTap: () => context.pushNamed(
                              RouteNames.homeIslamicCenterAulaBooking,
                              queryParameters: {'room': room.name},
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF111827,
                            ).withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Beri Ulasan',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2A2E35),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const _RatingRow(),
                          const SizedBox(height: 22),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Tambahkan komentar...',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 62,
                            child: FilledButton(
                              onPressed: () => _showPlaceholder(
                                context,
                                'Fitur submit review aula akan kita lanjutkan berikutnya.',
                              ),
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
                              child: const Text('Submit Review'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _SectionHeader(
                      title: 'Ulasan',
                      actionLabel: 'Lihat Semua',
                      onTap: () => _showPlaceholder(
                        context,
                        'Daftar ulasan lengkap aula akan kita lanjutkan berikutnya.',
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 280,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _reviews.length,
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          return _ReviewCard(review: _reviews[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoomOption {
  const _RoomOption({
    required this.name,
    required this.price,
    required this.description,
    required this.capacity,
  });

  final String name;
  final String price;
  final String description;
  final String capacity;
}

class _ReviewItem {
  const _ReviewItem({required this.name, required this.review});

  final String name;
  final String review;
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onTap,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2A2E35),
            ),
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            actionLabel,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.welcomeAccent,
            ),
          ),
        ),
      ],
    );
  }
}

class _RoomCard extends StatelessWidget {
  const _RoomCard({required this.room, required this.onTap});

  final _RoomOption room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            room.name,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2A2E35),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'MULAI DARI',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: const Color(0xFF8B8D94),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            room.price,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.welcomeAccent,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            room.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.55,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'KAPASITAS',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: const Color(0xFF8B8D94),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.groups_2_outlined,
                size: 22,
                color: Color(0xFF8B8D94),
              ),
              const SizedBox(width: 10),
              Text(
                room.capacity,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3B3D42),
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
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
        ],
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final isFilled = index < 4;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Icon(
            Icons.star_rounded,
            size: 38,
            color: isFilled ? const Color(0xFFF59E0B) : const Color(0xFFD1D5DB),
          ),
        );
      }),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final _ReviewItem review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFE7F0FF),
                child: Icon(
                  Icons.person_rounded,
                  color: AppColors.welcomeAccent,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2A2E35),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (_) => const Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: Color(0xFFFCD34D),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            '"${review.review}"',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.6,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
