// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extension/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/theme/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/theme/text_theme.dart';

class PasswordField extends StatefulWidget {
  final String name;
  final String label;
  final String? initialValue;
  final String? hintText;
  final TextInputAction textInputAction;
  final IconData? prefixIcon;
  final List<String? Function(String?)>? validators;

  const PasswordField({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    this.hintText,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.validators,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late final ValueNotifier<bool> isFocus;
  late final ValueNotifier<bool> isVisible;

  @override
  void initState() {
    super.initState();

    isFocus = ValueNotifier(false);
    isVisible = ValueNotifier(false);
  }

  @override
  void dispose() {
    isFocus.dispose();
    isVisible.dispose();

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
        const Gap(6),
        if (widget.prefixIcon != null)
          Focus(
            onFocusChange: (value) => isFocus.value = value,
            child: buildPasswordField(),
          )
        else
          buildPasswordField()
      ],
    );
  }

  ValueListenableBuilder buildPasswordField() {
    final hasPrefixIcon = widget.prefixIcon != null;

    return ValueListenableBuilder(
      valueListenable: isVisible,
      builder: (context, isVisible, child) {
        return FormBuilderTextField(
          name: widget.name,
          obscureText: !isVisible,
          initialValue: widget.initialValue,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: widget.textInputAction,
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
            suffixIcon: GestureDetector(
              onTap: () => this.isVisible.value = !isVisible,
              child: Icon(
                isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                size: 22,
              ),
            ),
          ),
          validator: widget.validators != null ? FormBuilderValidators.compose(widget.validators!) : null,
        );
      },
    );
  }
}
