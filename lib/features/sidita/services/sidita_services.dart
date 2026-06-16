import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'sidita_models.dart';

class SiditaFilterParams {
  final String search;
  final String kabKota;

  const SiditaFilterParams({
    this.search = '',
    this.kabKota = '',
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SiditaFilterParams) return false;
    return search == other.search && kabKota == other.kabKota;
  }

  @override
  int get hashCode => search.hashCode ^ kabKota.hashCode;
}

class SiditaService {
  static const String _baseUrl = 'https://capstone-project-majadigi-to-super-app-production.up.railway.app/api';

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Host': 'majadigi.test',
  };

  Future<List<DestinasiModel>> getDestinasi({
    String search = '',
    String kabKota = '',
  }) async {
    try {
      String urlString = '$_baseUrl/v1/wisata';
      final List<String> params = [];
      if (search.isNotEmpty) params.add('search=$search');
      if (kabKota.isNotEmpty) params.add('kabupaten_kota=$kabKota');
      if (params.isNotEmpty) urlString += '?${params.join('&')}';

      print('=== SIDITA DEBUG ===');
      print('URL: $urlString');

      final response = await http.get(Uri.parse(urlString), headers: _headers);

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final listData = (responseData['data'] ?? []) as List<dynamic>;
        print('Jumlah data: ${listData.length}');
        return listData.map((e) => DestinasiModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Server me-return status: ${response.statusCode}');
      }
    } catch (e) {
      print('ERROR: $e');
      throw Exception('Gagal mengambil destinasi: $e');
    }
  }

  Future<List<AkomodasiModel>> getAkomodasi({
    String search = '',
    String kabKota = '',
  }) async {
    try {
      String urlString = '$_baseUrl/v1/akomodasi';
      final List<String> params = [];
      if (search.isNotEmpty) params.add('search=$search');
      if (kabKota.isNotEmpty) params.add('kabupaten_kota=$kabKota');
      if (params.isNotEmpty) urlString += '?${params.join('&')}';

      final response = await http.get(Uri.parse(urlString), headers: _headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final listData = (responseData['data'] ?? []) as List<dynamic>;
        return listData.map((e) => AkomodasiModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Server me-return status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gagal mengambil akomodasi: $e');
    }
  }

  Future<List<EventWisataModel>> getEvent({
    String search = '',
    String kabKota = '',
  }) async {
    try {
      String urlString = '$_baseUrl/v1/event';
      final List<String> params = [];
      if (search.isNotEmpty) params.add('search=$search');
      if (kabKota.isNotEmpty) params.add('kabupaten_kota=$kabKota');
      if (params.isNotEmpty) urlString += '?${params.join('&')}';

      final response = await http.get(Uri.parse(urlString), headers: _headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final listData = (responseData['data'] ?? []) as List<dynamic>;
        return listData.map((e) => EventWisataModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Server me-return status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gagal mengambil data event: $e');
    }
  }
}
// ==================== PROVIDER GLOBAL (OUTSIDE CLASS) ====================

final siditaServiceProvider = Provider<SiditaService>((ref) => SiditaService());

final siditaDestinasiProvider = FutureProvider.family<List<DestinasiModel>, SiditaFilterParams>((ref, params) async {
  final service = ref.watch(siditaServiceProvider);
  return service.getDestinasi(search: params.search, kabKota: params.kabKota);
});

final siditaAkomodasiProvider = FutureProvider.family<List<AkomodasiModel>, SiditaFilterParams>((ref, params) async {
  final service = ref.watch(siditaServiceProvider);
  return service.getAkomodasi(search: params.search, kabKota: params.kabKota);
});

final siditaEventProvider = FutureProvider.family<List<EventWisataModel>, SiditaFilterParams>((ref, params) async {
  final service = ref.watch(siditaServiceProvider);
  return service.getEvent(search: params.search, kabKota: params.kabKota);
});