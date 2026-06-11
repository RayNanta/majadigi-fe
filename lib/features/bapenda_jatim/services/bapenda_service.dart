import 'dart:convert';
import '../../../core/api/api_service.dart';

class BapendaService {

  Future<Map<String, dynamic>> cekPajak({
    required String nomorPolisi,
    required String nomorRangka,
  }) async {

    final res = await ApiService.post(
      '/v1/bapenda/cek-pajak',
      {
        'nomor_polisi': nomorPolisi,
        'nomor_rangka_lima_digit': nomorRangka,
      },
    );

    print('STATUS PAJAK : ${res.statusCode}');
    print('BODY PAJAK : ${res.body}');

    return jsonDecode(res.body);
  }


  Future<List<dynamic>> cekNjkb({
    String? jenisKendaraan,
    String? merkKendaraan,
    String? tahunPembuatan,
    String? modelTipeSpesifik,
  }) async {
    final query = <String, String>{};

    if (jenisKendaraan != null) {
      query['jenis_kendaraan'] = jenisKendaraan;
    }

    if (merkKendaraan != null) {
      query['merk_kendaraan'] = merkKendaraan;
    }

    if (tahunPembuatan != null) {
      query['tahun_pembuatan'] = tahunPembuatan;
    }

    if (modelTipeSpesifik != null) {
      query['model_tipe_spesifik'] = modelTipeSpesifik;
    }

    final uri = Uri(
      path: '/v1/bapenda/cek-njkb',
      queryParameters: query,
    );

    final res = await ApiService.get(uri.toString());

    final body = jsonDecode(res.body);

    return List<dynamic>.from(body['data'] ?? []);
  }
}