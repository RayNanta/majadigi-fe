import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class HoaxService {
  static const String _baseUrl = 'http://127.0.0.1:8080/api';
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Host': 'majadigi.test',
  };

  Future<bool> postLaporHoax({
    required String namaPelapor,
    required String deskripsiLaporan,
    required String urlBukti,
  }) async {
    try {
      const urlString = '$_baseUrl/v1/hoax/lapor';

      final response = await http.post(
        Uri.parse(urlString),
        headers: _headers,
        body: json.encode({
          'nama_pelapor': namaPelapor.isEmpty ? 'Anonim' : namaPelapor,
          'deskripsi_laporan': deskripsiLaporan,
          'url_bukti': urlBukti,
        }),
      );

      print('=== DEBUG LAUNCH POST HOAX ===');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Eror Hoax Service POST: $e');
      return false;
    }
  }
  Future<List<dynamic>> fetchLatestHoaxReports() async {
    try {
      const urlString = '$_baseUrl/v1/hoax';
      final response = await http.get(Uri.parse(urlString), headers: _headers);

      // 🟢 DEBUG: Tambahkan ini
      print('DEBUG GET HOAX Status: ${response.statusCode}');
      print('DEBUG GET HOAX Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = json.decode(response.body);
        if (decodedData['success'] == true && decodedData['data'] != null) {
          return decodedData['data'] as List<dynamic>;
        }
      }
      return [];
    } catch (e) {
      print('Eror Hoax Service GET: $e'); // 🟢 Ini akan muncul jika koneksi gagal
      return [];
    }
  }
  Future<Map<String, dynamic>> fetchHoaxSummary() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/v1/hoax/summary'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      }
      return {'berita_hoaks': 0, 'disinformasi': 0, 'fakta': 0, 'hate_speech': 0};
    } catch (e) {
      print("Error fetching summary: $e");
      return {'berita_hoaks': 0, 'disinformasi': 0, 'fakta': 0, 'hate_speech': 0};
    }
  }
  Future<Map<String, dynamic>?> trackHoaxReport(String tiket) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/v1/hoax/track/$tiket'));
      if (response.statusCode == 200) {
        return json.decode(response.body)['data'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}


final hoaxServiceProvider = Provider<HoaxService>((ref) => HoaxService());