// Package imports:
import 'package:intl/intl.dart';

extension DecimalPattern on num {
  String toDecimalPattern() {
    return NumberFormat.decimalPattern().format(this);
  }
}
