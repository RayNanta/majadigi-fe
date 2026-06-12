import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers/core_providers.dart';
import '../../features/auth/routes.dart';
import '../../features/home/routes.dart';
import '../../features/splash/routes.dart';
import '../../features/welcome/routes.dart';
import '../../features/splash/routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);

  return GoRouter(
    initialLocation: SplashRoutes.path,
    redirect: (context, state) {
      final location = state.uri.path;
      final hasSession = sharedPreferencesService.authToken != null;

      final isSplashRoute = location == SplashRoutes.path;
      final isWelcomeRoute = location == WelcomeRoutes.path;
      final isAuthRoute =
          location == AuthRoutes.signInPath ||
          location == AuthRoutes.signUpStepOnePath ||
          location == AuthRoutes.signUpStepTwoPath ||
          location == AuthRoutes.signUpStepThreePath;
      final isPublicRoute = isSplashRoute || isWelcomeRoute || isAuthRoute;

      if (!hasSession && !isPublicRoute) {
        return AuthRoutes.signInPath;
      }

      if (hasSession && (isWelcomeRoute || isAuthRoute)) {
        return HomeRoutes.path;
      }

      return null;
    },
    routes: [
      ...SplashRoutes.routes,
      ...AuthRoutes.routes,
      ...WelcomeRoutes.routes,
      ...HomeRoutes.routes,
    ],
  );
});
