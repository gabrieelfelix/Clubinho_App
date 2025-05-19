import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SnackBarType {
  error,
  success,
}

void showCustomSnackBar(
  BuildContext context,
  String message, {
  required SnackBarType type,
  Duration duration = const Duration(seconds: 3),
  SnackBarAction? action,
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  final Color backgroundColor;
  final IconData icon;

  switch (type) {
    case SnackBarType.success:
      backgroundColor = colorScheme.primary;
      icon = Icons.check_circle_outline;
      break;
    case SnackBarType.error:
      backgroundColor = colorScheme.error;
      icon = Icons.error_outline;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      closeIconColor: colorScheme.onPrimary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.sp),
      ),
      content: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: Icon(icon, color: colorScheme.onPrimary),
          ),
          Flexible(
            child: Text(
              message,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
      duration: duration,
      backgroundColor: backgroundColor,
      action: action,
    ),
  );
}
