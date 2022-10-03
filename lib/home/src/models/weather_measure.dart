import 'package:intl/intl.dart';

/// Temperature metric system.
enum TemperatureMeasure {
  celsius,
  fahrenheit;

  factory TemperatureMeasure.byName(String? name) {
    return name == null ? celsius : TemperatureMeasure.values.byName(name);
  }

  String toText(int celsius) {
    final int value;
    switch (this) {
      case TemperatureMeasure.celsius:
        value = celsius;
        break;
      case TemperatureMeasure.fahrenheit:
        value = (celsius * 9 / 5 + 32).round();
        break;
    }

    return '$value°';
  }
}

/// Wind speed metric system.
enum WindMeasure {
  /// Kilometers per hour.
  kmPerH,

  /// Meters per second.
  mPerS;

  factory WindMeasure.byName(String? name) {
    return name == null ? kmPerH : WindMeasure.values.byName(name);
  }

  String toText(double kmPerH, String Function(Object type) getLabel) {
    final num value;
    switch (this) {
      case WindMeasure.kmPerH:
        value = kmPerH;
        break;
      case WindMeasure.mPerS:
        value = (kmPerH * 1000 / 3600).round();
        break;
    }

    return '${NumberFormat('0.#').format(value)} ${getLabel(this)}';
  }
}

/// Pressure metric system.
enum PressureMeasure {
  /// Kilopascal.
  hPa,

  /// Millimetre of mercury.
  mmHg;

  factory PressureMeasure.byName(String? name) {
    return name == null ? hPa : PressureMeasure.values.byName(name);
  }

  String toText(int hPa, String Function(Object type) getLabel) {
    final int value;
    switch (this) {
      case PressureMeasure.hPa:
        value = hPa;
        break;
      case PressureMeasure.mmHg:
        value = (hPa * 0.75).round();
        break;
    }

    return '$value ${getLabel(this)}';
  }
}
