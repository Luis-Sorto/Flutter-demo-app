import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityResultProvider = StreamProvider<List<ConnectivityResult>>(
  name: 'ConnectivityResult',
  (ref) => Connectivity().onConnectivityChanged,
);
