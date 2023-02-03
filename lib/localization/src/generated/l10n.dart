// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `{type, select, clear {Clear} fewClouds {Few clouds} clouds {Clouds} rain {Rain} heavyRain {Heavy rain} snow {Snow} thunderstorm {Thunderstorm} other { }}`
  String weather_type(Object type) {
    return Intl.select(
      type,
      {
        'clear': 'Clear',
        'fewClouds': 'Few clouds',
        'clouds': 'Clouds',
        'rain': 'Rain',
        'heavyRain': 'Heavy rain',
        'snow': 'Snow',
        'thunderstorm': 'Thunderstorm',
        'other': ' ',
      },
      name: 'weather_type',
      desc: '',
      args: [type],
    );
  }

  /// `{type, select, celsius {°C} fahrenheit {°F} other { }}`
  String temperature_measure(Object type) {
    return Intl.select(
      type,
      {
        'celsius': '°C',
        'fahrenheit': '°F',
        'other': ' ',
      },
      name: 'temperature_measure',
      desc: '',
      args: [type],
    );
  }

  /// `Wind`
  String get wind {
    return Intl.message(
      'Wind',
      name: 'wind',
      desc: '',
      args: [],
    );
  }

  /// `{type, select, kmPerH {km/h} mPerS {m/s} other { }}`
  String wind_measure(Object type) {
    return Intl.select(
      type,
      {
        'kmPerH': 'km/h',
        'mPerS': 'm/s',
        'other': ' ',
      },
      name: 'wind_measure',
      desc: '',
      args: [type],
    );
  }

  /// `Pressure`
  String get pressure {
    return Intl.message(
      'Pressure',
      name: 'pressure',
      desc: '',
      args: [],
    );
  }

  /// `{type, select, hPa {hPa} mmHg {mmHg} other { }}`
  String pressure_measure(Object type) {
    return Intl.select(
      type,
      {
        'hPa': 'hPa',
        'mmHg': 'mmHg',
        'other': ' ',
      },
      name: 'pressure_measure',
      desc: '',
      args: [type],
    );
  }

  /// `Sunrise`
  String get sunrise {
    return Intl.message(
      'Sunrise',
      name: 'sunrise',
      desc: '',
      args: [],
    );
  }

  /// `Sunset`
  String get sunset {
    return Intl.message(
      'Sunset',
      name: 'sunset',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get about_privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'about_privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Search city`
  String get city_search_title {
    return Intl.message(
      'Search city',
      name: 'city_search_title',
      desc: '',
      args: [],
    );
  }

  /// `Enter city`
  String get city_search_hint {
    return Intl.message(
      'Enter city',
      name: 'city_search_hint',
      desc: '',
      args: [],
    );
  }

  /// `Could not find anything :(`
  String get city_search_could_not_find {
    return Intl.message(
      'Could not find anything :(',
      name: 'city_search_could_not_find',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get error_occurred {
    return Intl.message(
      'An error occurred',
      name: 'error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Press + to add new cities`
  String get drawer_add_cities {
    return Intl.message(
      'Press + to add new cities',
      name: 'drawer_add_cities',
      desc: '',
      args: [],
    );
  }

  /// `Permission is not granted`
  String get permission_not_granted_title {
    return Intl.message(
      'Permission is not granted',
      name: 'permission_not_granted_title',
      desc: '',
      args: [],
    );
  }

  /// `Grant location permission to see the weather in your area`
  String get permission_not_granted_content {
    return Intl.message(
      'Grant location permission to see the weather in your area',
      name: 'permission_not_granted_content',
      desc: '',
      args: [],
    );
  }

  /// `Location service is turned off`
  String get location_service_unavailable_title {
    return Intl.message(
      'Location service is turned off',
      name: 'location_service_unavailable_title',
      desc: '',
      args: [],
    );
  }

  /// `Turn on location service to see the weather in your area`
  String get location_service_unavailable_content {
    return Intl.message(
      'Turn on location service to see the weather in your area',
      name: 'location_service_unavailable_content',
      desc: '',
      args: [],
    );
  }

  /// `Turn on location`
  String get turn_on_location {
    return Intl.message(
      'Turn on location',
      name: 'turn_on_location',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
