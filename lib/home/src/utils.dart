import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:timezone/timezone.dart' as tz;

/// Class of helper methods.
abstract class Utils {
  /// Computes height of a text based on `style`.
  static double computeTextHeight(TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.height;
  }

  /// Checks whether its daytime in the city.
  ///
  /// The daytime is between sunrise and sunset. Otherwise it is nighttime.
  static bool isNowDay(
    DateTime sunrise,
    DateTime sunset,
    tz.Location timeZone,
  ) {
    return isDay(sunrise, sunset, tz.TZDateTime.now(timeZone));
  }

  @visibleForTesting
  static bool isDay(DateTime sunrise, DateTime sunset, DateTime now) {
    final nowMinutes = _getMinutes(now);
    final sunriseMinutes = _getMinutes(sunrise);
    final sunsetMinutes = _getMinutes(sunset);

    return nowMinutes > sunriseMinutes && nowMinutes < sunsetMinutes;
  }

  static int _getMinutes(DateTime dateTime) {
    return dateTime.hour * 60 + dateTime.minute;
  }
}
