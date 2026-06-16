import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/hoax_services.dart';


final hoaxSummaryProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return HoaxService().fetchHoaxSummary();
});

// FutureProvider untuk mengambil list data laporan hoaks riil dari Laravel backend
final hoaxReportsProvider = FutureProvider<List<dynamic>>((ref) async {
  final service = ref.watch(hoaxServiceProvider);

  // Kita buat fungsi HTTP GET pembantu di service rill
  return await service.fetchLatestHoaxReports();
});