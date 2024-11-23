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
  final String name;
  final String label;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? hintText;
  final bool hasPrefixIcon;
  final IconData? prefixIcon;
  final bool hasSuffixIcon;
  final IconData? suffixIcon;
  final List<String? Function(String?)>? validators;
  final VoidCallback? onTap;

  const CustomField({
    super.key,
    required this.name,
    required this.label,
    this.textInputType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.hintText,
    this.hasPrefixIcon = true,
    this.prefixIcon,
    this.hasSuffixIcon = true,
    this.suffixIcon,
    this.validators,
    this.onTap,
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
    super.dispose();

    isFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: textTheme.labelMedium?.primary.bold,
        ),
        Gap(6),
        if (widget.hasPrefixIcon)
          Focus(
            onFocusChange: (value) => isFocus.value = value,
            child: _buildCustomTextField(),
          )
        else
          _buildCustomTextField()
      ],
    );
  }

  FormBuilderTextField _buildCustomTextField() {
    return FormBuilderTextField(
      name: widget.name,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      textAlignVertical: TextAlignVertical.center,
      style: textTheme.labelLarge,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: !widget.hasPrefixIcon ? const EdgeInsets.fromLTRB(16, 10, 16, 10) : null,
        prefixIcon: widget.hasPrefixIcon
            ? Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 14,
                  end: 10,
                ),
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
        suffixIcon: widget.hasSuffixIcon
            ? Icon(
                widget.suffixIcon,
                size: 22,
              )
            : null,
      ),
      validator: widget.validators != null ? FormBuilderValidators.compose(widget.validators!) : null,
      onTap: widget.onTap,
    );
  }
}
