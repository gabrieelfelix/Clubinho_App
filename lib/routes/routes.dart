import 'package:club_app/pages/detail_page/detail_page.dart';
import 'package:club_app/pages/manage_club_page/view/manage_club_page.dart';
import 'package:club_app/pages/child_registration_page/view/child_registration_page.dart';
import 'package:club_app/utils/helpers.dart';
import 'package:club_repository/club_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:club_app/pages/home_page/view/home_page.dart';
import 'package:club_app/pages/manage_users_page/view/manage_users_page.dart';
import 'package:club_app/pages/sign_in_page/view/sign_in_page.dart';
import 'package:club_app/pages/sign_up_page/view/sign_up_page.dart';
import 'package:club_app/pages/verification_code_page/verification_code_page.dart';

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

  static const String manageUsers = '/manage_Users';

  static const String manageChildren = '/manage_children';

  static const String childRegistration = '/child_registration';

  static const String userInformation = '/user_information';

  static const String childInformation = '/child_information';

  static const String codeVerification = '/code_verification';

  //final AuthenticationBloc authBloc;

//  AppRouter({required this.authBloc});

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: AppRouter.signInScreen,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: AppRouter.signUpScreen,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: AppRouter.homeScreen,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRouter.manageClub,
        builder: (context, state) => Helpers.openPage<String>(
          context,
          state,
          (club) => ManageClubPage(id: club),
        ),
      ),
      GoRoute(
        path: AppRouter.manageUsers,
        builder: (context, state) => Helpers.openPage<String>(
          context,
          state,
          (club) => ManageUsersPage.teachers(id: club),
        ),
      ),
      GoRoute(
        path: AppRouter.manageChildren,
        builder: (context, state) => Helpers.openPage<String>(
          context,
          state,
          (club) => ManageUsersPage.children(id: club),
        ),
      ),
      GoRoute(
        path: AppRouter.childRegistration,
        builder: (context, state) => Helpers.openPage<String>(
          context,
          state,
          (club) => ChildRegistrationPage(id: club),
        ),
      ),
      GoRoute(
        path: AppRouter.userInformation,
        builder: (context, state) => Helpers.openPage<TeachersModel>(
          context,
          state,
          (user) => DetailPage.teacher(teachersModel: user),
        ),
      ),
      GoRoute(
        path: AppRouter.childInformation,
        builder: (context, state) => Helpers.openPage<KidsModel>(
          context,
          state,
          (user) => DetailPage.kids(childModel: user),
        ),
      ),
      GoRoute(
        path: AppRouter.codeVerification,
        builder: (context, state) => const VerificationCode(),
      ),
    ],
    // refreshListenable: StreamToListenable([authBloc.stream]),
    // redirect: (context, state) {
    //   final isAuthenticated = authBloc.state is SignInSuccess;
    //   log("Redirecionamento chamado com estado: ${authBloc.state}");
    //   if (isAuthenticated) {
    //     return AppRouter.homeScreen;
    //   }

    //   if (authBloc.state is LogOut) {
    //     return AppRouter.signInScreen;
    //   }

    //   return null;
    // },
  );
}
