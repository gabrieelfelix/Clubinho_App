import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.autofillHints,
    this.onChanged,
    this.error,
    this.inputFormatters,
  })  : keyboardType = TextInputType.text,
        suffixIcon = null,
        enableSuggestions = true,
        isPhone = false,
        autocorrect = false,
        obscure = null,
        autofillHintsBool = null;
  // validatorPhone = null;

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
    this.onChanged,
    this.error,
    this.inputFormatters,
  })  : maxLines = 1,
        enableSuggestions = false,
        isPhone = false,
        autocorrect = false,
        keyboardType = TextInputType.visiblePassword,
        autofillHints = [AutofillHints.password],
        autofillHintsBool = null;
  // validatorPhone = null;

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
    this.onChanged,
    this.error,
    this.inputFormatters,
  })  : maxLines = 1,
        enableSuggestions = false,
        obscure = false,
        isPhone = false,
        autocorrect = true,
        autofillHintsBool = null;
  //  validatorPhone = null;

  const CustomTextField.phone({
    super.key,
    required this.hint,
    required this.suffixIcon,
    required this.textEditingController,
    required this.textInputAction,
    this.onEditingComplete,
    this.onSubmitted,
    this.keyboardType,
    this.autofillHintsBool,
    this.validator,
    this.onChanged,
    this.error,
    this.inputFormatters,
    // this.validatorPhone,
  })  : maxLines = 1,
        enableSuggestions = false,
        obscure = false,
        autocorrect = true,
        isPhone = true,
        autofillHints = null;
  CustomTextField.email({
    super.key,
    required this.hint,
    required this.textEditingController,
    required this.textInputAction,
    this.onSubmitted,
    this.validator,
    this.onEditingComplete,
    this.onChanged,
    this.error,
    this.inputFormatters,
  })  : maxLines = 1,
        obscure = false,
        isPhone = false,
        enableSuggestions = false,
        keyboardType = TextInputType.emailAddress,
        autofillHints = [AutofillHints.email],
        autocorrect = null,
        suffixIcon = null,
        autofillHintsBool = null;
  //  validatorPhone = null;

  const CustomTextField.box({
    super.key,
    required this.hint,
    required int max,
    this.onSubmitted,
    this.onEditingComplete,
    required this.textEditingController,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.error,
  })  : maxLines = max,
        autofillHints = null,
        isPhone = false,
        keyboardType = TextInputType.text,
        textInputAction = TextInputAction.done,
        obscure = false,
        suffixIcon = null,
        enableSuggestions = null,
        autocorrect = null,
        autofillHintsBool = null;
  //  validatorPhone = null;

  final String hint;

  final int? maxLines;

  final Widget? suffixIcon;

  final TextInputAction? textInputAction;

  final Iterable<String>? autofillHints;

  final bool? autofillHintsBool;

  final TextInputType? keyboardType;

  final bool? enableSuggestions;

  final bool? autocorrect;

  final Function(String)? onSubmitted;

  final Function()? onEditingComplete;

  final String? Function(String?)? validator;

  // final FutureOr<String?> Function(PhoneNumber?)? validatorPhone;

  final String? error;

  final bool? obscure;

  final bool isPhone;

  final List<TextInputFormatter>? inputFormatters;

  final Function(String)? onChanged;

  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      obscureText: obscure ?? false,
      controller: textEditingController,
      onChanged: onChanged, //
      inputFormatters: inputFormatters,
      onEditingComplete: onEditingComplete, //
      onFieldSubmitted: onSubmitted, //
      textInputAction: textInputAction, //
      autofillHints: autofillHints, //
      keyboardType: keyboardType, //
      enableSuggestions: enableSuggestions ?? true, //
      validator: validator,
      autocorrect: autocorrect ?? true,
      style: TextStyle(
        color: context.colors.onSecondary,
      ),
      decoration: InputDecoration(
        errorText: error != null ? error : null,
        suffixIcon: suffixIcon,
        // hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: context.colors.onSurfaceVariant,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: context.colors.onSurfaceVariant,
            // color: GlobalThemeData.lightColorScheme.onSurfaceVariant,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: hint,
        labelStyle: TextStyle(color: context.colors.surface),
        floatingLabelStyle: TextStyle(
          color: context.colors.primary,
          // color: GlobalThemeData.lightColorScheme.primary,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: context.colors.error,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: context.colors.error,
            // color: Colors.red.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
