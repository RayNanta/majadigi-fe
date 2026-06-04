import 'dart:convert';

import '../../../core/api/api_service.dart';

class SiskaperbapoService {
  Future<List<dynamic>> getHargaPokok() async {
    final response = await ApiService.get('/harga-pokok');

    final data = jsonDecode(response.body);

    return data['data'] ?? [];
  }
}