// Package imports:
import 'package:http/http.dart';

class ServerException implements Exception {
  final String message;

  const ServerException(this.message);
}

class PreferencesException implements Exception {
  final String message;

  const PreferencesException(this.message);
}

Never exception(Object e) {
  if (e is ServerException) {
    throw ServerException(e.message);
  } else if (e is PreferencesException) {
    throw PreferencesException(e.message);
  } else {
    throw ClientException('$e');
  }
}
