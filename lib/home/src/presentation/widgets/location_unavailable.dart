import 'package:flutter/material.dart';
import 'package:weather_app/localization/localization.dart';

class PermissionNotGranted extends StatelessWidget {
  const PermissionNotGranted({
    super.key,
    required this.openAppSettings,
  });

  final VoidCallback openAppSettings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).permission_not_granted_title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!,
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).permission_not_granted_content,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: openAppSettings,
              child: Text(S.of(context).turn_on_location),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationServiceUnavailable extends StatelessWidget {
  const LocationServiceUnavailable({
    super.key,
    required this.openSettings,
  });

  final VoidCallback openSettings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).location_service_unavailable_title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!,
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).location_service_unavailable_content,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: openSettings,
              child: Text(S.of(context).turn_on_location),
            ),
          ],
        ),
      ),
    );
  }
}
