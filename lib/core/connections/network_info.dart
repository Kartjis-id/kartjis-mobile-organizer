// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final networkInfoProvider = Provider<NetworkInfo>(
  (ref) => NetworkInfoImpl(
    internetConnection: InternetConnection(),
  ),
);

sealed class NetworkInfo {
  Future<bool> get isConnected;
}

final class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection internetConnection;

  const NetworkInfoImpl({required this.internetConnection});

  @override
  Future<bool> get isConnected => internetConnection.hasInternetAccess;
}
