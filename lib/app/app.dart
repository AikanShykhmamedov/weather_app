// TODO: Copyright

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:location_api/location_api.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:weather_app/city_search/city_search.dart';
import 'package:weather_app/home/home.dart';
import 'package:weather_app/localization/localization.dart';
import 'package:weather_app/splash/splash.dart';

import 'app_routes.dart';
import 'app_theme.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    this.locationApi,
  });

  final LocationApi? locationApi;

  /// Initializes some packages used in this app.
  static void setup() {
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LocalCityRepository>(create: (_) => LocalCityRepository()),
        Provider<FavoriteCitiesRepository>(
          create: (_) => FavoriteCitiesRepository(),
        ),
        ChangeNotifierProvider<DynamicTheme>(create: (_) => DynamicTheme()),
        ChangeNotifierProvider<Location>(
          create: (_) => Location(locationApi: locationApi),
        ),
        ChangeNotifierProvider<Preferences>(create: (_) => Preferences()),
      ],
      child: Selector<DynamicTheme, DynamicThemeData>(
        selector: (_, dynamicTheme) => dynamicTheme.themeData,
        builder: (_, themeData, __) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarBrightness: themeData.brightness,
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: resolveAppTheme(themeData),
            initialRoute: AppRoutes.splash,
            onGenerateRoute: _onGenerateRoute,
          ),
        ),
      ),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.citySearch:
        return MaterialPageRoute<CitySearchResult>(
          builder: (_) => const CitySearchScreen(),
          fullscreenDialog: true,
        );
      default:
        return null;
    }
  }
}
