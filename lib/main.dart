import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/views/routes/route.dart';
import 'blocs/weather/weather_bloc.dart';


void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}


class MyApp extends StatelessWidget {

  final AppRouter appRouter;
  final Connectivity connectivity;

  MyApp({Key key, @required this.appRouter, this.connectivity})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(create: (context) => WeatherBloc()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          fontFamily: 'iran_sans',
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: appRouter.onGenerateRote,
      ),
    );
  }
}




