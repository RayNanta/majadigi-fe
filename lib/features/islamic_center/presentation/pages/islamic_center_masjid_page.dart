import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class IslamicCenterMasjidPage extends StatelessWidget {
  const IslamicCenterMasjidPage({super.key});

  static const _rooms = [
    _MasjidRoom(
      name: 'Ruang VIP Masjid',
      price: 'Rp3.000.000',
      description:
          'Ruang eksklusif kami dengan suasana tenang dan nyaman, cocok untuk tamu kehormatan, rapat terbatas, dan kegiatan privat yang lebih khidmat.',
      capacity: '100 Orang',
    ),
    _MasjidRoom(
      name: 'Akad Nikah + Petugas',
      price: 'Rp3.500.000',
      description:
          'Layanan akad nikah lengkap dengan petugas berpengalaman untuk mendukung prosesi yang sakral dan tertata.',
      capacity: '100 Orang',
    ),
    _MasjidRoom(
      name: 'Area Luar Masjid',
      price: 'Rp2.500.000',
      description:
          'Area terbuka yang fleksibel untuk kegiatan sosial, acara komunitas, dan momen kebersamaan yang lebih santai.',
      capacity: '100 Orang',
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
          'Ruangannya tenang, bersih, dan sangat mendukung acara yang butuh suasana lebih khusyuk.',
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
                      'Masjid',
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
                        height: 420,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                      decoration: BoxDecoration(
                        color: context.appSurfaceColor,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: context.appThemedCardShadows([
                          BoxShadow(
                            color: const Color(
                              0xFF111827,
                            ).withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ]),
                      ),
                      child: Text(
                        'Masjid di Islamic Center Jawa Timur menjadi pusat ibadah yang megah dengan arsitektur yang indah dan atmosfer yang khusyuk. Memiliki kapasitas besar, masjid ini mampu menampung jamaah dalam jumlah banyak, baik untuk salat berjamaah, kajian, maupun kegiatan keislaman lainnya. Nuansa religius yang kuat serta fasilitas yang memadai menjadikan masjid ini sebagai tempat yang ideal untuk memperdalam ibadah dan mempererat kebersamaan umat.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.8,
                          color: context.appMutedTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    _SectionHeader(
                      title: 'Pilihan Ruangan',
                      actionLabel: 'Lihat Semua',
                      onTap: () => context.pushNamed(
                        RouteNames.homeIslamicCenterMasjidRooms,
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 520,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _rooms.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final room = _rooms[index];
                          return _RoomCard(
                            room: room,
                            onTap: () => _showPlaceholder(
                              context,
                              'Detail pemesanan ${room.name} akan kita lanjutkan berikutnya.',
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
                        color: context.appSurfaceColor,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: context.appThemedCardShadows([
                          BoxShadow(
                            color: const Color(
                              0xFF111827,
                            ).withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ]),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Beri Ulasan',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: context.appTextColor,
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
                                color: context.appMutedTextColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 62,
                            child: OutlinedButton(
                              onPressed: () => _showPlaceholder(
                                context,
                                'Fitur kirim ulasan masjid akan kita lanjutkan berikutnya.',
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.welcomeAccent,
                                side: const BorderSide(
                                  color: AppColors.welcomeAccent,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(31),
                                ),
                                textStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              child: const Text('Kirim Ulasan'),
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
                        'Daftar ulasan lengkap masjid akan kita lanjutkan berikutnya.',
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 280,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _reviews.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) =>
                            _ReviewCard(review: _reviews[index]),
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

class _MasjidRoom {
  const _MasjidRoom({
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

class _RoomCard extends StatelessWidget {
  const _RoomCard({required this.room, required this.onTap});

  final _MasjidRoom room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305,
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
        padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              room.name,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: context.appTextColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'MULAI DARI',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: context.appMutedTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              room.price,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.welcomeAccent,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              room.description,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.6,
                color: context.appMutedTextColor,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Text(
              'KAPASITAS',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: context.appMutedTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
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
            const SizedBox(height: 22),
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
      ),
    );
  }
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
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: context.appTextColor,
            ),
          ),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.welcomeAccent,
            textStyle: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          child: Text(actionLabel),
        ),
      ],
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
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Icon(
            isFilled ? Icons.star_rounded : Icons.star_border_rounded,
            size: 36,
            color: isFilled ? const Color(0xFFFFB423) : const Color(0xFFD1D5DB),
          ),
        );
      }),
    );
  }
}

class _ReviewItem {
  const _ReviewItem({required this.name, required this.review});

  final String name;
  final String review;
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final _ReviewItem review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(26),
        boxShadow: context.appThemedCardShadows([
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? AppColors.welcomeAccent.withValues(alpha: 0.16)
                      : const Color(0xFFE8F0FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: AppColors.welcomeAccent,
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
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: context.appTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: Color(0xFFFFB423),
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
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.7,
              color: context.appMutedTextColor,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
