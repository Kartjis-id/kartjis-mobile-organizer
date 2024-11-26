// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/extensions/context_extension.dart';
import 'package:kartjis_mobile_organizer/core/extensions/text_style_extension.dart';
import 'package:kartjis_mobile_organizer/core/routes/route_names.dart';
import 'package:kartjis_mobile_organizer/core/themes/color_scheme.dart';
import 'package:kartjis_mobile_organizer/core/themes/text_theme.dart';
import 'package:kartjis_mobile_organizer/core/utils/asset_path.dart';
import 'package:kartjis_mobile_organizer/core/utils/keys.dart';
import 'package:kartjis_mobile_organizer/features/auth/presentation/providers/login_provider.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/brutalism_button.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/input_fields/custom_field.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/input_fields/password_field.dart';
import 'package:kartjis_mobile_organizer/shared/widgets/svg_asset.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginProvider, (_, state) {
      state.when(
        loading: () => context.showLoadingDialog(),
        error: (error, stackTrace) => context.showErrorSnackBar('$error'),
        data: (isLogin) {
          if (isLogin != null && isLogin) {
            navigatorKey.currentState?.pushReplacementNamed(dashboardRoute);
          }
        },
      );

      if (!state.isLoading) {
        navigatorKey.currentState?.pop();
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Header(),
            _Form(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: _CustomClipPath(),
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
          clipper: _CustomClipPath(),
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
                  '\t${context.localization.loginDesc}',
                  style: textTheme.bodyMedium!.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Form extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            CustomField(
              name: 'username',
              label: context.localization.usernameFieldLabel,
              hintText: context.localization.usernameFieldHint,
              prefixIcon: Icons.person_rounded,
              textInputType: TextInputType.visiblePassword,
              textCapitalization: TextCapitalization.none,
              validators: [
                FormBuilderValidators.required(
                  errorText: context.localization.requiredFieldValidator,
                ),
              ],
            ),
            Gap(16),
            PasswordField(
              name: 'password',
              label: context.localization.passwordFieldLabel,
              hintText: context.localization.passwordFieldHint,
              prefixIcon: Icons.lock_rounded,
              textInputAction: TextInputAction.done,
              validators: [
                FormBuilderValidators.required(
                  errorText: context.localization.requiredFieldValidator,
                ),
              ],
            ),
            Gap(20),
            BrutalismButton(
              title: context.localization.login,
              primaryColor: Palette.primary,
              borderColor: Palette.primary,
              layerColor: Palette.scaffoldBackground,
              layerSpace: 3,
              onTap: () => login(ref),
            ),
          ],
        ),
      ),
    );
  }

  void login(WidgetRef ref) {
    // if (formKey.currentState!.saveAndValidate()) {
    //   final data = formKey.currentState!.value;

    //   ref.read(loginProvider.notifier).login(
    //         username: data['username'],
    //         password: data['password'],
    //       );
    // }

    navigatorKey.currentState?.pushReplacementNamed(dashboardRoute);
  }
}

class _CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, h * 0.4);
    path.lineTo(w, h);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
