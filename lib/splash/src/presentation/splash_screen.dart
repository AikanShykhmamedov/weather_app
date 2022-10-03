import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app/app_routes.dart';
import 'package:weather_app/home/home.dart';

/// {@template splash_screen}
/// The App entry point screen.
///
/// Initializes data and tries to access location. Shows the Sun animation
/// while initializing. Then automatically navigates to [HomeScreen].
/// {@endtemplate}
class SplashScreen extends StatefulWidget {
  /// {@macro splash_screen}
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.wait([
      context.read<LocalCityRepository>().initialize(),
      context.read<FavoriteCitiesRepository>().initialize(),
      context.read<Location>().initialize(),
      context.read<Preferences>().initialize(),
    ]).then((_) async {
      await context.read<Location>().requestPermission();
    }).then((_) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 192,
          child: WeatherAnimation(
            artboard: WeatherAnimationArtboards.clear,
          ),
        ),
      ),
    );
  }
}
