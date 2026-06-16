import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'khas_jatim_models.dart';

class KhasJatimService {
  static const String _baseUrl = 'https://capstone-project-majadigi-to-super-app-production.up.railway.app/api';
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Host': 'majadigi.test',
  };

  Future<List<NaskahKunoModel>> getNaskahKuno({
    String search = '',
    String? kategori,
    String? asalDaerah,
    String? perkiraanTahun,
    String? jenisAksara,
    String? jenisBahasa,
  }) async {
    try {
      // ✅ Sesuaikan dengan route Laravel Anda
      String urlString = '$_baseUrl/v1/naskah';
      final List<String> queryParams = [];

      if (search.isNotEmpty) queryParams.add('search=$search');
      if (kategori != null && kategori.isNotEmpty) queryParams.add('kategori=$kategori');
      if (asalDaerah != null && asalDaerah.isNotEmpty) queryParams.add('asal_daerah=$asalDaerah');
      if (perkiraanTahun != null && perkiraanTahun.isNotEmpty) queryParams.add('perkiraan_tahun=$perkiraanTahun');
      if (jenisAksara != null && jenisAksara.isNotEmpty) queryParams.add('jenis_aksara=$jenisAksara');
      if (jenisBahasa != null && jenisBahasa.isNotEmpty) queryParams.add('jenis_bahasa=$jenisBahasa');

      if (queryParams.isNotEmpty) urlString += '?${queryParams.join('&')}';

      print('=== KHAS JATIM DEBUG ===');
      print('URL GET: $urlString');

      final response = await http.get(Uri.parse(urlString), headers: _headers);

      print('Status GET: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final listData = (responseData['data'] ?? []) as List<dynamic>;
        return listData.map((e) => NaskahKunoModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Gagal memuat naskah kuno status: ${response.statusCode}');
      }
    } catch (e) {
      print('ERROR KHAS JATIM GET: $e');
      throw Exception('Error API KhasJatim: $e');
    }
  }

  Future<bool> registerNaskahKuno({
    required String skemaPendaftaran,
    required String namaPendaftar,
    required String noHpPendaftar,
    required String alamatPendaftar,
    required String judul,
    required String perkiraanTahun,
    required String jenisAksara,
    required String jenisBahasa,
    required String fileLampiranPdf,
  }) async {
    try {
      const urlString = '$_baseUrl/v1/naskah/register';

      print('=== KHAS JATIM POST DEBUG ===');
      print('URL POST: $urlString');

      final Map<String, dynamic> bodyPayload = {
        'skema_pendaftaran': skemaPendaftaran,
        'nama_pendaftar': namaPendaftar,
        'no_hp_pendaftar': noHpPendaftar,
        'alamat_pendaftar': alamatPendaftar,
        'judul': judul,
        'perkiraan_tahun': perkiraanTahun,
        'jenis_aksara': jenisAksara,
        'jenis_bahasa': jenisBahasa,
        'file_lampiran_pdf': fileLampiranPdf,
        'deskripsi': 'Naskah didevelop rill melalui formulir pendaftaran aplikasi mobile Nawasena.',
        'jumlah_halaman': 100,
        'foto_naskah': 'default_naskah.jpg',
        'kategori': 'Lainnya', // Kolom tambahan jika database mewajibkan data kategori terisi rill
      };

      final response = await http.post(
        Uri.parse(urlString),
        headers: _headers,
        body: json.encode(bodyPayload),
      );

      print('Status POST: ${response.statusCode}');
      print('Body POST: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Eror saat hit POST register naskah: $e');
      return false;
    }
  }
}
// ==================== RIVERPOD PROVIDERS ====================
final khasJatimServiceProvider = Provider<KhasJatimService>((ref) => KhasJatimService());

final khasJatimManuscriptsProvider = FutureProvider.family<List<NaskahKunoModel>, KhasJatimFilterParams>((ref, params) async {
  final service = ref.watch(khasJatimServiceProvider);
  return service.getNaskahKuno(
    search: params.search,
    kategori: params.kategori,
    asalDaerah: params.asalDaerah,
    perkiraanTahun: params.perkiraanTahun,
    jenisAksara: params.jenisAksara,
    jenisBahasa: params.jenisBahasa,
  );
});