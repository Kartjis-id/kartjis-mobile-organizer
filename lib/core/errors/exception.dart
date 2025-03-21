class ConnectionException implements Exception {
  final String message;

  const ConnectionException(this.message);
}

class ClientException implements Exception {
  final String message;

  const ClientException(this.message);
}

class ServerException implements Exception {
  final String message;

  const ServerException(this.message);
}
