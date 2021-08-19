part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}


class FetchForCity extends WeatherEvent {
  final String city;
  FetchForCity({@required this.city});
}

class FetchForCurrentLoc extends WeatherEvent {}
