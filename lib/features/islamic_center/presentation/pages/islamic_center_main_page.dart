import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:majadigi_mobile/features/islamic_center/services/islamic_center_service.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class FacilityModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String? thumbnail;
  final double averageRating;
  final int totalReviews;

  FacilityModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    this.thumbnail,
    required this.averageRating,
    required this.totalReviews,
  });

  factory FacilityModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return FacilityModel(
      id: int.tryParse(
        json['id']?.toString() ?? '0',
      ) ??
          0,

      name: json['name']?.toString() ?? '',

      slug: json['slug']?.toString() ?? '',

      description:
      json['description']?.toString() ?? '',

      thumbnail: json['thumbnail']?.toString(),

      averageRating: double.tryParse(
        json['average_rating']?.toString() ?? '0',
      ) ??
          0.0,

      totalReviews: int.tryParse(
        json['total_reviews']?.toString() ?? '0',
      ) ??
          0,
    );
  }
}

class IslamicCenterMainPage extends StatefulWidget {
  const IslamicCenterMainPage({super.key});

  @override
  State<IslamicCenterMainPage> createState() =>
      _IslamicCenterMainPageState();

}

class _IslamicCenterMainPageState
    extends State<IslamicCenterMainPage> {

  final _service = IslamicCenterService();

  List<FacilityModel> facilities = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFacilities();
  }

  Future<void> loadFacilities() async {
    try {
      final result =
      await _service.getFacilities();

      setState(() {
        facilities = result;
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

    context.goNamed(RouteNames.homeIslamicCenter);
  }

  void _showPlaceholder(BuildContext context, String label) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Detail $label akan kita lanjutkan berikutnya.',
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
                      'ISLAMIC CENTER JAWA TIMUR',
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
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                itemCount: facilities.length + 1,
                separatorBuilder: (_, index) =>
                    SizedBox(height: index == 0 ? 24 : 28),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Text(
                      'Pilih Fasilitas Sesuai Kebutuhan Anda',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF20242C),
                        height: 1.25,
                      ),
                    );
                  }

                  final facility = facilities[index - 1];

                  return _FacilityCard(
                    facility: facility,
                    onTap: () {
                      context.pushNamed(
                        RouteNames.homeIslamicCenterDetail,
                        pathParameters: {
                          'id': facility.id.toString(),
                        },
                      );
                    },
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



class _FacilityItem {
  const _FacilityItem({
    required this.title,
    required this.description,
    required this.tags,
    this.routeName,
  });

  final String title;
  final String description;
  final List<String> tags;
  final String? routeName;
}

class _FacilityCard extends StatelessWidget {
  const _FacilityCard({
    required this.facility,
    required this.onTap,
  });

  final FacilityModel facility;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 22),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                        child: facility.thumbnail != null
                            ? Image.network(
                          facility.thumbnail!,
                          width: double.infinity,
                          height: 270,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          'assets/images/dummy_image.png',
                          width: double.infinity,
                          height: 270,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 18,
                        child: _OverlayPill(
                          label: 'TERSEDIA',
                          backgroundColor: Colors.white,
                          textColor: AppColors.welcomeAccent,
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 18,
                        child: _RatingChip(
                          rating: facility.averageRating,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        facility.name,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF262A32),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        facility.slug ?? '-',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.55,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 12,
                        children: [
                          _TagChip(
                            label:
                            '${facility.averageRating.toStringAsFixed(1)} ⭐',
                          ),
                          _TagChip(
                            label:
                            '${facility.totalReviews} Ulasan',
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        height: 62,
                        child: FilledButton(
                          key: ValueKey('facility-detail-${facility.name}'),
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
                          child: const Text('Lihat Detail'),
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

class _OverlayPill extends StatelessWidget {
  const _OverlayPill({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
          color: textColor,
        ),
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  const _RatingChip({
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF7B4B17).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 18, color: Color(0xFFFCD34D)),
          const SizedBox(width: 6),
          Text(
            rating.toStringAsFixed(1),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F0FF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColors.welcomeAccent,
        ),
      ),
    );
  }
}
