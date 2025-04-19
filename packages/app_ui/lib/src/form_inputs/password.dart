import 'package:formz/formz.dart';

/// Validation errors for the [Password] [FormzInput].
enum PasswordValidationError {
  /// Generic invalid error.
  invalid,
  empty,
  withSpace,
}

/// {@template password}
/// Form input for an password input.
/// {@endtemplate}
class Password extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const Password.pure() : super.pure('');

  /// {@macro password}
  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z]).{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.contains(' ')) {
      return PasswordValidationError.withSpace;
    } else if (!_passwordRegex.hasMatch(value.trim())) {
      return PasswordValidationError.invalid;
    }

    return null;
  }
}

extension PasswordValidationErrorExtension on PasswordValidationError {
  String text() {
    switch (this) {
      case PasswordValidationError.invalid:
        return 'Senha inválida';
      case PasswordValidationError.empty:
        return 'Digite uma senha';
      case PasswordValidationError.withSpace:
        return 'A senha não pode conter espaços';
    }
  }
}
