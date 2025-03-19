import 'package:club_app/pages/attendance_page/view/attendance_page.dart';
import 'package:club_app/pages/attendance_page/view/take_attendance_page.dart';
import 'package:club_app/pages/detail_page/detail_page.dart';
import 'package:club_app/pages/manage_club_page/view/manage_club_page.dart';
import 'package:club_app/pages/child_registration_page/view/child_registration_page.dart';
import 'package:club_app/pages/users_manage/view/users_manage_page.dart';
import 'package:club_app/utils/helpers.dart';
import 'package:club_repository/club_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:club_app/pages/home_page/view/home_page.dart';
import 'package:club_app/pages/manage_member_page/view/manage_member_page.dart';
import 'package:club_app/pages/sign_in_page/view/sign_in_page.dart';
import 'package:club_app/pages/sign_up_page/view/sign_up_page.dart';
import 'package:club_app/pages/verification_code_page/verification_code_page.dart';

class AppRouter {
  static const String signInScreen = '/';

  static const String signUpScreen = '/sign_up';

  static const String homeScreen = '/home';

  static const String manageClub = '/manage_club';

  static const String manageMembers = '/manage_Users';

  static const String manageChildren = '/manage_children';

  static const String childRegistration = '/child_registration';

  static const String userInformation = '/user_information';

  static const String childInformation = '/child_information';

  static const String attendanceChild = '/child_attendance';

  static const String takeAttendance = '/take_attendance';

  static const String codeVerification = '/code_verification';

  static const String usersManage = '/users_manage';

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
        path: AppRouter.manageMembers,
        builder: (context, state) => Helpers.openPage<String>(
          context,
          state,
          (club) => ManageMemberPage.teachers(id: club),
        ),
      ),
      GoRoute(
        path: AppRouter.manageChildren,
        builder: (context, state) => Helpers.openPage<String>(
          context,
          state,
          (club) => ManageMemberPage.children(id: club),
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
      GoRoute(
        path: AppRouter.attendanceChild,
        builder: (context, state) => Helpers.openPage<String>(
          context,
          state,
          (club) => AttendancePage(id: club),
        ),
      ),
      GoRoute(
        path: AppRouter.takeAttendance,
        builder: (context, state) => Helpers.openPage<String>(
          context,
          state,
          (clubId) => TakeAttendancePage(id: clubId),
        ),
      ),
      GoRoute(
        path: AppRouter.usersManage,
        builder: (context, state) => Helpers.openPage<String>(
          context,
          state,
          (clubId) => const UsersManagePage(),
        ),
      ),
    ],
  );
}
