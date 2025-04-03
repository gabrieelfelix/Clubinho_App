import 'package:formz/formz.dart';

/// Validation errors for the [ConfirmedPassword] [FormzInput].
enum ConfirmedPasswordValidationError {
  /// Generic invalid error.
  invalid,
  empty,
}

/// {@template confirmed_password}
/// Form input for a confirmed password input.
/// {@endtemplate}
class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  /// {@macro confirmed_password}
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');

  /// {@macro confirmed_password}
  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  /// The original password.
  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return ConfirmedPasswordValidationError.empty;
    }
    if (password.isEmpty || value.trim() != password.trim()) {
      return ConfirmedPasswordValidationError.invalid;
    }

    return null;
  }
}

extension ConfirmedPasswordValidationErrorExtension
    on ConfirmedPasswordValidationError {
  String text() {
    switch (this) {
      case ConfirmedPasswordValidationError.invalid:
        return 'Senhas diferentes';
      case ConfirmedPasswordValidationError.empty:
        return 'Repita a senha novamente';
    }
  }
}
