import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/routes.dart';
import '../../features/home/routes.dart';
import '../../features/splash/routes.dart';
import '../../features/welcome/routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: SplashRoutes.path,
    routes: [
      ...SplashRoutes.routes,
      ...AuthRoutes.routes,
      ...WelcomeRoutes.routes,
      ...HomeRoutes.routes,
    ],
  );
});
