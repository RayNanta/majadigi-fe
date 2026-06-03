import 'dart:convert';

import '../../../core/api/api_service.dart';

class RsudService {
  Future<List<dynamic>> getHospitals() async {
    final response = await ApiService.get('/hospitals');

    final data = jsonDecode(response.body);

    return data['data'] ?? [];
  }

  Future<List<dynamic>> getRooms(int hospitalId) async {
    final response = await ApiService.get(
      '/hospitals/$hospitalId/rooms',
    );

    final data = jsonDecode(response.body);

    return data['data'] ?? [];
  }

  Future<Map<String,dynamic>> getRoomAvailability({
    required int hospitalId,
    int? roomTypeId,
  }) async {
    String endpoint =
        '/rooms/availability?hospital_id=$hospitalId';

    if (roomTypeId != null) {
      endpoint += '&room_type_id=$roomTypeId';
    }

    final response = await ApiService.get(endpoint);

    final data = jsonDecode(response.body);

    return data['data'] ?? [];
  }



  Future<Map<String, dynamic>> getAvailability() async {
    final response = await ApiService.get(
      '/rsud/availability',
    );

    return jsonDecode(response.body);
  }


}