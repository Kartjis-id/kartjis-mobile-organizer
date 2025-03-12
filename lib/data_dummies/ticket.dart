// Project imports:
import 'package:kartjis_mobile_organizer/data_dummies/buyer.dart';

class Ticket {
  final String category;
  final Buyer buyer;

  const Ticket({
    required this.category,
    required this.buyer,
  });
}

final verifiedTickets = [
  Ticket(
    category: 'Presale 1',
    buyer: buyers[0],
  ),
  Ticket(
    category: 'Presale 1',
    buyer: buyers[0],
  ),
  Ticket(
    category: 'Presale 1',
    buyer: buyers[0],
  ),
  Ticket(
    category: 'First Wave',
    buyer: buyers[1],
  ),
  Ticket(
    category: 'First Wave',
    buyer: buyers[1],
  ),
  Ticket(
    category: 'VIP',
    buyer: buyers[2],
  ),
  Ticket(
    category: 'VIP',
    buyer: buyers[2],
  ),
  Ticket(
    category: 'VVIP',
    buyer: buyers[3],
  ),
];

final unverifiedTickets = [
  Ticket(
    category: 'Presale 1',
    buyer: buyers[3],
  ),
  Ticket(
    category: 'Presale 2',
    buyer: buyers[1],
  ),
  Ticket(
    category: 'Second Wave',
    buyer: buyers[2],
  ),
  Ticket(
    category: 'Second Wave',
    buyer: buyers[2],
  ),
  Ticket(
    category: 'VIP',
    buyer: buyers[1],
  ),
  Ticket(
    category: 'VIP',
    buyer: buyers[4],
  ),
  Ticket(
    category: 'First Wave',
    buyer: buyers[3],
  ),
  Ticket(
    category: 'First Wave',
    buyer: buyers[4],
  ),
];
