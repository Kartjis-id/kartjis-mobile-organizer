// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/keys.dart';
import 'package:kartjis_mobile_organizer/data_dummies/event.dart';
import 'package:kartjis_mobile_organizer/features/main/presentation/providers/manual_providers/selected_event_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/dialogs/custom_dialog.dart';

class SelectEventDialog extends ConsumerWidget {
  const SelectEventDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomDialog(
      title: 'Select Your Event!',
      childPadding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return _EventListTile(
            event: events[index],
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
            thickness: 1,
            color: Palette.divider.withValues(alpha: .7),
          );
        },
        itemCount: events.length,
      ),
      onPressedPrimaryButton: () {
        ref.read(selectedEventProvider.notifier).state = ref.watch(selectedEventItemProvider);
        navigatorKey.currentState?.pop();
      },
    );
  }
}

class _EventListTile extends ConsumerWidget {
  final Event event;

  const _EventListTile({required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => ref.read(selectedEventItemProvider.notifier).state = event,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 12, 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                event.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelLarge!.primaryTextColor,
              ),
            ),
            const Gap(12),
            Radio<Event>(
              value: event,
              groupValue: ref.watch(selectedEventItemProvider),
              activeColor: Palette.tertiary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (value) => ref.read(selectedEventItemProvider.notifier).state = value!,
            ),
          ],
        ),
      ),
    );
  }
}
