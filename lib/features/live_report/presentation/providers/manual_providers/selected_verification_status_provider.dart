// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/verification_status.dart';

final selectedVerificationStatusProvider = StateProvider.autoDispose<VerificationStatus>(
  (ref) => VerificationStatus.unverified,
);
