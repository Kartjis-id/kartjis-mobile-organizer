// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/data_dummies/event.dart';

final focusedEventProvider = StateProvider<Event>(
  (ref) => events.first,
);
