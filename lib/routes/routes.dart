import 'package:club_app/pages/child_registration_page/child_registration_page.dart';
import 'package:club_app/pages/home_page/home_page.dart';
import 'package:club_app/pages/manage_children_page/manage_children_page.dart';
import 'package:club_app/pages/manage_club_page/manage_club_page.dart';
import 'package:club_app/pages/sign_in_page/sign_in_page.dart';
import 'package:club_app/pages/sign_up_page/sign_up_page.dart';
import 'package:club_app/pages/verification_code_page/verification_code_page.dart';
import 'package:go_router/go_router.dart';

// extension AppRouterContext on BuildContext {
//   // Direct navigation to a specific route
//   void goTo(String route) => GoRouter.of(this).go(route);

//   // Push navigation to a specific route
//   void pushTo(String route) => GoRouter.of(this).push(route);
// }

class AppRouter {
  static const String signInScreen = '/';

  static const String signUpScreen = '/sign_up';

  static const String homeScreen = '/home';

  static const String manageClub = '/manage_club';

  static const String manageChildren = '/manage_children';

  static const String childRegistration = '/child_registration';

  static const String codeVerification = '/code_verification';

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: signInScreen,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: signUpScreen,
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: manageClub,
        builder: (context, state) => const ManageClub(),
      ),
      GoRoute(
        path: manageChildren,
        builder: (context, state) => const ManageChildren(),
      ),
      GoRoute(
        path: childRegistration,
        builder: (context, state) => const ChildRegistration(),
      ),
      GoRoute(
        path: codeVerification,
        builder: (context, state) => const VerificationCode(),
      ),
    ],
  );
}
