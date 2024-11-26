// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';

class CustomField extends StatefulWidget {
  final bool enabled;
  final String name;
  final String label;
  final String? initialValue;
  final String? hintText;
  final int maxLines;
  final TextInputType? textInputType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final List<String? Function(String?)>? validators;
  final VoidCallback? onTap;
  final VoidCallback? onSuffixIconTap;

  const CustomField({
    super.key,
    this.enabled = true,
    required this.name,
    required this.label,
    this.initialValue,
    this.hintText,
    this.maxLines = 1,
    this.textInputType,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
    this.prefixIcon,
    this.suffixIcon,
    this.validators,
    this.onTap,
    this.onSuffixIconTap,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  late final ValueNotifier<bool> isFocus;

  @override
  void initState() {
    super.initState();

    isFocus = ValueNotifier(false);
  }

  @override
  void dispose() {
    isFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: textTheme.labelMedium!.bold.primaryColor,
        ),
        Gap(6),
        if (widget.prefixIcon != null)
          Focus(
            onFocusChange: (value) => isFocus.value = value,
            child: _buildCustomField(),
          )
        else
          _buildCustomField()
      ],
    );
  }

  FormBuilderTextField _buildCustomField() {
    final hasPrefixIcon = widget.prefixIcon != null;
    final hasSuffixIcon = widget.suffixIcon != null;

    return FormBuilderTextField(
      enabled: widget.enabled,
      name: widget.name,
      initialValue: widget.initialValue,
      maxLines: widget.maxLines,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      textAlignVertical: TextAlignVertical.center,
      style: textTheme.labelLarge,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: !hasPrefixIcon ? const EdgeInsets.fromLTRB(16, 10, 16, 10) : null,
        prefixIcon: hasPrefixIcon
            ? Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 10, 0),
                child: ValueListenableBuilder(
                  valueListenable: isFocus,
                  builder: (context, isFocus, child) {
                    return CircleAvatar(
                      radius: 16,
                      backgroundColor: isFocus ? Palette.tertiary : Palette.divider,
                      child: Icon(
                        widget.prefixIcon,
                        color: isFocus ? Palette.background : Palette.disabled,
                        size: 22,
                      ),
                    );
                  },
                ),
              )
            : null,
        suffixIcon: hasSuffixIcon
            ? GestureDetector(
                onTap: widget.onSuffixIconTap,
                child: Icon(
                  widget.suffixIcon,
                  size: 22,
                ),
              )
            : null,
      ),
      validator: widget.validators != null ? FormBuilderValidators.compose(widget.validators!) : null,
      onTap: widget.onTap,
    );
  }
}
