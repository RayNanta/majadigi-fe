import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class KhasJatimSeratSriSedanaPage extends StatefulWidget {
  const KhasJatimSeratSriSedanaPage({super.key});

  @override
  State<KhasJatimSeratSriSedanaPage> createState() =>
      _KhasJatimSeratSriSedanaPageState();
}

class _KhasJatimSeratSriSedanaPageState
    extends State<KhasJatimSeratSriSedanaPage> {
  final TextEditingController _commentController = TextEditingController();

  static const _metadata = [
    _MetadataItem(label: 'KATEGORI', value: 'Masa Pra Islam'),
    _MetadataItem(label: 'SUMBER / PEMILIK', value: 'Sdr. Suroleksono'),
    _MetadataItem(label: 'ASAL DAERAH', value: 'Kabupaten Lamongan'),
    _MetadataItem(label: 'JUMLAH HALAMAN', value: '260'),
    _MetadataItem(label: 'BAHASA', value: 'Jawa'),
    _MetadataItem(label: 'AKSARA', value: 'Jawa'),
  ];

  static const _comments = [
    _CommentItem(
      name: 'Alex Rivera',
      comment:
          'Koleksi yang komprehensif. Saya menggunakan referensi ini untuk tesis saya. Antarmuka pencariannya sangat memudahkan menemukan kata kunci spesifik dalam naskah.',
    ),
    _CommentItem(
      name: 'Alex Rivera',
      comment:
          'Sangat membantu untuk riset sejarah. Detail pada naskah digital ini luar biasa jernih, memudahkan pembacaan aksara kuno yang biasanya sulit diidentifikasi. Terima kasih tim pengarsip!',
    ),
  ];

  bool get _canSubmit => _commentController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _commentController.addListener(_handleCommentChanged);
  }

  @override
  void dispose() {
    _commentController
      ..removeListener(_handleCommentChanged)
      ..dispose();
    super.dispose();
  }

  void _handleCommentChanged() {
    setState(() {});
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeKhasJatimManuscripts);
  }

  void _openReaderPreview() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Pratinjau Naskah',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2B2F38),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    'assets/images/dummy_image.png',
                    width: double.infinity,
                    height: 320,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Fitur pembaca naskah detail akan kita lanjutkan pada tahap berikutnya.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                    color: const Color(0xFF737987),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitComment() {
    if (!_canSubmit) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Komentar untuk Serat Sri Sedana berhasil dikirim.',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
          ),
        ),
      );

    _commentController.clear();
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
                    onPressed: _handleBack,
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
                      'Serat Sri Sedana',
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
                    Text(
                      'Serat Sri Sedana',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2B2F38),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _openReaderPreview,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          'assets/images/dummy_image.png',
                          width: double.infinity,
                          height: 360,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F1FF),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_rounded,
                            color: AppColors.welcomeAccent,
                            size: 26,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Keterangan: Klik gambar untuk membaca',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF5D6472),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Artefak sastra bersejarah dari era Pra-Islam di Jawa, dipelihara dengan cermat untuk memberikan gambaran tentang warisan budaya dan linguistik Jawa Timur.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.8,
                        color: const Color(0xFF7D8391),
                      ),
                    ),
                    const SizedBox(height: 26),
                    for (final item in _metadata) ...[
                      _MetadataCard(item: item),
                      if (item != _metadata.last) const SizedBox(height: 12),
                    ],
                    const SizedBox(height: 28),
                    Text(
                      'Komentar',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2B2F38),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
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
                            'Beri Komentar',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2B2F38),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _commentController,
                            maxLines: 3,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2E3038),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Tambahkan komentar...',
                              hintStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF9AA0AE),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF4F5F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: OutlinedButton(
                              onPressed: _canSubmit ? _submitComment : null,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: AppColors.welcomeAccent,
                                  width: 1.6,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(29),
                                ),
                              ),
                              child: Text(
                                'Kirim Komentar',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.welcomeAccent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    for (final comment in _comments) ...[
                      _CommentCard(item: comment),
                      if (comment != _comments.last) const SizedBox(height: 18),
                    ],
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

class _MetadataCard extends StatelessWidget {
  const _MetadataCard({required this.item});

  final _MetadataItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF757D8A),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentCard extends StatelessWidget {
  const _CommentCard({required this.item});

  final _CommentItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFE9F1FF),
            child: Icon(
              Icons.person_rounded,
              color: AppColors.welcomeAccent,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2B2F38),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.comment,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.8,
                    color: const Color(0xFF8A8F9C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetadataItem {
  const _MetadataItem({required this.label, required this.value});

  final String label;
  final String value;
}

class _CommentItem {
  const _CommentItem({required this.name, required this.comment});

  final String name;
  final String comment;
}
