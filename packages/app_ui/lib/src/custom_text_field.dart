import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hint})
      : maxLines = null,
        suffixIcon = null;

  const CustomTextField.suffixIcon(
      {super.key, required this.hint, required this.suffixIcon})
      : maxLines = null;

  const CustomTextField.box({super.key, required this.hint, required int max})
      : maxLines = max,
        suffixIcon = null;

  final String hint;

  final int? maxLines;

  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: context.colors.surface.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
