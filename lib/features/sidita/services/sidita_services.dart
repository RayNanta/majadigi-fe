import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_service.dart'; // Sesuaikan relative path ke ApiService timmu
import 'sidita_models.dart';

class SiditaService {
  Future<List<DestinasiModel>> getDestinasi({String search = '', String kabKota = ''}) async {
    try {
      String endpoint = '/v1/wisata';
      List<String> params = [];

      if (search.isNotEmpty) params.add('search=$search');
      if (kabKota.isNotEmpty) params.add('kabupaten_kota=$kabKota');
      if (params.isNotEmpty) endpoint += '?${params.join('&')}';

      final response = await ApiService.get(endpoint);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> listData = responseData['data'] ?? [];
        return listData.map((e) => DestinasiModel.fromJson(e)).toList();
      } else {
        throw Exception('Gagal mengambil data destinasi (${response.statusCode})');
      }
    } catch (e){
      throw Exception('Koneksi bermasalah: $e');
    }
  }
}

// Provider Utama Service
final siditaServiceProvider = Provider<SiditaService>((ref) => SiditaService());

// FutureProvider Utama yang akan dipantau oleh UI secara real-time
final siditaDestinasiProvider = FutureProvider.family<List<DestinasiModel>, Map<String, String>>((ref, argument) async {
  final service = ref.watch(siditaServiceProvider);
  return service.getDestinasi(
    search: argument['search'] ?? '',
    kabKota: argument['kabKota'] ?? '',
  );
});