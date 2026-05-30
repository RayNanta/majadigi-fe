import 'dart:convert';
import '../../../core/api/api_service.dart';

class TbcService {
  Future<List<dynamic>> getQuestions() async {
    final res = await ApiService.get('/kesehatan/tbc/questions');
    return jsonDecode(res.body)['data'];
  }

  Future<List<dynamic>> getSymptoms() async {
    final res = await ApiService.get('/kesehatan/tbc/symptoms');
    return jsonDecode(res.body)['data'];
  }

  Future<Map<String, dynamic>> submitScreening(Map data) async {
    final res =
    await ApiService.post('/kesehatan/tbc/screening', data);

    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> getUser() async {
    final res = await ApiService.get('/auth/me');
    return jsonDecode(res.body);
  }
}