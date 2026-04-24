import 'package:go_router/go_router.dart';

import '../../app/router/route_names.dart';
import 'presentation/pages/welcome_page.dart';

final class WelcomeRoutes {
  WelcomeRoutes._();

  static const path = '/welcome';

  static final routes = <RouteBase>[
    GoRoute(
      path: path,
      name: RouteNames.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
  ];
}
