// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utils/asset_path.dart';
import 'package:kartjis_mobile_organizer/features/auth/presentation/providers/login_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/brutalism_button.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/custom_clip_path.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/custom_field.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Header(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomField(
                      name: 'username',
                      label: 'Username',
                      hintText: AppLocalizations.of(context)!.usernameFieldHint,
                      prefixIcon: Icons.person_rounded,
                      hasSuffixIcon: false,
                      textInputType: TextInputType.visiblePassword,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: AppLocalizations.of(context)!.requiredFieldValidator,
                        ),
                      ],
                    ),
                    Gap(16),
                    CustomField(
                      name: 'password',
                      label: 'Password',
                      hintText: AppLocalizations.of(context)!.usernameFieldHint,
                      prefixIcon: Icons.person_rounded,
                      hasSuffixIcon: false,
                      textInputType: TextInputType.visiblePassword,
                      validators: [
                        FormBuilderValidators.required(
                          errorText: AppLocalizations.of(context)!.requiredFieldValidator,
                        ),
                      ],
                    ),
                    Gap(16),
                    BrutalismButton(
                      title: AppLocalizations.of(context)!.login,
                      primaryColor: Palette.primary,
                      borderColor: Palette.primary,
                      layerColor: Palette.scaffoldBackground,
                      layerSpace: 3,
                      onTap: () => login(ref, formKey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login(WidgetRef ref, GlobalKey<FormBuilderState> formKey) {
    FocusManager.instance.primaryFocus?.unfocus();

    if (formKey.currentState!.saveAndValidate()) {
      final data = formKey.currentState!.value;

      ref.read(loginProvider.notifier).login(
            username: data['username'],
            password: data['password'],
          );
    }
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            height: 255,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetPath.getImage('login_bg.png'),
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            height: 255,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Palette.primary.withOpacity(.5),
                  Palette.primary.withOpacity(.8),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgAsset(
                  AssetPath.getIcon('kartjis_filled.svg'),
                ),
                Gap(24),
                Text(
                  'KARTJIS',
                  style: TextStyle(
                    fontFamily: 'Titillium Web',
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    height: 1,
                    color: Palette.primary,
                  ),
                ),
                Text(
                  '\t${AppLocalizations.of(context)!.loginDesc}',
                  style: textTheme.bodyLarge?.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
