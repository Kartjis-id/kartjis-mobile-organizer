class ApiConfig {
  static const baseUrl = 'https://dev.dc.kartjis.id/api';

  static Uri url([String path = '']) => Uri.parse(baseUrl + path);
}
