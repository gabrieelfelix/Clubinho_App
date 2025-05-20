import 'package:formz/formz.dart';

/// Validation errors for the [Default] [FormzInput].
enum DefaultValidationError {
  /// Generic invalid error.

  empty,
}

/// {@template Default}
/// Form input for an Default input.
/// {@endtemplate}
class Default extends FormzInput<String, DefaultValidationError> {
  /// {@macro Default}
  const Default.pure() : super.pure('');

  /// {@macro Default}
  const Default.dirty([super.value = '']) : super.dirty();

  //static final RegExp noDoubleSpacesRegex = RegExp(r'^(?!.* {2,}).*$');

  @override
  DefaultValidationError? validator(String value) {
    if (value.isEmpty) {
      return DefaultValidationError.empty;
    }

    return null;
  }
}

extension DefaultValidationErrorExtension on DefaultValidationError {
  String text() {
    switch (this) {
      case DefaultValidationError.empty:
        return 'Campo vazio';
    }
  }
}
