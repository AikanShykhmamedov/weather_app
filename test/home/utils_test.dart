import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/home/src/utils.dart';

void main() {
  group('isDay', () {
    final sunrise = Time(hours: 6, minutes: 15);
    final sunset = Time(hours: 20, minutes: 45);

    void testFor(DateTime now, bool matcher) {
      final isDay = Utils.isDay(sunrise, sunset, now);
      expect(isDay, matcher);
    }

    test('4:00', () => testFor(Time(hours: 4, minutes: 0), false));
    test('12:00', () => testFor(Time(hours: 12, minutes: 0), true));
    test('22:00', () => testFor(Time(hours: 22, minutes: 0), false));
  });
}

class Time extends DateTime {
  Time({
    required int hours,
    required int minutes,
  })  : assert(hours >= 0 && hours < 24),
        assert(minutes >= 0 && minutes < 60),
        super.fromMillisecondsSinceEpoch(
          hours * millisecondsInHour + minutes * millisecondsInMinute,
          isUtc: true,
        );

  static const millisecondsInMinute = 60 * 1000;
  static const millisecondsInHour = 60 * millisecondsInMinute;
}
