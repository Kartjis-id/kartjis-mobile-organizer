// Package imports:
import 'package:http/http.dart';

class ServerException implements Exception {
  final String message;

  const ServerException(this.message);
}

class ConnectionException implements Exception {
  final String message;

  const ConnectionException(this.message);
}

Never exception(Object e) {
  if (e is ServerException) {
    throw ServerException(e.message);
  } else if (e is ConnectionException) {
    throw ConnectionException(e.message);
  } else {
    throw ClientException('$e');
  }
}
