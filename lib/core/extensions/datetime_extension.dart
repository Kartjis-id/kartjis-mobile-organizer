// Package imports:
import 'package:intl/intl.dart';

extension StringPattern on DateTime {
  String toStringPattern(String pattern) => DateFormat(pattern).format(this);
}
