import 'package:demo_app/utils/date_formatter.dart';
import 'package:test/test.dart';

void main() {
  group('Utils test', () {
    test('Date formatter', () {
      const date = '1995-10-06';

      final formattedDate =
          DateFormatter.monthDateYear.format(DateTime.parse(date));

      expect(formattedDate, 'Oct 6, 1995');
    });
  });
}
