import 'dart:convert';
import '../../../core/api/api_service.dart';

class SiskaperbapoService {

  Future<List<dynamic>> getHargaPokok() async {
    final res = await ApiService.get('/harga-bahan');

    print('STATUS: ${res.statusCode}');
    print('BODY: ${res.body}');

    final body = jsonDecode(res.body);

    return List<dynamic>.from(body['data'] ?? []);
  }

  Future<Map<String, dynamic>> getHargaPokokDetail(
      int id,
      ) async {
    final res = await ApiService.get('/harga-bahan/$id');

    final body = jsonDecode(res.body);

    return body['data'];
  }
}