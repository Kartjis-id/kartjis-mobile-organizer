// Package imports:
import 'package:intl/intl.dart';

extension StringPattern on DateTime {
  String toStringPattern(String pattern) {
    return DateFormat(pattern).format(this);
  }
}
