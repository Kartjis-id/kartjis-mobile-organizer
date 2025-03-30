// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/event_image_type.dart';

final eventImageTypeIndexProvider = StateProvider.autoDispose<int>(
  (ref) => EventImageType.values.length - 1,
);
