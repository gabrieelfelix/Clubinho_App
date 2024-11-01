import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/pages/sign_in_page/bloc/authentication_bloc.dart';
import 'package:club_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           AuthenticationBloc(authRepository: FirebaseAuthRepository()),
//       child: const MyApp(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthenticationBloc authBloc = AuthenticationBloc(
      authRepository: GetIt.instance<IAuthenticationRepository>());

  late final AppRouter appRouter = AppRouter(
    authBloc: authBloc,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => authBloc,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: GlobalThemData.lightThemeData,
        routerDelegate: appRouter.router.routerDelegate,
        routeInformationParser: appRouter.router.routeInformationParser,
        routeInformationProvider: appRouter.router.routeInformationProvider,
      ),
    );
  }
}
