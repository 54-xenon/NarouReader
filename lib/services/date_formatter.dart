import 'package:intl/intl.dart';

class DateFormatter {
  static String format(DateTime dt, {String locale = 'ja'}) {
    return DateFormat.yMMMd(locale).format(dt);
  }

  static String formatFromIso(String isoString, {String locale = 'ja'}) {
    return format(DateTime.parse(isoString), locale: locale);
  }
}
