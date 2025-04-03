import 'package:formz/formz.dart';

/// Validation errors for the [FullName] [FormzInput].
enum FullNameValidationError {
  /// Generic invalid error.
  invalid,
  empty,
  singleWord,
}

/// {@template FullName}
/// Form input for an FullName input.
/// {@endtemplate}
class FullName extends FormzInput<String, FullNameValidationError> {
  /// {@macro FullName}
  const FullName.pure() : super.pure('');

  /// {@macro FullName}
  const FullName.dirty([super.value = '']) : super.dirty();

  static final RegExp _fullNameRegExp = RegExp(
    r'^[A-Za-zÀ-Ÿà-ÿ]+(\s+[A-Za-zÀ-Ÿà-ÿ]+)+$',
  );

  @override
  FullNameValidationError? validator(String value) {
    final words = value.trim().split(RegExp(r'\s+'));
    if (value.isEmpty) {
      return FullNameValidationError.empty;
    } else if (!_fullNameRegExp.hasMatch(value.trim())) {
      return FullNameValidationError.invalid;
    } else if (words.length < 2) {
      return FullNameValidationError.singleWord;
    }

    return null;
  }
}

extension FullNameValidationErrorExtension on FullNameValidationError {
  String text() {
    switch (this) {
      case FullNameValidationError.invalid:
        return 'Nome Completo Inválido';
      case FullNameValidationError.empty:
        return 'Digite um nome Completo';
      case FullNameValidationError.singleWord:
        return 'Digite um nome Completo';
    }
  }
}
