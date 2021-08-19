import 'dart:convert';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/constants/api.dart';
import 'package:weather_forecast/models/weather_model.dart';


class WeatherRepository {

  http.Client httpClient = new http.Client();

  Future<Weather> getWeatherForCurrentLoc() async {

    LocationData currentLocation = await getCurrentLocation();
    String lat = currentLocation.latitude.toString();
    String long = currentLocation.longitude.toString();

    String cityLatLong = GET_CITY_NAME_URL + lat + ',' + long;

    final response = await httpClient.get(Uri.parse(cityLatLong));
    if (response.statusCode != 200) {
      throw Exception('error getting city name');
    }

    var json = jsonDecode(response.body);




    final url = Uri.parse('${BASE_URL}q=${json[1]['title']}&apikey=$API_KEY');
    final res = await httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('error getting data');
    }

    var result = jsonDecode(res.body);

    return Weather.parseJson(result);
  }


  Future<Weather> getWeatherForCity(String city) async {
    final url = Uri.parse('${BASE_URL}q=$city&apikey=$API_KEY');
    final response = await httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('error getting data');
    }

    var json = jsonDecode(response.body);

    return Weather.parseJson(json);
  }




  getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    location.enableBackgroundMode(enable: true);

    return _locationData;
  }

}