// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utilities/asset_path.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class SearchField extends StatefulWidget {
  final String text;
  final String? hintText;
  final bool autoFocus;
  final ValueChanged<String> onChanged;
  final bool delayOnChanged;
  final Duration delayDuration;

  const SearchField({
    super.key,
    required this.text,
    this.hintText,
    this.autoFocus = false,
    required this.onChanged,
    this.delayOnChanged = false,
    this.delayDuration = const Duration(milliseconds: 750),
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController controller;
  late final ValueNotifier<bool> isFocus;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
    isFocus = ValueNotifier(false);
  }

  @override
  void dispose() {
    controller.dispose();
    isFocus.dispose();
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) => isFocus.value = value,
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: controller,
          autofocus: widget.autoFocus,
          textInputAction: TextInputAction.search,
          textAlignVertical: TextAlignVertical.center,
          style: textTheme.bodyLarge,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: widget.hintText,
            hintStyle: textTheme.bodyLarge!.secondaryTextColor,
            isDense: true,
            filled: true,
            fillColor: Palette.grey,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 10,
              ),
              child: ValueListenableBuilder(
                valueListenable: isFocus,
                builder: (context, isFocus, child) {
                  return SvgAsset(
                    AssetPath.getIcon('search.svg'),
                    color: isFocus ? Palette.primaryText : Palette.secondaryText,
                  );
                },
              ),
            ),
            suffixIcon: widget.text.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: resetQuery,
                    icon: SvgAsset(
                      AssetPath.getIcon('close.svg'),
                      color: Palette.primaryText,
                      width: 16,
                    ),
                  ),
          ),
          onChanged: widget.delayOnChanged ? (text) => debounce(() => widget.onChanged(text)) : widget.onChanged,
        ),
      ),
    );
  }

  void debounce(VoidCallback callback) {
    timer?.cancel();
    timer = Timer(widget.delayDuration, callback);
  }

  void resetQuery() {
    controller.clear();
    widget.onChanged('');
  }
}
