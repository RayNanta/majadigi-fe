import 'package:go_router/go_router.dart';

import '../../app/router/route_names.dart';
import 'presentation/pages/sign_in_page.dart';

final class AuthRoutes {
  AuthRoutes._();

  static const signInPath = '/sign-in';

  static final routes = <RouteBase>[
    GoRoute(
      path: signInPath,
      name: RouteNames.signIn,
      builder: (context, state) => const SignInPage(),
    ),
  ];
}
