import 'package:intl/intl.dart';

class DateHelper {
  static String dateToUiString(DateTime? dateTime, [String? locale]) {
    if (dateTime == null) return '';
    return DateFormat('dd/MM/yyyy', locale).format(dateTime);
  }
}
