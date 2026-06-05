import 'package:flutter/foundation.dart';

enum SinakerRegistrationStatus { waiting, rejected, accepted }

final class SinakerTrainingRegistrationRecord {
  const SinakerTrainingRegistrationRecord({
    required this.id,
    required this.trainingTitle,
    required this.location,
    required this.batch,
    required this.applicantName,
    required this.nik,
    required this.submittedAt,
    required this.updatedAt,
    required this.status,
    required this.category,
  });

  final String id;
  final String trainingTitle;
  final String location;
  final String batch;
  final String applicantName;
  final String nik;
  final String submittedAt;
  final String updatedAt;
  final SinakerRegistrationStatus status;
  final String category;
}

final class SinakerTrainingRegistrationStore {
  SinakerTrainingRegistrationStore._();

  static const _baristaTrainingId = 'barista-profesional-coffee-shop';

  static final registrations =
      ValueNotifier<List<SinakerTrainingRegistrationRecord>>(const [
        SinakerTrainingRegistrationRecord(
          id: _baristaTrainingId,
          trainingTitle:
              'Pelatihan Barista Profesional & Manajemen Coffee Shop',
          location: 'UPT BLK Surabaya',
          batch: 'Batch 24 - 2026',
          applicantName: 'Bambang Pamungkas',
          nik: '3578021908920001',
          submittedAt: '3 Jun 2026, 09:42 WIB',
          updatedAt: 'Sedang Berjalan',
          status: SinakerRegistrationStatus.waiting,
          category: 'PARIWISATA',
        ),
        SinakerTrainingRegistrationRecord(
          id: 'graphic-design-ui-ux-foundations',
          trainingTitle: 'Graphic Design & UI/UX Foundations',
          location: 'UPT BLK Malang',
          batch: 'Batch 18 - 2026',
          applicantName: 'Bambang Pamungkas',
          nik: '3578021908920001',
          submittedAt: '28 Mei 2026, 14:16 WIB',
          updatedAt: 'Ditolak pada 31 Mei 2026',
          status: SinakerRegistrationStatus.rejected,
          category: 'KREATIF',
        ),
        SinakerTrainingRegistrationRecord(
          id: 'pemasangan-pemeliharaan-panel-surya',
          trainingTitle: 'Pemasangan & Pemeliharaan Panel Surya (PLTS)',
          location: 'UPT BLK Sumenep',
          batch: 'Batch 12 - 2026',
          applicantName: 'Bambang Pamungkas',
          nik: '3578021908920001',
          submittedAt: '21 Mei 2026, 10:05 WIB',
          updatedAt: 'Diterima pada 27 Mei 2026',
          status: SinakerRegistrationStatus.accepted,
          category: 'TEKNIK ENERGI',
        ),
      ]);

  static SinakerTrainingRegistrationRecord? findById(String? id) {
    if (id == null || id.trim().isEmpty) return null;

    for (final registration in registrations.value) {
      if (registration.id == id) return registration;
    }

    return null;
  }

  static SinakerTrainingRegistrationRecord registerBarista({
    required String applicantName,
    required String nik,
  }) {
    final record = SinakerTrainingRegistrationRecord(
      id: _baristaTrainingId,
      trainingTitle: 'Pelatihan Barista Profesional & Manajemen Coffee Shop',
      location: 'UPT BLK Surabaya',
      batch: 'Batch 24 - 2026',
      applicantName: applicantName,
      nik: nik,
      submittedAt: _formatTimestamp(DateTime.now()),
      updatedAt: 'Sedang Berjalan',
      status: SinakerRegistrationStatus.waiting,
      category: 'PARIWISATA',
    );

    final existing = registrations.value
        .where((registration) => registration.id != record.id)
        .toList();
    registrations.value = [record, ...existing];

    return record;
  }

  static String _formatTimestamp(DateTime value) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];

    final day = value.day;
    final month = months[value.month - 1];
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');

    return '$day $month ${value.year}, $hour:$minute WIB';
  }
}
