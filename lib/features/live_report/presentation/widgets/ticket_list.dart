// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/helpers/helper_function.dart';
import 'package:kartjis_mobile_organizer/data_dummies/ticket.dart';
import 'package:kartjis_mobile_organizer/features/live_report/presentation/widgets/ticket_card.dart';

class TicketList extends StatefulWidget {
  final List<Ticket> tickets;
  final AnimationController animationController;
  final ScrollController scrollController;
  final RefreshCallback onRefresh;

  const TicketList({
    super.key,
    required this.tickets,
    required this.animationController,
    required this.scrollController,
    required this.onRefresh,
  });

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      displacement: 20,
      child: NotificationListener<UserScrollNotification>(
        onNotification: (notification) => FunctionHelper.handleFabVisibilityOnScroll(
          widget.animationController,
          notification,
        ),
        child: ListView.separated(
          controller: widget.scrollController,
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
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
