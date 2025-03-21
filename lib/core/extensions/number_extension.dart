// Package imports:
import 'package:intl/intl.dart';

extension DecimalPattern on num {
  String toDecimalPattern() => NumberFormat.decimalPattern().format(this);
}
