import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/app/app.dart';
import 'package:club_app/app/simple_bloc_observer.dart';
import 'package:club_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupDependences();
  runApp(MyApp());
}

final getIt = GetIt.instance;

/// Create singletons (logic and services) that can be shared across the app.
Future<void> setupDependences() async {
  // Register service authentication
  getIt.registerLazySingleton<IAuthenticationRepository>(
      () => FirebaseAuthRepository());
}
