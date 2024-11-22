// Flutter imports:
import 'package:flutter/foundation.dart';

class ApiConfig {
  static const _baseUrl = kDebugMode ? 'https://dev.dc.kartjis.id/api' : 'https://dc.kartjis.id/api';

  static Uri url([String path = '']) => Uri.parse(_baseUrl + path);
}
