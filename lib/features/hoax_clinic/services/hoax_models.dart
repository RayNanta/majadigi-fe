class HoaxReportModel {
  final int id;
  final String nomorTiket;
  final String namaPelapor;
  final String deskripsiLaporan;
  final String? urlBukti;
  final String status;
  final String createdAt;

  HoaxReportModel({
    required this.id,
    required this.nomorTiket,
    required this.namaPelapor,
    required this.deskripsiLaporan,
    this.urlBukti,
    required this.status,
    required this.createdAt,
  });

  factory HoaxReportModel.fromJson(Map<String, dynamic> json) {
    return HoaxReportModel(
      id: json['id'] ?? 0,
      nomorTiket: json['nomor_tiket']?.toString() ?? '',
      namaPelapor: json['nama_pelapor']?.toString() ?? 'Anonim',
      deskripsiLaporan: json['deskripsi_laporan']?.toString() ?? '',
      urlBukti: json['url_bukti']?.toString(),
      status: json['status']?.toString() ?? 'proses',
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}