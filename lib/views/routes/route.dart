import 'package:flutter/material.dart';
import 'package:weather_forecast/views/screens/CitySelect.dart';
import 'package:weather_forecast/views/screens/CurrentLoc.dart';
import 'package:weather_forecast/views/screens/HomeScreen.dart';



class AppRouter {
  Route onGenerateRote(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen(title: 'Home Screen',));
        break;

      case '/current_loc':
        return MaterialPageRoute(builder: (_) => CurrentLocScreen());
        break;

      case '/city_select':
        return MaterialPageRoute(builder: (_) => CitySelect());

      default:
        debugPrint('this is null page');
        return null;
    }
  }
}
