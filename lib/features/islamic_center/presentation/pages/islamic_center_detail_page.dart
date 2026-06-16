import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:majadigi_mobile/features/islamic_center/services/islamic_center_service.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme_extensions.dart';

class IslamicCenterDetailPage extends StatefulWidget {
  final int facilityId;

  const IslamicCenterDetailPage({super.key, required this.facilityId});

  @override
  State<IslamicCenterDetailPage> createState() =>
      _IslamicCenterDetailPageState();
}

class _IslamicCenterDetailPageState extends State<IslamicCenterDetailPage> {
  final IslamicCenterService _service = IslamicCenterService();

  Map<String, dynamic>? facility;

  bool isLoading = true;

  int selectedRating = 0;

  final TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadDetail();
  }

  Future<void> loadDetail() async {
    try {
      final result = await _service.getFacilityDetail(widget.facilityId);

      setState(() {
        facility = result;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (facility == null) {
      return const Scaffold(body: Center(child: Text('Data tidak ditemukan')));
    }

    final rooms = facility!['rooms'] ?? [];

    final reviews = facility!['reviews'] ?? [];

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
                      facility!['name'],
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
                      child: facility!['thumbnail_url'] != null
                          ? Image.network(
                              facility!['thumbnail_url'],
                              width: double.infinity,
                              height: 380,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
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
                        facility!['description'] ?? '-',
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
                        RouteNames.homeIslamicCenterAulaRooms,
                        pathParameters: {
                          'facilityId': widget.facilityId.toString(),
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 520,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: rooms.length,
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final room = rooms[index];
                          return _RoomCard(
                            room: room,
                            onTap: () => context.pushNamed(
                              RouteNames.homeIslamicCenterBooking,
                              queryParameters: {
                                'roomId': room['id'].toString(),
                              },
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
                          _RatingRow(
                            rating: selectedRating,
                            onChanged: (value) {
                              setState(() {
                                selectedRating = value;
                              });
                            },
                          ),
                          const SizedBox(height: 22),
                          TextField(
                            controller: reviewController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'Tambahkan komentar...',
                              hintStyle: GoogleFonts.plusJakartaSans(
                                color: context.appMutedTextColor,
                              ),
                              filled: true,
                              fillColor: context.isDarkMode
                                  ? context.appSubtleSurfaceColor
                                  : const Color(0xFFF7F9FF),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: context.appBorderColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AppColors.welcomeAccent,
                                  width: 1.6,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 62,
                            child: FilledButton(
                              onPressed: () async {
                                if (selectedRating == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Pilih rating terlebih dahulu',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                if (reviewController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Ulasan tidak boleh kosong',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                try {
                                  await _service.submitReview(
                                    facilityId: widget.facilityId,
                                    rating: selectedRating,
                                    review: reviewController.text.trim(),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Review berhasil dikirim'),
                                    ),
                                  );

                                  reviewController.clear();

                                  setState(() {
                                    selectedRating = 0;
                                  });

                                  await loadDetail();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              },
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
                        itemCount: reviews.length,
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          return _ReviewCard(review: reviews[index]);
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
              color: context.appTextColor,
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

  final Map<String, dynamic> room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${room['name'] ?? '-'}',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: context.appTextColor,
            ),
          ),
          const SizedBox(height: 10),
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
            'Rp ${room['price'] ?? 0}',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.welcomeAccent,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${room['description'] ?? '-'}',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.55,
              color: context.appMutedTextColor,
            ),
          ),
          const SizedBox(height: 18),
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
                '${room['capacity'] ?? 0} Orang',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: context.appTextColor,
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
  final int rating;
  final ValueChanged<int> onChanged;

  const _RatingRow({required this.rating, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final star = index + 1;

        return GestureDetector(
          onTap: () => onChanged(star),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(
              Icons.star_rounded,
              size: 38,
              color: star <= rating
                  ? const Color(0xFFF59E0B)
                  : const Color(0xFFD1D5DB),
            ),
          ),
        );
      }),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final Map<String, dynamic> review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: context.appSurfaceColor,
        borderRadius: BorderRadius.circular(24),
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
              CircleAvatar(
                radius: 20,
                backgroundColor: context.isDarkMode
                    ? AppColors.welcomeAccent.withValues(alpha: 0.16)
                    : const Color(0xFFE7F0FF),
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
                      review['full_name'] ?? '-',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: context.appTextColor,
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
            '"${review['review'] ?? '-'}"',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.6,
              color: context.appMutedTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
