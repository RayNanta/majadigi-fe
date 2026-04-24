import 'package:go_router/go_router.dart';

import '../../app/router/route_names.dart';
import 'presentation/pages/sign_in_page.dart';
import 'presentation/pages/sign_up_step_one_page.dart';
import 'presentation/pages/sign_up_step_two_page.dart';
import 'presentation/pages/sign_up_step_three_page.dart';

final class AuthRoutes {
  AuthRoutes._();

  static const signInPath = '/sign-in';
  static const signUpStepOnePath = '/sign-up/step-1';
  static const signUpStepTwoPath = '/sign-up/step-2';
  static const signUpStepThreePath = '/sign-up/step-3';

  static final routes = <RouteBase>[
    GoRoute(
      path: signInPath,
      name: RouteNames.signIn,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: signUpStepOnePath,
      name: RouteNames.signUpStepOne,
      builder: (context, state) => const SignUpStepOnePage(),
    ),
    GoRoute(
      path: signUpStepTwoPath,
      name: RouteNames.signUpStepTwo,
      builder: (context, state) => const SignUpStepTwoPage(),
    ),
    GoRoute(
      path: signUpStepThreePath,
      name: RouteNames.signUpStepThree,
      builder: (context, state) => const SignUpStepThreePage(),
    ),
  ];
}
