import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/controller/blocs/weather_bloc.dart';
import 'package:weather_forecast/model/weather_model.dart';

class CurrentLocScreen extends StatefulWidget {
  @override
  _CurrentLocScreenState createState() => _CurrentLocScreenState();
}

class _CurrentLocScreenState extends State<CurrentLocScreen> {

  WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = new WeatherBloc();
    _weatherBloc.add(FetchForCurrentLoc());
  }

  @override
  void dispose() {
    _weatherBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

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
                  Center(child: Text('Weather For City: '),),
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
        ),
      )
    );
  }
}
