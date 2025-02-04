// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Helpers {
  // args between pages
  static Widget openPage<T>(
      BuildContext context, GoRouterState state, Widget Function(T) onPage) {
    final args = state.extra as T;
    return onPage(args);
  }

  // each word start with capital letter
  static String capitalizeEachWord(String text) {
    return text
        .split(' ')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');
  }
}
