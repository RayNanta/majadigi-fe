import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/routes.dart';
import '../../features/splash/routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: SplashRoutes.path,
    routes: [...SplashRoutes.routes, ...HomeRoutes.routes],
  );
});
