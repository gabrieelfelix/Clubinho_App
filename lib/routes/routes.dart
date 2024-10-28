import 'package:club_app/pages/child_registration_page/child_registration_page.dart';
import 'package:club_app/pages/home_page/home_page.dart';
import 'package:club_app/pages/login_page/login_page.dart';
import 'package:club_app/pages/manage_children_page/manage_children_page.dart';
import 'package:club_app/pages/manage_club_page/manage_club_page.dart';
import 'package:go_router/go_router.dart';

// extension AppRouterContext on BuildContext {
//   // Direct navigation to a specific route
//   void goTo(String route) => GoRouter.of(this).go(route);

//   // Push navigation to a specific route
//   void pushTo(String route) => GoRouter.of(this).push(route);
// }

class AppRouter {
  static const String loginScreen = '/';

  static const String homeScreen = '/home';

  static const String manageClub = '/manage_club';

  static const String manageChildren = '/manage_children';

  static const String childRegistration = '/child_registration';

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: loginScreen,
        builder: (context, state) => const LoginScreen(),
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
    ],
  );
}
