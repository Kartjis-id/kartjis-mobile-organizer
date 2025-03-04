/// A collection of helper functions that are reusable for this app
class FunctionHelper {
  static Map<String, String> formattedDurationMap([int seconds = 0]) {
    final day = '${seconds ~/ 86400}'.padLeft(2, '0');
    final hour = '${(seconds % 86400) ~/ 3600}'.padLeft(2, '0');
    final min = '${(seconds % 3600) ~/ 60}'.padLeft(2, '0');
    final sec = '${seconds % 60}'.padLeft(2, '0');

    return {
      'day': day,
      'hour': hour,
      'min': min,
      'sec': sec,
    };
  }
}
