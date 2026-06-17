import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/providers/auth_provider.dart'; // Sesuaikan path ini
import '../models/home_service_item.dart';
import '../data/home_service_catalog.dart';

class HomeSelectedServiceIdsNotifier extends StateNotifier<Set<String>> {
  HomeSelectedServiceIdsNotifier(this.userId) : super({}) {
    _loadFromStorage();
  }

  final int? userId;

  String get _storageKey => 'my_services_$userId';

  Future<void> _loadFromStorage() async {
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList(_storageKey);

    if (savedList != null) {
      state = savedList.toSet();
    } else {
      state = {};
    }
  }

  Future<void> addService(String id) async {
    final newState = {...state, id};
    state = newState;

    if (userId != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_storageKey, newState.toList());
    }
  }

  Future<void> removeService(String id) async {
    final newState = Set<String>.from(state)..remove(id);
    state = newState;

    if (userId != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_storageKey, newState.toList());
    }
  }
}

// 2. Daftarkan Provider-nya dan hubungkan dengan AuthProvider agar mendapatkan userId
final homeSelectedServiceIdsProvider =
StateNotifierProvider<HomeSelectedServiceIdsNotifier, Set<String>>((ref) {

  // Pantau siapa user yang sedang login
  final user = ref.watch(authProvider);

  // Kirimkan ID user ke Notifier
  return HomeSelectedServiceIdsNotifier(user?.id);
});

// 3. Provider untuk mengambil objek HomeServiceItem utuh berdasarkan ID yang tersimpan
final homeSelectedServicesProvider = Provider<List<HomeServiceItem>>((ref) {
  final selectedIds = ref.watch(homeSelectedServiceIdsProvider);

  return allCatalogServices
      .where((service) => selectedIds.contains(service.id))
      .toList();
});


final homeRecommendedServicesProvider = Provider<List<HomeServiceItem>>((ref) {


  if (allCatalogServices.isEmpty) return [];

  return allCatalogServices.take(4).toList();
});