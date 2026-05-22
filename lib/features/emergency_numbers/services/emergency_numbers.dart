import 'dart:convert';
import '../../../core/api/api_service.dart';

class EmergencyNumbers {

  Future<List<dynamic>> getNomorDarurat() async {
    final res = await ApiService.get('/darurat/nomor');
    return jsonDecode(res.body)['data'];

  }
}