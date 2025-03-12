// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchTextProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);
