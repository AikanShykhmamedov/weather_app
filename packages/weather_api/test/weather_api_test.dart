import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:weather_api/src/models/current_weather.dart';
import 'package:weather_api/src/models/forecast.dart';
import 'package:weather_api/src/models/forecast_day.dart';
import 'package:weather_api/src/models/location.dart';
import 'package:weather_api/src/weather_api.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  final mockClient = MockClient();
  final weatherApi = WeatherApi(key: '', client: mockClient);

  registerFallbackValue(Uri());

  group('getForecast', () {
    test('Gets forecast for London', () {
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response(londonForecastResponse, 200),
      );

      final forecast = weatherApi.getForecast(0, 0);

      expect(
        forecast,
        completion(londonForecast),
      );
    });

    test('Status code is not equal to 200', () async {
      when(() => mockClient.get(any()))
          .thenAnswer((_) async => http.Response('', 500));

      final forecast = weatherApi.getForecast(0, 0);

      expect(
        forecast,
        throwsA(isA<WeatherApiException>()),
      );
    });

    test('GET throws exception', () {
      when(() => mockClient.get(any()))
          .thenAnswer((_) async => throw Exception());

      final forecast = weatherApi.getForecast(0, 0);

      expect(
        forecast,
        throwsA(isA<Exception>()),
      );
    });
  });

  group('getCompletion', () {
    test('Gets completion for London', () {
      when(() => mockClient.get(any())).thenAnswer(
          (_) async => http.Response(londonCompletionResponse, 200));

      final result = weatherApi.getCompletion('london');

      expect(
        result,
        completion(londonCompletion),
      );
    });

    test('Status code is not equal to 200', () async {
      when(() => mockClient.get(any()))
          .thenAnswer((_) async => http.Response('', 500));

      final forecast = weatherApi.getCompletion('london');

      expect(
        forecast,
        throwsA(isA<WeatherApiException>()),
      );
    });

    test('GET throws exception', () {
      when(() => mockClient.get(any()))
          .thenAnswer((_) async => throw Exception());

      final forecast = weatherApi.getCompletion('london');

      expect(
        forecast,
        throwsA(isA<Exception>()),
      );
    });
  });
}

final londonForecastResponse = '''
{
    "location": {
        "name": "London",
        "region": "City of London, Greater London",
        "country": "United Kingdom",
        "lat": 51.52,
        "lon": -0.11,
        "tz_id": "Europe/London"
    },
    "current": {
        "temp_c": 25.0,
        "condition": {
            "code": 1000
        },
        "wind_kph": 13.0,
        "pressure_mb": 1016.0
    },
    "forecast": {
        "forecastday": [
            {
                "astro": {
                    "sunrise": "06:00 AM",
                    "sunset": "08:04 PM"
                },
                "hour": [
                    {
                        "temp_c": 19.3
                    },
                    {
                        "temp_c": 19.0
                    },
                    {
                        "temp_c": 18.9
                    },
                    {
                        "temp_c": 19.1
                    },
                    {
                        "temp_c": 19.4
                    },
                    {
                        "temp_c": 19.6
                    },
                    {
                        "temp_c": 19.8
                    },
                    {
                        "temp_c": 20.5
                    },
                    {
                        "temp_c": 21.9
                    },
                    {
                        "temp_c": 23.7
                    },
                    {
                        "temp_c": 24.8
                    },
                    {
                        "temp_c": 26.5
                    },
                    {
                        "temp_c": 28.2
                    },
                    {
                        "temp_c": 28.2
                    },
                    {
                        "temp_c": 28.7
                    },
                    {
                        "temp_c": 28.6
                    },
                    {
                        "temp_c": 28.5
                    },
                    {
                        "temp_c": 30.3
                    },
                    {
                        "temp_c": 28.5
                    },
                    {
                        "temp_c": 26.0
                    },
                    {
                        "temp_c": 24.2
                    },
                    {
                        "temp_c": 23.5
                    },
                    {
                        "temp_c": 22.9
                    },
                    {
                        "temp_c": 22.4
                    }
                ]
            }
        ]
    }
}
''';

final londonForecast = Forecast(
    const Location(
      'London',
      'City of London, Greater London',
      'United Kingdom',
      51.52,
      -0.11,
      'Europe/London',
    ),
    const CurrentWeather(
      25.0,
      1000,
      13.0,
      1016.0,
    ),
    ForecastDay(
      DateTime.fromMillisecondsSinceEpoch(
        6 * 60 * 60 * 1000,
        isUtc: true,
      ),
      DateTime.fromMillisecondsSinceEpoch(
        (20 * 60 + 4) * 60 * 1000,
        isUtc: true,
      ),
      [
        19.3,
        19.0,
        18.9,
        19.1,
        19.4,
        19.6,
        19.8,
        20.5,
        21.9,
        23.7,
        24.8,
        26.5,
        28.2,
        28.2,
        28.7,
        28.6,
        28.5,
        30.3,
        28.5,
        26.0,
        24.2,
        23.5,
        22.9,
        22.4
      ],
    ));

final londonCompletionResponse = '''
[
    {
        "name": "London",
        "region": "City of London, Greater London",
        "country": "United Kingdom",
        "lat": 51.52,
        "lon": -0.11
    },
    {
        "name": "Holborn",
        "region": "Camden, Greater London",
        "country": "United Kingdom",
        "lat": 51.52,
        "lon": -0.12
    }
]
''';

final londonCompletion = [
  Location(
    'London',
    'City of London, Greater London',
    'United Kingdom',
    51.52,
    -0.11,
    null,
  ),
  Location(
    'Holborn',
    'Camden, Greater London',
    'United Kingdom',
    51.52,
    -0.12,
    null,
  ),
];
