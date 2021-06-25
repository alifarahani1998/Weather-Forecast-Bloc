part of 'network_cubit.dart';

@immutable
abstract class NetworkState {}


class NetworkLoading extends NetworkState {}

class NetworkConnected extends NetworkState {
  final ConnectionType connectionType;

  NetworkConnected({@required this.connectionType});
}

class NetworkDisConnected extends NetworkState {}
