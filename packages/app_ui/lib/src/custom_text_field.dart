import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.textEditingController,
    required this.textInputAction,
    this.maxLines,
    this.onSubmitted,
    this.onEditingComplete,
    this.validator,
  })  : autofillHints = null,
        keyboardType = TextInputType.text,
        suffixIcon = null,
        enableSuggestions = null,
        autocorrect = null,
        obscure = null;

  CustomTextField.password({
    super.key,
    required this.hint,
    required this.suffixIcon,
    this.obscure,
    required this.textEditingController,
    required this.textInputAction,
    this.validator,
    this.onSubmitted,
    this.onEditingComplete,
  })  : maxLines = 1,
        enableSuggestions = false,
        autocorrect = false,
        keyboardType = TextInputType.visiblePassword,
        autofillHints = [AutofillHints.password];

  const CustomTextField.suffixIcon({
    super.key,
    required this.hint,
    required this.suffixIcon,
    required this.textEditingController,
    required this.textInputAction,
    this.onEditingComplete,
    this.onSubmitted,
    this.keyboardType,
    this.autofillHints,
    this.validator,
  })  : maxLines = 1,
        enableSuggestions = false,
        obscure = false,
        autocorrect = true;

  CustomTextField.email({
    super.key,
    required this.hint,
    required this.textEditingController,
    required this.textInputAction,
    this.onSubmitted,
    this.validator,
    this.onEditingComplete,
  })  : maxLines = 1,
        obscure = false,
        enableSuggestions = false,
        keyboardType = TextInputType.emailAddress,
        autofillHints = [AutofillHints.email],
        autocorrect = null,
        suffixIcon = null;

  const CustomTextField.box({
    super.key,
    required this.hint,
    required int max,
    this.onSubmitted,
    this.onEditingComplete,
    required this.textEditingController,
    this.validator,
  })  : maxLines = max,
        autofillHints = null,
        keyboardType = TextInputType.text,
        textInputAction = TextInputAction.done,
        obscure = false,
        suffixIcon = null,
        enableSuggestions = null,
        autocorrect = null;

  final String hint;

  final int? maxLines;

  final Widget? suffixIcon;

  final TextInputAction? textInputAction;

  final Iterable<String>? autofillHints;

  final TextInputType? keyboardType;

  final bool? enableSuggestions;

  final bool? autocorrect;

  final Function(String)? onSubmitted;

  final Function()? onEditingComplete;

  final String? Function(String?)? validator;

  final bool? obscure;

  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      obscureText: obscure ?? false,
      controller: textEditingController,
      onEditingComplete: onEditingComplete, //
      onFieldSubmitted: onSubmitted, //
      textInputAction: textInputAction, //
      autofillHints: autofillHints, //
      keyboardType: keyboardType, //
      enableSuggestions: enableSuggestions ?? true, //
      validator: validator,
      autocorrect: autocorrect ?? true,
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

        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.red.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.red.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
