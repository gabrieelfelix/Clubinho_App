part of 'sign_up_bloc.dart';

abstract class ISignUpEvent extends Equatable {
  const ISignUpEvent();
  @override
  List<Object> get props => [];
}

final class SignUpRequired extends ISignUpEvent {
  final String email;
  final String username;
  final String password;
  final String phone;

  const SignUpRequired({
    required this.phone,
    required this.email,
    required this.username,
    required this.password,
  });
  @override
  List<Object> get props => [
        email,
        username,
        password,
        phone,
      ];
}

final class ChangeObscureRequired extends ISignUpEvent {
  final bool firstObscure;

  const ChangeObscureRequired({this.firstObscure = false});
  @override
  List<Object> get props => [firstObscure];
}

final class ChangeConfirmPassRequired extends ISignUpEvent {
  final String confirmPassword;
  final String password;

  const ChangeConfirmPassRequired({
    required this.confirmPassword,
    required this.password,
  });
  @override
  List<Object> get props => [confirmPassword, password];
}

// final class ChangePassRequired extends ISignUpEvent {
//   final String password;

//   const ChangePassRequired({
//     required this.password,
//   });
//   @override
//   List<Object> get props => [password];
// }

class ChangePasswordAndConfirmPass extends ISignUpEvent {
  final String password;
  final String confirmPassword;

  const ChangePasswordAndConfirmPass({
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [password, confirmPassword];
}

class ResetSignUpForm extends ISignUpEvent {
  const ResetSignUpForm();

  @override
  List<Object> get props => [];
}
