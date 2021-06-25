import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:weather_forecast/constants/enums.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {

  final Connectivity connectivity;

  StreamSubscription streamSubscription;


  NetworkCubit({@required this.connectivity}) : super(NetworkLoading()) {
    monitorNetworkConnection();
  }


  StreamSubscription monitorNetworkConnection() {
    return streamSubscription = connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi)
        emitNetworkConnected(ConnectionType.Wifi);
      else if (event == ConnectivityResult.mobile)
        emitNetworkConnected(ConnectionType.Mobile);
      else if (event == ConnectivityResult.none)
        emitNetworkDisConnected();
    });
  }


  void emitNetworkConnected(ConnectionType connectionType) => emit(NetworkConnected(connectionType: connectionType));

  void emitNetworkDisConnected() => emit(NetworkDisConnected());



  @override
  Future<Function> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
