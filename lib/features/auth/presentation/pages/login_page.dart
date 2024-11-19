// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/features/auth/presentation/providers/login_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(loginProvider, (_, state) {
      state.when(
        error: (error, _) {
          debugPrint('$error');
        },
        loading: () {
          // show loading indicator
        },
        data: (data) {
          if (data != null) debugPrint('login success: $data');
        },
      );
    });

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: FormBuilder(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                name: 'username',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Username'),
                ),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                name: 'password',
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Password'),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: login,
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
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
