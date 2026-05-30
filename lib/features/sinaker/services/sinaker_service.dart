import 'dart:convert';
import 'package:majadigi_mobile/features/sinaker/presentation/pages/sinaker_training_list_page.dart';
import 'package:majadigi_mobile/features/sinaker/presentation/pages/sinaker_training_registration_check_page.dart';
import 'package:majadigi_mobile/features/sinaker/presentation/pages/sinaker_training_registration_list.dart';
import '../../../core/api/api_service.dart';

class SinakerService {


  Future<List<Map<String, dynamic>>> getTrainingCenter() async {
    final res = await ApiService.get('/ketenagakerjaan/training-centers');

    final List data = jsonDecode(res.body)['data'];

    return data.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<Map<String, dynamic>> getTrainingCenterDetail(int id) async {
    final res = await ApiService.get('/ketenagakerjaan/training-centers/$id');
    return jsonDecode(res.body)['data'];
  }
  // =========================
  // TRAININGS
  // =========================
  Future<List<Training>> getTrainings() async {
    final res = await ApiService.get('/ketenagakerjaan/trainings');

    final List data = jsonDecode(res.body)['data'];

    return data.map((e) => Training.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getTrainingDetail(int id) async {
    final res = await ApiService.get('/ketenagakerjaan/trainings/$id');
    return jsonDecode(res.body);
  }

  // =========================
  // JOBS
  // =========================
  Future<List<dynamic>> getJobs() async {
    final res = await ApiService.get('/ketenagakerjaan/jobs');
    return jsonDecode(res.body)['data'];
  }

  Future<Map<String, dynamic>> getJobDetail(int id) async {
    final res = await ApiService.get('/ketenagakerjaan/jobs/$id');
    return jsonDecode(res.body);
  }

  // =========================
  // APPLY JOB
  // =========================
  Future<Map<String, dynamic>> applyJob(Map data) async {
    final res = await ApiService.post('/ketenagakerjaan/apply', data);
    return jsonDecode(res.body);
  }

  Future<List<dynamic>> myApplications() async {
    final res = await ApiService.get('/ketenagakerjaan/my-applications');
    return jsonDecode(res.body)['data'];
  }

  Future<Map<String, dynamic>> joinTraining(Map data) async {
    final res =
    await ApiService.post('/ketenagakerjaan/join-training', data);
    return jsonDecode(res.body);
  }

  Future<List<MyTraining>> getMyTrainings() async {
    final res = await ApiService.get(
      '/ketenagakerjaan/my-trainings',
    );

    final body = jsonDecode(res.body);

    return (body['data'] as List)
        .map((e) => MyTraining.fromJson(e))
        .toList();
  }

  Future<TrainingRegistrationDetail> getTrainingRegistrationDetail(int id) async {
    final res = await ApiService.get(
      '/ketenagakerjaan/my-trainings/$id',
    );

    final body = jsonDecode(res.body);

    return TrainingRegistrationDetail.fromJson(
      body['data'],
    );
  }
}