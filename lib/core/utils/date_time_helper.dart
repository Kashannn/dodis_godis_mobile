class DateTimeHelper {
  static const List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static String formatDate(DateTime dt) {
    final day = dt.day;
    final month = _months[dt.month - 1];
    final year = dt.year;
    return '$day $month $year';
  }

  static String formatTime(DateTime dt) {
    final hour = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  static String formatDateTime(DateTime dt) {
    return '${formatDate(dt)} ${formatTime(dt)}';
  }
}
