import 'package:intl/intl.dart';

class DateConverter {
  static String? convertDateFormat(String? listDate) {
    try {
      if (listDate == null) return null;
      DateTime dateTime = DateTime.parse(listDate);
      DateFormat dateFormat = DateFormat.yMMMd();
      return dateFormat.format(dateTime);
    } catch (_) {
      return null;
    }
  }
}
