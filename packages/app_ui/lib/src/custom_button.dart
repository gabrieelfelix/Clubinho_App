// ignore_for_file: deprecated_member_use

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
  }) : isPop = false;
  const CustomButton.pop({
    super.key,
    required this.label,
    required this.height,
    this.onPressed,
    required this.isLoading,
  }) : isPop = true;

  final String label;

  final double height;

  final bool isLoading;

  final bool isPop;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 245.h,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: isPop ? 0 : null,
          backgroundColor:
              isPop ? context.colors.onPrimary : context.colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: isPop
                ? BorderSide(
                    color: context.colors.surface.withOpacity(1),
                    width: 2.w,
                  )
                : BorderSide.none,
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
                  color:
                      isPop ? context.colors.surface : context.colors.onPrimary,
                  fontSize: 13.sp,
                ),
              ),
      ),
    );
  }
}
