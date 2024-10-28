import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.textLabel,
    required this.height,
    this.onPressed,
  });

  final String textLabel;

  final double height;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 1,
          ),
        ),
        child: Text(
          textLabel,
          style: TextStyle(
            color: context.colors.onPrimary,
          ),
        ),
      ),
    );
  }
}
