// Package imports:
import 'package:http/http.dart' as http;

class HttpClient {
  HttpClient._instance();

  static final HttpClient _httpClient = HttpClient._instance();

  factory HttpClient() => _httpClient;

  http.Client? _client;

  http.Client get client => _client ??= http.Client();
}
