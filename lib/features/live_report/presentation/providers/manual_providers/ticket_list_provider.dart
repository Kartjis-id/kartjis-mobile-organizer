// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/data_dummies/ticket.dart';

final ticketListProvider = StateProvider.autoDispose<List<Ticket>>(
  (ref) => tickets,
);
