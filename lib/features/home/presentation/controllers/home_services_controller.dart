import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/home_service_catalog.dart';
import '../models/home_service_item.dart';

final homeSelectedServiceIdsProvider =
    NotifierProvider<HomeSelectedServicesController, Set<String>>(
      HomeSelectedServicesController.new,
    );

final homeSelectedServicesProvider = Provider<List<HomeServiceItem>>((ref) {
  final selectedIds = ref.watch(homeSelectedServiceIdsProvider);
  return selectedServicesFrom(selectedIds);
});

final homeRecommendedServicesProvider = Provider<List<HomeServiceItem>>((ref) {
  return recommendedHomeServices;
});

class HomeSelectedServicesController extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    return {...initialAddedHomeServiceIds};
  }

  void addService(String id) {
    if (state.contains(id)) {
      return;
    }

    state = {...state, id};
  }
}
