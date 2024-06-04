// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/src/presentation/features/auth/providers/repositories_provider/auth_repository_provider.dart';

part 'sign_in_provider.g.dart';

@riverpod
class SignIn extends _$SignIn {
  @override
  AsyncValue<bool?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final result = await ref.watch(authRepositoryProvider).signIn(
          username: username,
          password: password,
        );

    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}
