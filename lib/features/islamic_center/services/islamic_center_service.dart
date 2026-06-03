import 'dart:convert';

import '../../../core/api/api_service.dart';
import '../presentation/pages/islamic_center_main_page.dart';

class IslamicCenterService {

  // =========================
  // FACILITIES
  // =========================

  Future<List<FacilityModel>> getFacilities() async {
    final res = await ApiService.get('/facilities');

    final List data =
    jsonDecode(res.body)['data'];

    return data
        .map((e) => FacilityModel.fromJson(e))
        .toList();
  }

  Future<Map<String, dynamic>> getFacilityDetail(int id) async {
    final res = await ApiService.get('/facilities/$id');

    return jsonDecode(res.body)['data'];
  }

  // =========================
  // REVIEWS
  // =========================

  Future<List<dynamic>> getFacilityReviews(
      int facilityId,
      ) async {
    final res = await ApiService.get(
      '/facilities/$facilityId/reviews',
    );

    return jsonDecode(res.body)['data'];
  }

  Future<Map<String, dynamic>> submitReview({
    required int facilityId,
    required int rating,
    required String review,
  }) async {
    final res = await ApiService.post(
      '/facilities/$facilityId/reviews',
      {
        'rating': rating,
        'review': review,
      },
    );


    return jsonDecode(res.body);
  }


  Future<Map<String, dynamic>> getRoomDetail(
      int roomId,
      ) async {
    final res = await ApiService.get(
      '/rooms/$roomId',
    );

    return jsonDecode(res.body);
  }

  // =========================
  // BOOKINGS
  // =========================

  Future<Map<String, dynamic>> createBooking(
      Map<String, dynamic> data,
      ) async {
    final res = await ApiService.post(
      '/bookings',
      data,
    );

    return jsonDecode(res.body);
  }



}