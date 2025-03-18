// Project imports:
import 'package:kartjis_mobile_organizer/core/enums/verification_status.dart';
import 'package:kartjis_mobile_organizer/data_dummies/buyer.dart';

class Ticket {
  final String category;
  final Buyer buyer;
  final VerificationStatus status;

  const Ticket({
    required this.category,
    required this.buyer,
    required this.status,
  });
}

final tickets = [
  Ticket(
    category: 'Presale 1',
    buyer: buyers[0],
    status: VerificationStatus.verified,
  ),
  Ticket(
    category: 'Presale 1',
    buyer: buyers[0],
    status: VerificationStatus.verified,
  ),
  Ticket(
    category: 'Presale 1',
    buyer: buyers[0],
    status: VerificationStatus.verified,
  ),
  Ticket(
    category: 'First Wave',
    buyer: buyers[1],
    status: VerificationStatus.verified,
  ),
  Ticket(
    category: 'First Wave',
    buyer: buyers[1],
    status: VerificationStatus.verified,
  ),
  Ticket(
    category: 'VIP',
    buyer: buyers[2],
    status: VerificationStatus.verified,
  ),
  Ticket(
    category: 'VIP',
    buyer: buyers[2],
    status: VerificationStatus.verified,
  ),
  Ticket(
    category: 'VVIP',
    buyer: buyers[3],
    status: VerificationStatus.verified,
  ),
  Ticket(
    category: 'Presale 1',
    buyer: buyers[3],
    status: VerificationStatus.unverified,
  ),
  Ticket(
    category: 'Presale 2',
    buyer: buyers[1],
    status: VerificationStatus.unverified,
  ),
  Ticket(
    category: 'Second Wave',
    buyer: buyers[2],
    status: VerificationStatus.unverified,
  ),
  Ticket(
    category: 'Second Wave',
    buyer: buyers[2],
    status: VerificationStatus.unverified,
  ),
  Ticket(
    category: 'VIP',
    buyer: buyers[1],
    status: VerificationStatus.unverified,
  ),
  Ticket(
    category: 'VIP',
    buyer: buyers[4],
    status: VerificationStatus.unverified,
  ),
  Ticket(
    category: 'First Wave',
    buyer: buyers[3],
    status: VerificationStatus.unverified,
  ),
  Ticket(
    category: 'First Wave',
    buyer: buyers[4],
    status: VerificationStatus.unverified,
  ),
];
