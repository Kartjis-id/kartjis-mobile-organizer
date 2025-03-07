// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'count_down_provider.g.dart';

@riverpod
Stream<int> countDown(Ref ref, int seconds) async* {
  var value = seconds;

  while (value >= 0) {
    await Future.delayed(const Duration(seconds: 1));

    yield value--;
  }
}
