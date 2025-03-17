class Helpers {
  static String getCurrentDateWithoutIntl() {
    final now = DateTime.now();

    String day = now.day.toString().padLeft(2, '0');
    String month = now.month.toString().padLeft(2, '0');

    String year = now.year.toString().substring(2);

    return '$day-$month-$year';
  }
}
