import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.height,
    this.onPressed,
    required this.isLoading,
  });

  final String label;

  final double height;

  final bool isLoading;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 245.h,
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
        child: isLoading
            ? LoadingAnimationWidget.waveDots(
                color: context.colors.onPrimary,
                size: 23.sp,
              )
            : Text(
                label,
                style: TextStyle(
                  color: context.colors.onPrimary,
                  fontSize: 13.sp,
                ),
              ),
      ),
    );
  }
}
