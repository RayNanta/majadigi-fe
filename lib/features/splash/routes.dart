import 'package:go_router/go_router.dart';

import '../../app/router/route_names.dart';
import 'presentation/pages/splash_page.dart';

final class SplashRoutes {
  SplashRoutes._();

  static const path = '/splash';

  static final routes = <RouteBase>[
    GoRoute(
      path: path,
      name: RouteNames.splash,
      builder: (context, state) => const SplashPage(),
    ),
  ];
}
