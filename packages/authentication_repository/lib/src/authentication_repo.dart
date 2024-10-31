import 'package:authentication_repository/authentication_repository.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IAuthenticationRepository {
  Future<Result<String, Failure>> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  });

  // outra classe? single responsability
  Future verifyPhone({required String phoneNumber});

  Future<void> logOut();

  Future<Result<AuthUserModel, Failure>> signIn({
    required String email,
    required String password,
  });
}
