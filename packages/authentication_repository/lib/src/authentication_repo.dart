abstract class IAuthenticationRepository {
  Future signUp();

  // outra classe? single responsability
  Future sendSms();

  Future validationSms();
}
