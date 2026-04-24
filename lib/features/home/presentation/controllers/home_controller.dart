import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';

final homeLaunchCountProvider =
    AsyncNotifierProvider<HomeLaunchCountController, int>(
      HomeLaunchCountController.new,
    );

class HomeLaunchCountController extends AsyncNotifier<int> {
  @override
  Future<int> build() async {
    final storage = ref.read(sharedPreferencesServiceProvider);
    final nextCount = storage.launchCount + 1;

    await storage.setLaunchCount(nextCount);
    return nextCount;
  }
}
