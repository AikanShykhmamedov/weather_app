import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app/app_constants.dart';
import 'package:weather_app/localization/localization.dart';

import '../constants/weather_animation_artboards.dart';
import '../models/city_weather.dart';
import '../models/weather_measure.dart';
import '../providers/dynamic_theme.dart';
import '../providers/location.dart';
import '../providers/preferences.dart';
import '../providers/weather.dart';
import '../repositories/favorite_cities_repository.dart';
import '../repositories/local_city_repository.dart';
import 'drawer/home_drawer.dart';
import 'widgets/circular_refresh_indicator.dart';
import 'widgets/local_area_page.dart';
import 'widgets/weather_animation.dart';
import 'widgets/weather_details.dart';
import 'widgets/weather_header.dart';
import 'widgets/weather_page_indicator.dart';
import 'widgets/weather_temperature.dart';

/// Agreement of cities order.
///
/// Lets a local city be the first in the list of all (local + favorites) cities
/// on the page.
extension _CitiesOrderAgreement on WeatherState {
  int get initialId => localCity != null || favoriteCities.isEmpty ? 0 : 1;

  CityWeather? get initialCity => localCity != null || favoriteCities.isEmpty
      ? localCity
      : favoriteCities.first;

  CityWeather? cityById(int id) => id == 0 ? localCity : favoriteCities[id - 1];
}

/// {@template home_screen}
/// Main screen of the app.
///
/// Shows weather of a local city and favorite cities.
/// {@endtemplate}
class HomeScreen extends StatefulWidget {
  /// {@macro home_screen}
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<Location>().updatePermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<Location, Weather>(
      create: (_) => Weather(
        localCityRepository: context.read<LocalCityRepository>(),
        favoriteCitiesRepository: context.read<FavoriteCitiesRepository>(),
      ),
      update: (_, location, weather) =>
          weather!..setLocationAvailability(location.isLocationAvailable),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  late final PageController _pageController;
  late final ValueNotifier<int> _currentCityId;

  @override
  void initState() {
    super.initState();

    _scaffoldKey = GlobalKey<ScaffoldState>();

    final weather = context.read<Weather>();
    final dynamicTheme = context.read<DynamicTheme>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dynamicTheme.set(weather.state.initialCity);

      weather.update().then((_) {
        final currentCity =
            weather.state.cityById(_pageController.page!.round());
        dynamicTheme.set(currentCity);
      });
    });

    weather.addListener(() => _weatherListener(weather));

    _pageController = PageController(
      initialPage: weather.state.initialId,
    )..addListener(() => _onCityChange(weather, dynamicTheme));

    _currentCityId = ValueNotifier<int>(weather.state.initialId);
  }

  @override
  void dispose() {
    _currentCityId.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    final background = Consumer<DynamicTheme>(
      builder: (_, theme, __) => SizedBox.expand(
        child: ColoredBox(
          color: theme.continuousThemeData.background,
        ),
      ),
    );

    final menuButton = Padding(
      padding: EdgeInsets.only(top: 8 + topPadding, right: 8),
      child: IconButton(
        onPressed: _onMenuPressed,
        icon: const Icon(Icons.menu_rounded),
      ),
    );

    final content = CircularRefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: SizedBox.fromSize(
        size: MediaQuery.of(context).size,
        child: SafeArea(
          child: Selector<Weather, WeatherState>(
            selector: (_, weather) => weather.state,
            shouldRebuild: (_, next) => next.shouldRebuild,
            builder: (context, state, _) => ValueListenableBuilder<int>(
              valueListenable: _currentCityId,
              builder: (context, id, _) {
                return state.buildMap<Widget>(
                  loaded: (state) {
                    final cityWeather = state.cityById(id);

                    final header = cityWeather == null
                        ? const WeatherHeader.placeholder()
                        : WeatherHeader(
                            cityName: cityWeather.name,
                            weatherType: cityWeather.type,
                          );

                    final temperature =
                        Selector<Preferences, TemperatureMeasure>(
                      selector: (_, preferences) =>
                          preferences.temperatureMeasure,
                      builder: (_, measure, __) {
                        return cityWeather == null
                            ? const WeatherTemperature.placeholder()
                            : WeatherTemperature(
                                temperature: cityWeather.temperature,
                                temperatureBefore:
                                    cityWeather.temperatureBefore,
                                temperatureAfter: cityWeather.temperatureAfter,
                                temperatureMeasure: measure,
                              );
                      },
                    );

                    final pageView = PageView.builder(
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: _onCityChanged,
                      itemCount: 1 + state.favoriteCities.length,
                      itemBuilder: (context, i) {
                        if (i == 0) {
                          return Consumer<Location>(
                            builder: (context, location, _) => LocalAreaPage(
                              isServiceEnabled: location.isServiceEnabled,
                              isPermissionGranted: location.isPermissionGranted,
                              openLocationSettings:
                                  location.openLocationSettings,
                              openAppSettings: location.openAppSettings,
                              city: state.localCity,
                            ),
                          );
                        }

                        final city = state.favoriteCities[i - 1];
                        final artboard =
                            WeatherAnimationArtboards.resolve(city);

                        return WeatherAnimation(
                          artboard: artboard,
                        );
                      },
                    );

                    final indicator = WeatherPageIndicator(
                      controller: _pageController,
                      favoriteCitiesCount: state.favoriteCities.length,
                    );

                    final details = Selector<Preferences, Map>(
                      selector: (_, preferences) => {
                        'wind': preferences.windMeasure,
                        'pressure': preferences.pressureMeasure,
                      },
                      builder: (_, measures, __) {
                        return cityWeather == null
                            ? const WeatherDetails.placeholder()
                            : WeatherDetails(
                                sunrise: cityWeather.sunrise,
                                sunset: cityWeather.sunset,
                                wind: cityWeather.wind,
                                pressure: cityWeather.pressure,
                                windMeasure: measures['wind'],
                                pressureMeasure: measures['pressure'],
                              );
                      },
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              16, 16, 16 + 40 + 16, 16),
                          child: header,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: temperature,
                        ),
                        Expanded(
                          child: pageView,
                        ),
                        Center(
                          child: indicator,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: details,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: HomeDrawer(
        onFavoriteCityPressed: _onFavoriteCityPressed,
      ),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          background,
          content,
          menuButton,
        ],
      ),
    );
  }

  void _weatherListener(Weather weather) {
    weather.state.mapOrNull(
      loaded: (state) {
        final currentPage = _pageController.page!.round();

        if (currentPage == 1 + state.favoriteCities.length) {
          _pageController.jumpTo(currentPage - 1);
        }
      },
      error: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: Theme.of(context).colorScheme.onError,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(S.current.error_occurred),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onCityChange(Weather weather, DynamicTheme dynamicTheme) {
    final cityA = weather.state.cityById(_pageController.page!.floor());
    final cityB = weather.state.cityById(_pageController.page!.ceil());
    final t = _pageController.page! % 1;

    dynamicTheme.lerp(cityA, cityB, t);
  }

  void _onMenuPressed() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  Future<void> _onRefresh(BuildContext context) async {
    final weather = context.read<Weather>();

    await weather.update();

    final currentId = _pageController.page!.round();
    final currentCity = weather.state.cityById(currentId);

    if (mounted) {
      context.read<DynamicTheme>().set(currentCity);
    }
  }

  void _onCityChanged(int id) {
    _currentCityId.value = id;
  }

  void _onFavoriteCityPressed(int id) {
    _pageController.animateToPage(
      1 + id,
      duration: AnimationDuration.standard,
      curve: Curves.easeInOutCubic,
    );
  }
}
