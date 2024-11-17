// Package imports:
import 'package:http/http.dart' show Client;

class HttpClient {
  HttpClient._instance();

  static final HttpClient _httpClient = HttpClient._instance();

  factory HttpClient() => _httpClient;

  Client? _client;

  Client get client => _client ??= Client();
}
