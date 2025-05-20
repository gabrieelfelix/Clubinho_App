import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskFormatter {
  static var phoneMaskFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static var noDoubleSpaceFormatter = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      final newText = newValue.text;
      final cleanedText = newText.replaceAll(RegExp(r' {2,}'), ' ');

      if (newText == cleanedText) return newValue;

      return TextEditingValue(
        text: cleanedText,
        selection: TextSelection.collapsed(offset: cleanedText.length),
      );
    },
  );
}
