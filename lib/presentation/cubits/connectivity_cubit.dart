import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

@injectable
class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  ConnectivityCubit(this._connectivity) : super(ConnectivityState.initial()) {
    _checkInitialConnectivity();
    _listenToConnectivityChanges();
  }

  Future<void> _checkInitialConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectivityState(result);
  }

  void _listenToConnectivityChanges() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectivityState,
    );
  }

  void _updateConnectivityState(ConnectivityResult result) {
    final isConnected = result != ConnectivityResult.none;
    emit(ConnectivityState(isConnected: isConnected));
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}

class ConnectivityState {
  final bool isConnected;

  const ConnectivityState({required this.isConnected});

  factory ConnectivityState.initial() => const ConnectivityState(isConnected: true);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ConnectivityState && other.isConnected == isConnected;
  }

  @override
  int get hashCode => isConnected.hashCode;
}