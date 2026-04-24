import 'package:go_router/go_router.dart';

import '../../app/router/route_names.dart';
import 'presentation/pages/home_page.dart';

final class HomeRoutes {
  HomeRoutes._();

  static const path = '/';

  static final routes = <RouteBase>[
    GoRoute(
      path: path,
      name: RouteNames.home,
      builder: (context, state) => const HomePage(),
    ),
  ];
}
