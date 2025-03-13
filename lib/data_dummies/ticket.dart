// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/verification_status.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/data_dummies/buyer.dart';

class Ticket {
  final String category;
  final Buyer buyer;
  final VerificationStatus status;
  final Color color;

  const Ticket({
    required this.category,
    required this.buyer,
    required this.status,
    required this.color,
  });
}

final verifiedTickets = [
  Ticket(
    category: 'Presale 1',
    buyer: buyers[0],
    status: VerificationStatus.verified,
    color: Palette.green400,
  ),
  Ticket(
    category: 'Presale 1',
    buyer: buyers[0],
    status: VerificationStatus.verified,
    color: Palette.green400,
  ),
  Ticket(
    category: 'Presale 1',
    buyer: buyers[0],
    status: VerificationStatus.verified,
    color: Palette.green400,
  ),
  Ticket(
    category: 'First Wave',
    buyer: buyers[1],
    status: VerificationStatus.verified,
    color: Palette.green400,
  ),
  Ticket(
    category: 'First Wave',
    buyer: buyers[1],
    status: VerificationStatus.verified,
    color: Palette.green400,
  ),
  Ticket(
    category: 'VIP',
    buyer: buyers[2],
    status: VerificationStatus.verified,
    color: Palette.green400,
  ),
  Ticket(
    category: 'VIP',
    buyer: buyers[2],
    status: VerificationStatus.verified,
    color: Palette.green400,
  ),
  Ticket(
    category: 'VVIP',
    buyer: buyers[3],
    status: VerificationStatus.verified,
    color: Palette.green400,
  ),
];

final unverifiedTickets = [
  Ticket(
    category: 'Presale 1',
    buyer: buyers[3],
    status: VerificationStatus.unverified,
    color: Palette.secondary,
  ),
  Ticket(
    category: 'Presale 2',
    buyer: buyers[1],
    status: VerificationStatus.unverified,
    color: Palette.secondary,
  ),
  Ticket(
    category: 'Second Wave',
    buyer: buyers[2],
    status: VerificationStatus.unverified,
    color: Palette.secondary,
  ),
  Ticket(
    category: 'Second Wave',
    buyer: buyers[2],
    status: VerificationStatus.unverified,
    color: Palette.secondary,
  ),
  Ticket(
    category: 'VIP',
    buyer: buyers[1],
    status: VerificationStatus.unverified,
    color: Palette.secondary,
  ),
  Ticket(
    category: 'VIP',
    buyer: buyers[4],
    status: VerificationStatus.unverified,
    color: Palette.secondary,
  ),
  Ticket(
    category: 'First Wave',
    buyer: buyers[3],
    status: VerificationStatus.unverified,
    color: Palette.secondary,
  ),
  Ticket(
    category: 'First Wave',
    buyer: buyers[4],
    status: VerificationStatus.unverified,
    color: Palette.secondary,
  ),
];
