// Project imports:
import 'package:kartjis_mobile_organizer/data_dummies/buyer.dart';

class Ticket {
  final String id;
  final String category;
  final Buyer buyer;
  final bool verified;

  const Ticket({
    required this.id,
    required this.category,
    required this.buyer,
    required this.verified,
  });
}

final tickets = [
  Ticket(
    id: '5b2c0654-de5e-3153-ac1f-751cac718e4e',
    category: 'Presale 1',
    buyer: buyers[0],
    verified: true,
  ),
  Ticket(
    id: '5b2c0654-de5e-3153-ac1f-751cac718e4e',
    category: 'Presale 1',
    buyer: buyers[0],
    verified: true,
  ),
  Ticket(
    id: '5b2c0654-de5e-3153-ac1f-751cac718e4e',
    category: 'Presale 1',
    buyer: buyers[0],
    verified: true,
  ),
  Ticket(
    id: '5b2c0654-de5e-3153-ac1f-751cac718e4e',
    category: 'First Wave',
    buyer: buyers[1],
    verified: true,
  ),
  Ticket(
    id: '5b2c0654-de5e-3153-ac1f-751cac718e4e',
    category: 'First Wave',
    buyer: buyers[1],
    verified: true,
  ),
  Ticket(
    id: '5b2c0654-de5e-3153-ac1f-751cac718e4e',
    category: 'VIP',
    buyer: buyers[2],
    verified: true,
  ),
  Ticket(
    id: '5b2c0654-de5e-3153-ac1f-751cac718e4e',
    category: 'VIP',
    buyer: buyers[2],
    verified: true,
  ),
  Ticket(
    id: '5b2c0654-de5e-3153-ac1f-751cac718e4e',
    category: 'VVIP',
    buyer: buyers[3],
    verified: true,
  ),
  Ticket(
    id: 'bf91c434-dcf3-3a4c-b49a-12e0944ef1e2',
    category: 'Presale 1',
    buyer: buyers[3],
    verified: false,
  ),
  Ticket(
    id: 'bf91c434-dcf3-3a4c-b49a-12e0944ef1e2',
    category: 'Presale 2',
    buyer: buyers[1],
    verified: false,
  ),
  Ticket(
    id: 'bf91c434-dcf3-3a4c-b49a-12e0944ef1e2',
    category: 'Second Wave',
    buyer: buyers[2],
    verified: false,
  ),
  Ticket(
    id: 'bf91c434-dcf3-3a4c-b49a-12e0944ef1e2',
    category: 'Second Wave',
    buyer: buyers[2],
    verified: false,
  ),
  Ticket(
    id: 'bf91c434-dcf3-3a4c-b49a-12e0944ef1e2',
    category: 'VIP',
    buyer: buyers[1],
    verified: false,
  ),
  Ticket(
    id: 'bf91c434-dcf3-3a4c-b49a-12e0944ef1e2',
    category: 'VIP',
    buyer: buyers[4],
    verified: false,
  ),
  Ticket(
    id: 'bf91c434-dcf3-3a4c-b49a-12e0944ef1e2',
    category: 'First Wave',
    buyer: buyers[3],
    verified: false,
  ),
  Ticket(
    id: 'bf91c434-dcf3-3a4c-b49a-12e0944ef1e2',
    category: 'First Wave',
    buyer: buyers[4],
    verified: false,
  ),
];
