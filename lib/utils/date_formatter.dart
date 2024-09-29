import 'package:intl/intl.dart';

class DateFormatter {
  /// Parses date into MM DD,YYYY
  static DateFormat get monthDateYear =>
      DateFormat.yMMMd(Intl.getCurrentLocale());
}
