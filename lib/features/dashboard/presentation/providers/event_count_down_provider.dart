// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_count_down_provider.g.dart';

@riverpod
class EventCountDown extends _$EventCountDown {
  @override
  Stream<int> build(int seconds) async* {
    var value = seconds;

    while (value >= 0) {
      await Future.delayed(const Duration(seconds: 1));

      yield value--;
    }
  }
}
