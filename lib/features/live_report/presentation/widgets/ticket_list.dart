// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/data_dummies/ticket.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/widgets/ticket_card.dart';

class TicketList extends StatefulWidget {
  final List<Ticket> tickets;
  final ScrollController controller;

  const TicketList({
    super.key,
    required this.tickets,
    required this.controller,
  });

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListView.separated(
      controller: widget.controller,
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) {
        return TicketCard(
          ticket: widget.tickets[index],
        );
      },
      separatorBuilder: (context, index) {
        return const Gap(12);
      },
      itemCount: widget.tickets.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
