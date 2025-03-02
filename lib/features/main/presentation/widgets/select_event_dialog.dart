// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/keys.dart';
import 'package:kartjis_mobile_organizer/data_dummies/event.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/providers/selected_event_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/dialogs/custom_dialog.dart';

class SelectEventDialog extends StatelessWidget {
  const SelectEventDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      onPressedPrimaryButton: () => navigatorKey.currentState!.pop(),
      title: 'Select Your Event!',
      childPadding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) => _EventItem(
          event: events[index],
        ),
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 1,
          color: Palette.divider.withValues(alpha: .75),
        ),
        itemCount: events.length,
        shrinkWrap: true,
      ),
    );
  }
}

class _EventItem extends ConsumerWidget {
  final Event event;

  const _EventItem({required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => ref.read(selectedEventProvider.notifier).state = event,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 12, 8),
        child: Row(
          children: [
            Expanded(
              child: Text(event.name),
            ),
            const Gap(16),
            Radio<Event>(
              value: event,
              groupValue: ref.watch(selectedEventProvider),
              activeColor: Palette.tertiary,
              onChanged: (value) => ref.read(selectedEventProvider.notifier).state = value!,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
}
