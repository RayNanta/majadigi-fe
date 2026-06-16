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

      // 1. KELUARKAN Step 3 dari daftar Auth Route
      final isAuthRoute =
          location == AuthRoutes.signInPath ||
              location == AuthRoutes.signUpStepOnePath ||
              location == AuthRoutes.signUpStepTwoPath;

      // 2. Buat variabel khusus untuk Step 3
      final isStepThreeRoute = location == AuthRoutes.signUpStepThreePath;

      // 3. Tambahkan Step 3 ke daftar Public Route agar tetap bisa diakses
      final isPublicRoute = isSplashRoute || isWelcomeRoute || isAuthRoute || isStepThreeRoute;

      if (!hasSession && !isPublicRoute) {
        return AuthRoutes.signInPath;
      }

      if (hasSession && (isWelcomeRoute || isAuthRoute)) {
        // 4. Jika user sudah login tapi membuka halaman Welcome/SignIn,
        // arahkan mereka ke Step 3 (Pemilihan Layanan) alih-alih langsung ke Home.
        return AuthRoutes.signUpStepThreePath;
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
