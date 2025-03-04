// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/data_dummies/event.dart';

final selectedEventProvider = StateProvider<Event>(
  (ref) => events.first,
);

final selectedEventItemProvider = StateProvider.autoDispose<Event>(
  (ref) => ref.watch(selectedEventProvider),
);
