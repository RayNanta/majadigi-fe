import 'dart:convert';

class NaskahKunoModel {
  final int id;
  final String judul;
  final String deskripsi;
  final int jumlahHalaman;
  final String? fotoNaskah;
  final String kategori;
  final String asalDaerah;
  final String perkiraanTahun;
  final String jenisAksara;
  final String jenisBahasa;
  final String sumberNaskah;
  final String skemaPendaftaran;
  final String namaPendaftar;
  final String noHpPendaftar;
  final String alamatPendaftar;
  final String? fileLampiranPdf;
  final String statusPengajuan;

  NaskahKunoModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.jumlahHalaman,
    this.fotoNaskah,
    required this.kategori,
    required this.asalDaerah,
    required this.perkiraanTahun,
    required this.jenisAksara,
    required this.jenisBahasa,
    required this.sumberNaskah,
    required this.skemaPendaftaran,
    required this.namaPendaftar,
    required this.noHpPendaftar,
    required this.alamatPendaftar,
    this.fileLampiranPdf,
    required this.statusPengajuan,
  });

  factory NaskahKunoModel.fromJson(Map<String, dynamic> json) {
    return NaskahKunoModel(
      id: json['id'] ?? 0,
      judul: json['judul']?.toString() ?? '',
      deskripsi: json['deskripsi']?.toString() ?? '',
      jumlahHalaman: json['jumlah_halaman'] ?? 0,
      fotoNaskah: json['foto_naskah']?.toString(),
      kategori: json['kategori']?.toString() ?? '',
      asalDaerah: json['asal_daerah']?.toString() ?? '',
      perkiraanTahun: json['perkiraan_tahun']?.toString() ?? '',
      jenisAksara: json['jenis_aksara']?.toString() ?? '',
      jenisBahasa: json['jenis_bahasa']?.toString() ?? '',
      sumberNaskah: json['sumber_naskah']?.toString() ?? '',
      skemaPendaftaran: json['skema_pendaftaran']?.toString() ?? '',
      namaPendaftar: json['nama_pendaftar']?.toString() ?? '',
      noHpPendaftar: json['no_hp_pendaftar']?.toString() ?? '',
      alamatPendaftar: json['alamat_pendaftar']?.toString() ?? '',
      fileLampiranPdf: json['file_lampiran_pdf']?.toString(),
      statusPengajuan: json['status_pengajuan']?.toString() ?? 'dikurasi',
    );
  }
}

// Parameter Pencarian Multi-Filter rill
class KhasJatimFilterParams {
  final String search;
  final String? kategori;
  final String? asalDaerah;
  final String? perkiraanTahun;
  final String? jenisAksara;
  final String? jenisBahasa;

  const KhasJatimFilterParams({
    this.search = '',
    this.kategori,
    this.asalDaerah,
    this.perkiraanTahun,
    this.jenisAksara,
    this.jenisBahasa,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! KhasJatimFilterParams) return false;
    return search == other.search &&
        kategori == other.kategori &&
        asalDaerah == other.asalDaerah &&
        perkiraanTahun == other.perkiraanTahun &&
        jenisAksara == other.jenisAksara &&
        jenisBahasa == other.jenisBahasa;
  }

  @override
  int get hashCode =>
      search.hashCode ^
      kategori.hashCode ^
      asalDaerah.hashCode ^
      perkiraanTahun.hashCode ^
      jenisAksara.hashCode ^
      jenisBahasa.hashCode;
}