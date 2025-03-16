// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scannerPausedProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);
