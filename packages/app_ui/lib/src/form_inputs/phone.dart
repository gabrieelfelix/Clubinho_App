import 'package:formz/formz.dart';

enum PhoneValidationError {
  empty,
  invalid,
}

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');

  const Phone.dirty([super.value = '']) : super.dirty();

  @override
  PhoneValidationError? validator(String value) {
    final cleaned = value.replaceAll(RegExp(r'\D'), '');
    if (cleaned.isEmpty) {
      return PhoneValidationError.empty;
    }

    if (cleaned.length != 11) {
      return PhoneValidationError.invalid;
    }

    if (!cleaned.startsWith(RegExp(r'^\d{2}9'))) {
      return PhoneValidationError.invalid;
    }

    return null;
  }
}

extension PhoneValidationErrorExtension on PhoneValidationError {
  String text() {
    switch (this) {
      case PhoneValidationError.invalid:
        return 'Telefone inválido';
      case PhoneValidationError.empty:
        return 'Digite um Telefone';
    }
  }
}
