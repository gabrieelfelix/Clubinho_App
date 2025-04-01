import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.obscure,
    this.textEditingController,
  })  : maxLines = 1,
        suffixIcon = null;

  const CustomTextField.suffixIcon({
    super.key,
    required this.hint,
    required this.suffixIcon,
    this.obscure,
    this.textEditingController,
  }) : maxLines = 1;

  const CustomTextField.box({
    super.key,
    required this.hint,
    this.obscure,
    required int max,
    this.textEditingController,
  })  : maxLines = max,
        suffixIcon = null;

  final String hint;

  final int? maxLines;

  final Widget? suffixIcon;

  final bool? obscure;

  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      obscureText: obscure ?? false,
      controller: textEditingController,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        // hintText: hint,

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: hint,
        labelStyle: TextStyle(color: Colors.grey.shade500),
        floatingLabelStyle: TextStyle(
          // tá certo?
          color: GlobalThemeData.lightColorScheme.primary,
        ),
      ),
    );
  }
}
