import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/controller/blocs/weather_bloc.dart';
import 'package:weather_forecast/controller/cubits/network_cubit.dart';
import 'package:weather_forecast/view/routes/route.dart';


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
        BlocProvider<NetworkCubit>(create: (context) => NetworkCubit(connectivity: connectivity)),
        BlocProvider<WeatherBloc>(create: (context) => WeatherBloc())
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



