import 'package:authentication_repository/src/failure/failure.dart';
import 'package:authentication_repository/src/models/auth_user_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IAuthenticationRepository {
  Future<Result<AuthUserModel, Failure>> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  });

  // outra classe? single responsability
  Future verifyPhone({required String phoneNumber});

  Future validationSms();
}
