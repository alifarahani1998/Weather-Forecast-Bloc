import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'file:///C:/Users/Ali/Desktop/weather_forecast/lib/model/weather_repository.dart';
import 'package:weather_forecast/model/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  WeatherRepository weatherRepository = new WeatherRepository();

  WeatherBloc() : super(WeatherEmpty());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event,) async* {
    if (event is FetchForCity) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeatherForCity(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }
    if (event is FetchForCurrentLoc) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeatherForCurrentLoc();
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }
  }
}
