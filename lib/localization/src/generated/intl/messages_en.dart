// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(type) => "${Intl.select(type, {
            'hPa': 'hPa',
            'mmHg': 'mmHg',
            'other': ' ',
          })}";

  static String m1(type) => "${Intl.select(type, {
            'celsius': '°C',
            'fahrenheit': '°F',
            'other': ' ',
          })}";

  static String m2(type) => "${Intl.select(type, {
            'clear': 'Clear',
            'fewClouds': 'Few clouds',
            'clouds': 'Clouds',
            'rain': 'Rain',
            'heavyRain': 'Heavy rain',
            'snow': 'Snow',
            'thunderstorm': 'Thunderstorm',
            'other': ' ',
          })}";

  static String m3(type) => "${Intl.select(type, {
            'kmPerH': 'km/h',
            'mPerS': 'm/s',
            'other': ' ',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "about_privacy_policy":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "city_search_could_not_find":
            MessageLookupByLibrary.simpleMessage("Could not find anything :("),
        "city_search_hint": MessageLookupByLibrary.simpleMessage("Enter city"),
        "city_search_title":
            MessageLookupByLibrary.simpleMessage("Search city"),
        "drawer_add_cities":
            MessageLookupByLibrary.simpleMessage("Press + to add new cities"),
        "error_occurred":
            MessageLookupByLibrary.simpleMessage("An error occurred"),
        "favorites": MessageLookupByLibrary.simpleMessage("Favorites"),
        "location_service_unavailable_content":
            MessageLookupByLibrary.simpleMessage(
                "Turn on location service to see the weather in your area"),
        "location_service_unavailable_title":
            MessageLookupByLibrary.simpleMessage(
                "Location service is turned off"),
        "permission_not_granted_content": MessageLookupByLibrary.simpleMessage(
            "Grant location permission to see the weather in your area"),
        "permission_not_granted_title":
            MessageLookupByLibrary.simpleMessage("Permission is not granted"),
        "pressure": MessageLookupByLibrary.simpleMessage("Pressure"),
        "pressure_measure": m0,
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "sunrise": MessageLookupByLibrary.simpleMessage("Sunrise"),
        "sunset": MessageLookupByLibrary.simpleMessage("Sunset"),
        "temperature_measure": m1,
        "turn_on_location":
            MessageLookupByLibrary.simpleMessage("Turn on location"),
        "weather_type": m2,
        "wind": MessageLookupByLibrary.simpleMessage("Wind"),
        "wind_measure": m3
      };
}
