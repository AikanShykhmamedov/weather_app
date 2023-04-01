/// App secretes (e.g. API keys).
abstract class AppConfig {
  static const weatherApiKey = String.fromEnvironment('WEATHER_API_KEY');
}
