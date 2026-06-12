import 'dart:convert';

class DestinasiModel {
  final int id;
  final String namaWisata;
  final String kabupatenKota;
  final String deskripsi;
  final String harga;
  final String rating;
  final String? fotoUrl;
  final String? kecamatan;
  final int? ketinggianMdpl;
  final double? rataRataSuhu;

  DestinasiModel({
    required this.id,
    required this.namaWisata,
    required this.kabupatenKota,
    required this.deskripsi,
    required this.harga,
    required this.rating,
    this.fotoUrl,
    this.kecamatan,
    this.ketinggianMdpl,
    this.rataRataSuhu,
  });

  factory DestinasiModel.fromJson(Map<String, dynamic> json) {
    String deskripsiHasil = 'Deskripsi tidak tersedia.';
    if (json['deskripsi_sejarah'] != null && json['deskripsi_sejarah'].toString().trim().isNotEmpty) {
      deskripsiHasil = json['deskripsi_sejarah'].toString();
    } else if (json['deskripsi'] != null && json['deskripsi'].toString().trim().isNotEmpty) {
      deskripsiHasil = json['deskripsi'].toString();
    }


    return DestinasiModel(
      id: json['id'] ?? 0,
      namaWisata: json['nama_tempat']?.toString() ?? json['nama_wisata'] ?? 'Destinasi Wisata',

      kabupatenKota: json['kabupaten_kota']?.toString() ?? '',

      deskripsi: deskripsiHasil,

      harga: json['harga_tiket_masuk'] != null
          ? 'IDR ${json['harga_tiket_masuk']}'
          : json['harga'] != null ? 'IDR ${json['harga']}' : 'Free',

      rating: json['rating']?.toString() ?? '5.0',
      fotoUrl: json['foto_utama'] ?? json['foto_url'],
      kecamatan: json['kecamatan']?.toString(),

      ketinggianMdpl: json['ketinggian_mdpl'] != null
          ? int.tryParse(json['ketinggian_mdpl'].toString())
          : null,

      rataRataSuhu: json['rata_rata_suhu'] != null
          ? double.tryParse(json['rata_rata_suhu'].toString())
          : null,
    );
  }
}

class EventModel {
  final int id;
  final String namaEvent;
  final String kabupatenKota;
  final String deskripsi;
  final String? fotoUrl;

  EventModel({
    required this.id,
    required this.namaEvent,
    required this.kabupatenKota,
    required this.deskripsi,
    this.fotoUrl,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? 0,
      namaEvent: json['nama_event']?.toString() ?? '',
      kabupatenKota: json['kabupaten_kota']?.toString() ?? '',
      deskripsi: json['deskripsi']?.toString() ?? '',
      fotoUrl: json['foto_url']?.toString(),
    );
  }
}

class AkomodasiModel {
  final int id;
  final String namaAkomodasi;
  final String kabupatenKota;
  final String deskripsi;
  final String harga;
  final String? fotoUrl;
  final String rating;
  // Tambahan field opsional jika UI detail akomodasi butuh list fasilitas
  final List<String> fasilitasPopuler;

  AkomodasiModel({
    required this.id,
    required this.namaAkomodasi,
    required this.kabupatenKota,
    required this.deskripsi,
    required this.harga,
    required this.rating,
    this.fotoUrl,
    this.fasilitasPopuler = const [],
  });

  factory AkomodasiModel.fromJson(Map<String, dynamic> json) {
    List<String> fasilitas = [];
    if (json['fasilitas_populer'] != null) {
      if (json['fasilitas_populer'] is List) {
        fasilitas = List<String>.from(json['fasilitas_populer']);
      } else {
        try {
          final parsed = jsonDecode(json['fasilitas_populer']);
          if (parsed is List) fasilitas = List<String>.from(parsed);
        } catch (_) {}
      }
    }

    final String? namaFileGambar = json['foto_utama'];

    return AkomodasiModel(
      id: json['id'] ?? 0,

      namaAkomodasi: json['nama_akomodasi']?.toString() ?? 'Akomodasi Wisata',
      kabupatenKota: json['kabupaten_kota']?.toString() ?? '',

      deskripsi: json['deskripsi_fasilitas_utama']?.toString() ?? 'Fasilitas tidak tersedia.',

      harga: json['harga_sewa_terendah'] != null
          ? 'IDR ${double.tryParse(json['harga_sewa_terendah'].toString())?.toStringAsFixed(0) ?? json['harga_sewa_terendah']}'
          : 'N/A',

      rating: json['rating_total']?.toString() ?? '5.0',

      fotoUrl: namaFileGambar != null && namaFileGambar.isNotEmpty
          ? 'assets/images/$namaFileGambar'
          : 'assets/images/padusan_main.jpg',

      fasilitasPopuler: fasilitas,
    );
  }
}