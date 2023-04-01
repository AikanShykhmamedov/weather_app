import 'package:flutter/material.dart';
import 'package:location_api/location_api.dart';

import 'app/app.dart';

void main({LocationApi? locationApi}) {
  App.setup();

  runApp(App(locationApi: locationApi));
}
