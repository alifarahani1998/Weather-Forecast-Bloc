import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'file:///C:/Users/Ali/Desktop/Weather-Forecast-Bloc/lib/blocs/weather/weather_bloc.dart';
import 'package:weather_forecast/models/weather_model.dart';
import 'package:weather_forecast/views/widgets/search_city_widget.dart';


class CitySelect extends StatefulWidget {

  @override
  _CitySelectState createState() => _CitySelectState();
}

class _CitySelectState extends State<CitySelect> {
  WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = new WeatherBloc();
  }

  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchCity(),
                ),
              );
              if (city != null) {
                cityName = city;
                _weatherBloc.add(FetchForCity(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          cubit: _weatherBloc,
          builder: (_, state) {
            if (state is WeatherEmpty) {
              return Center(child: Text('Please Select a Location'));
            }
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoaded) {
              final weather = state.weather;
              return ListView(
                children: <Widget>[
                  Center(child: Text('Weather For City: ' + cityName),),
                  Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Center(
                      child: Text('Main Temperature is: ' + Weather.convertFahrenheitToCelsius(weather.mainTemp.toString()) + ' C'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Center(
                      child: Text('Max Temperature is: ' + Weather.convertFahrenheitToCelsius(weather.maxTemp.toString()) + ' C'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Center(
                      child: Text('Min Temperature is: ' + Weather.convertFahrenheitToCelsius(weather.minTemp.toString()) + ' C'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Center(
                      child: Text('Humidity is: ' + weather.humidity.toString()),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Center(
                      child: Text('Pressure is: ' + weather.pressure.toString()),
                    ),
                  ),
                ],
              );
            }
            if (state is WeatherError) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
            return Container();
          },
        )
      ),
    );
  }

  @override
  void dispose() {
    _weatherBloc.close();
    super.dispose();
  }
}